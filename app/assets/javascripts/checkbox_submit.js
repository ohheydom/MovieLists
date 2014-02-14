$(document).ready(function(){
  $(document).on('change', 'input[type=checkbox]', function(){
    $(this).parents('form:first').submit();
    return false;
  });
});
