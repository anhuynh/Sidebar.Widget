# Code originally created by the awesome members of Ubersicht community.
# I stole from so many I can't remember who you are, thank you so much everyone!
# Haphazardly adjusted and mangled by Pe8er (https://github.com/Pe8er)

options =
  # Easily enable or disable the widget.
  widgetEnable: true

  # Set the start date to count from.
  theDate: "03/30/2018"

  title: ""

command: "osascript 'Sidebar.widget/Countdown.widget/Countdown.applescript' \"#{options.theDate}\""

refreshFrequency: '1h'

style: """
  white1 = rgba(white,1)
  white05 = rgba(white,0.5)
  white02 = rgba(white,0.2)
  black02 = rgba(black,0.2)

  width 176px
  overflow hidden
  white-space nowrap

  *, *:before, *:after
    box-sizing border-box

  .wrapper
    position: relative
    font-size 8pt
    line-height 11pt
    color white
    padding 8px
    align-items center
    justify-content center
    display flex

  .box
    float left
    text-align center
    color white05
    margin 0 10px

  .box span
    display block

  .box span:first-of-type
    font-weight 700
    color white

  #title
    color white
    font-size 8pt
    text-align center
    display block
    padding-bottom 2px
"""

options : options

render: (output) ->

  # Initialize our HTML.
  elapsedHTML = ''

  # Get our pieces.
  values = output.slice(0,-1).split(" ")

  # Create the DIVs for each piece of data.
  elapsedHTML = "
    <div>
      <span id='title'>" + @options.title + "</span>
      <div class='wrapper'>
        <div class='box'>
          <span>" + values[2] + "</span>
          <span>" + values[3] + "</span>
        </div>
        <div class='box'>
          <span>" + values[4] + "</span>
          <span>" + values[5] + "</span>
        </div>
      </div>
    </div>
  "
  return elapsedHTML

# Update the rendered output.
update: (output, domEl) ->

  # Get our main DIV.
  div = $(domEl)

  if @options.widgetEnable
    # Get our pieces.
    values = output.slice(0,-1).split(" ")

    # Initialize our HTML.
    elapsedHTML = ''

    # Sort out flex-box positioning.
    div.parent('div').css('order', '2')
    div.parent('div').css('flex', '0 1 auto')
  else
    div.remove()
