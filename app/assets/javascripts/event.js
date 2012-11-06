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
});
