
list = new List()
template = $("[type='html/list']").html()
root = $("#list")
$('#add_item').click ->
  str = $.trim($('#new_item').val())
  list.add(str)
  $('#new_item').val('')


$("#new_item").keyup (e) ->
  str = $.trim(this.value)
  if (e.which == 13 && str)
    list.add(str)
    this.value = ""


add = (item) ->
  $(riot.render(template, item)).appendTo(root)

list.on("add", add)



