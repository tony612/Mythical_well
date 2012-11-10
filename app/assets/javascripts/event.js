$(function(){
  var names = [];
  var names_existed = [];
  var author_data = {'login': $('.event .author a').text(), 'name': $('.event .author a').data('name')}
  names.push(author_data);
  names_existed.push(author_data.login)
  $('.comments tr a.name').each(function(id){
    var user_data = {'login': $(this).text(), 'name': $(this).data('name')};
    if($.inArray(user_data.login, names_existed) < 0){
      names_existed.push(user_data.login);
      names.push(user_data);
    }
  });
  console.log(names);
  console.log(names_existed);
  var emojis = ["smile", "heart"];
  //names = $.map(names,function(value,i) {
    //return {'id':i,'name':value,'email':value+"@email.com"};
  //});
  $("#comment_content").atWho('@', {
    tpl: "<li data-value='${login}'>${login} <small>${name}</small></li>",
    'data': names,
    'limit': 7
  }).atWho(':', {
    'data': emojis  
  });
  $('#event_tag_tokens').tokenInput('/tags.json', { 
    hintText: "输入标签",
    searchingText: "查找中",
    theme: 'facebook',
    prePopulate: $('#event_tag_tokens').data('load')
  });

  ////////////////////
  var dates_arr = []
  handle_after_select = function(){
    console.log(this.getSelected());
    $('.date-show').html("时间为：" + this.getSelected());
    $('.date-desc').val(this.getSelected());
    if($('.date-type').val() === 'multi' && $('.date-repeat').val() === 'no'){
      arr_now = this.getSelectedAsText();
      console.log(arr_now);
      if(arr_now.length < dates_arr.length){
        for(i in dates_arr){
          pos = arr_now.indexOf(dates_arr[i]);
          console.log(pos);
          if(pos == -1) {
            $('.time-select tbody').children('tr').eq(i).remove();
          }
        }
      } else {
        for(i in arr_now){
          pos = dates_arr.indexOf(arr_now[i]);
          console.log(pos);
          if(pos == -1) {
            if(i == 0){
              $('.time-select tbody').prepend($('.time-select tbody tr:first-child').clone());
              $('.time-select tbody tr:first-child span').html(arr_now[0]);
            } else {
              $('.time-select tbody tr:nth-child('+i+')').after($('.time-select tbody tr:first-child').clone());
              $('.time-select tbody tr:eq('+i+') span').html(arr_now[i]);
            }
          }
            
        }
      }
      dates_arr = this.getSelectedAsText();
      console.log(dates_arr);
    } 
  }
  multi_attr = {
    months: 2,
    mode: 'multiple',
    direction: 'future',
    selected:[Kalendae.moment()],
    subscribe: {
      'change': handle_after_select
    }
  }
  range_attr = {
    months: 2,
    mode: 'range',
    direction: 'future',
    selected:[Kalendae.moment(), Kalendae.moment().add({w:1})],
    subscribe: {
      'change': handle_after_select
    }
  }
  repeat_attr = {
    months:2,
    mode: 'range',
    direction: 'future',
    format: 'YYYY-MM-DD',
    selected:[Kalendae.moment(), Kalendae.moment().add({w:1})],

  }
  var my_date_select = new Kalendae('calendar', multi_attr);
  dates_arr = my_date_select.getSelectedAsText();
  $('.date-show').html("时间为：" + my_date_select.getSelected());
  $('.date-desc').val(my_date_select.getSelected());
  $('.repeat_range').hide();
  $('.date-type').bind('change', function(){
    var val = this.value;
    var repeat = $('.date-repeat').val();
    $('.time-select tbody').find('tr:gt(0)').remove();
    switch(val){
      case 'multi':
        if(repeat === 'no'){
          $('.time-select tbody tr td:last-child').append("<span class='label label-info'>"+Kalendae.moment().format('YYYY-M-DD')+"</span>");
          $('#calendar').html('');
          my_date_select = new Kalendae('calendar', multi_attr);}
          $('.date-show').html("时间为：" + my_date_select.getSelected());
          $('.date-desc').val(my_date_select.getSelected());
          $('.repeat_range').hide();
        break;
      case 'range':
        $('.time-select tbody tr td span').remove();
        $('.repeat_range').hide();
        if(repeat === 'no'){
          
          $('#calendar').html('');
          my_date_select = new Kalendae('calendar', range_attr);
          $('.date-show').html("时间为：" + my_date_select.getSelected());
          $('.date-desc').val(my_date_select.getSelected());
        } else{
          $('.date-type').val('multi');
        }
        break;
    }
    dates_arr = my_date_select.getSelectedAsText();
  });
  $('.date-repeat').bind('change', function(){
    $('.time-select tbody tr td span').remove();
    var val = this.value;
    $('.time-select tbody').find('tr:gt(0)').remove();
    switch(val){
      case 'no':
        $('#calendar').html('');
        my_date_select = new Kalendae('calendar', multi_attr);
        $('.date-show').html("时间为：" + my_date_select.getSelected());
        $('.date-desc').val(my_date_select.getSelected());
        if($('.date-type').val() === 'multi'){
          $('.time-select tbody tr td:last-child').append("<span class='label label-info'>"+Kalendae.moment().format('YYYY-M-DD')+"</span>");
        }
        $('.repeat_range').hide();
        break;
      case 'week':
        $('.date-type').val('multi');
        $('#calendar').html('');
        my_date_select = new Kalendae('calendar', {
          month: 1,
          mode: 'multiple',
          directionScrolling: false,
          useYearNav: false,
          selected: Kalendae.moment(),
          blackout: function (date) {
            console.log(Kalendae.moment().format('w'))
            return Kalendae.moment(date).format('w')%(Kalendae.moment().format('w'))},
          subscribe: {
            'change': handle_after_select
          }
        });
        $('.date-show').html("时间为：" + my_date_select.getSelected());
        $('.date-desc').val(my_date_select.getSelected());
        new Kalendae.Input('repeat_range', repeat_attr);
        $('.repeat_range').show();
        break;
      case 'twoweek':
        $('.date-type').val('multi');
        $('#calendar').html('');
        my_date_select = new Kalendae('calendar', {
          month: 1,
          mode: 'multiple',
          directionScrolling: false,
          useYearNav: false,
          selected: Kalendae.moment(),
          blackout: function (date) {
            var week = Kalendae.moment();
            return Kalendae.moment(date).format('w')%week.format('w') && Kalendae.moment(date).format('w')%(week.add('w', 1).format('w'))},
          subscribe: {
            'change': handle_after_select
          }
        });
        $('.date-show').html("时间为：" + my_date_select.getSelected());
        $('.date-desc').val(my_date_select.getSelected());
        new Kalendae.Input('repeat_range', repeat_attr);
        $('.repeat_range').show();
        break;
      case 'month':
        $('.date-type').val('multi');
        $('#calendar').html('');
        my_date_select = new Kalendae('calendar', {
          month: 1,
          mode: 'multiple',
          directionScrolling: false,
          useYearNav: false,
          selected: Kalendae.moment(),
          blackout: function (date) {
            var week = Kalendae.moment();
            console.log(week.format('M'));
            return Kalendae.moment(date).format('M') % week.format('M')},
          subscribe: {
            'change': handle_after_select
          }
        });
        sth = new Kalendae('.kalendae');
        $('.date-show').html("时间为：" + my_date_select.getSelected());
        $('.date-desc').val(my_date_select.getSelected());
        new Kalendae.Input('repeat_range', repeat_attr);
        $('.repeat_range').show();
        break;
    }
  dates_arr = my_date_select.getSelectedAsText();
  });

});
