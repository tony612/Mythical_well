$(function(){
  var names = [];
  var names_existed = [];
  var author_data = {'login': $('.event .author a').text(), 'name': $('.event .author a').data('name')}
  names.push(author_data);
  names_existed.push(names[0])
  $('.comments tr a.name').each(function(id){
    var user_data = {'login': $(this).text(), 'name': $(this).data('name')};
    if($.inArray(user_data, names_existed) < 0){
      names_existed.push(user_data);
      names.push(user_data);
    }
  });
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
});
