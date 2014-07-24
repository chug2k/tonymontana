# Switcher widget written by Juha Mustonen / SC5

# Switches (reloads to another address) the dashboards in periodic manner
# <div id="container" data-switcher-interval="10000" data-switcher-dashboards="dashboard1 dashboard2">
#   <%= yield %>
# </div>
#
class DashboardSwitcher
  constructor: () ->
    @dashboardNames = []
    # Collect the dashboard names from attribute, if provided (otherwise skip switching)
    names = $('[data-switcher-dashboards]').first().attr('data-switcher-dashboards') || ''
    if names.length > 1
      # Get names separated with comma or space
      @dashboardNames = (name.trim() for name in names.sub(' ', ',').split(','))

  start: (interval=60000) ->
    self = @
    @maxPos = @dashboardNames.length - 1

    # Skip switching if no names defined
    if @dashboardNames.length == 0
      return

    # Take the dashboard name from that last part of the path
    pathParts = window.location.pathname.split('/')
    @curName = pathParts[pathParts.length - 1]
    @curPos = @dashboardNames.indexOf(@curName)

    # If not found, default to first
    if @curPos == -1
      @curPos = 0
      @curName = @dashboardNames[@curPos]

    # Start loop
    @handle = setTimeout(() ->
      # Increase the position or reset back to zero
      self.curPos += 1
      if self.curPos > self.maxPos
        self.curPos = 0

      # Switch to new dashboard
      self.curName = self.dashboardNames[self.curPos]
      window.location.pathname = "/#{self.curName}"

    , parseInt(interval, 10))


# Switches (hides and shows) elements within on list item
# <li switcher-interval="3000">
#   <div widget-1></div>
#   <div widget-2></div>
#   <div widget-3></div>
# </li>
#
# Supports optional switcher interval, defaults to 5sec
class WidgetSwitcher
  constructor: (@elements) ->
    @$elements = $(elements)

  start: (interval=5000) ->
    self = @
    @maxPos = @$elements.length - 1;
    @curPos = 0

    # Show only first at start
    self.$elements.slice(1).hide()

    # Start loop
    @handle = setInterval(()->
      # Hide all at first - then show the current and ensure it uses table-cell display type
      self.$elements.hide()
      $(self.$elements[self.curPos]).show().css('display', 'table-cell')

      # Increase the position or reset back to zero
      self.curPos += 1
      if self.curPos > self.maxPos
        self.curPos = 0

    , parseInt(interval, 10))

  stop: () ->
    clearInterval(@handle)


# Dashboard loaded and ready
Dashing.on 'ready', ->
  # If multiple widgets per list item, switch them periodically
  $('.gridster li').each (index, listItem) ->
    $listItem = $(listItem)
    # Take the element(s) right under the li
    $widgets = $listItem.children('div')
    if $widgets.length > 1
      switcher = new WidgetSwitcher $widgets
      switcher.start($listItem.attr('data-switcher-interval') or 5000)

  # If multiple dashboards defined (using data-swticher-dashboards="board1 board2")
  $container = $('#container')
  ditcher = new DashboardSwitcher()
  ditcher.start($container.attr('data-switcher-interval') or 60000)
