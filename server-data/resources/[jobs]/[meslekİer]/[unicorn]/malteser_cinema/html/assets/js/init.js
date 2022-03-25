$(document).ready(function(){
  $('#cinema').hide();
  window.addEventListener('message', function(event) {
      if (event.data.action == 'open') {
        console.log(event.data.action);
        $('#cinema').show();
      } else if (event.data.action == 'close') {
        console.log(event.data.action);
        $('#cinema').hide();
      }
  });
});
