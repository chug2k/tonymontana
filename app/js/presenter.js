(function() {
  var add, list, root, template;

  list = new List();

  template = $("[type='html/list']").html();

  root = $("#list");

  $('#add_item').click(function() {
    var str;
    str = $.trim($('#new_item').val());
    list.add(str);
    return $('#new_item').val('');
  });

  $("#new_item").keyup(function(e) {
    var str;
    str = $.trim(this.value);
    if (e.which === 13 && str) {
      list.add(str);
      return this.value = "";
    }
  });

  add = function(item) {
    return $($.render(template, item)).appendTo(root);
  };

  list.on("add", add);

}).call(this);
