# Code originally created by the awesome members of Ubersicht community.
# I stole from so many I can't remember who you are, thank you so much everyone!
# Haphazardly adjusted and mangled by Pe8er (https://github.com/Pe8er)

# Countdown code taken from https://github.com/anuragbakshi/Countdown-Widget

options =
  # Easily enable or disable the widget.
  widgetEnable: true

  # Add more countdowns
  countdowns: [
    # {
    #   label: "Example"
    #   time: "Feb 2, 2018 13:35:00"
    # },
    {
      label: ""
      time: "Mar 30, 2018"
    },
  ]

MILLIS_IN_DAY: 24 * 60 * 60 * 1000
MILLIS_IN_HOUR: 60 * 60 * 1000
MILLIS_IN_MINUTE: 60 * 1000
MILLIS_IN_SECOND: 1000

command: ""

refreshFrequency: '1m'

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

  #outer
    padding 8px
    display flex
    flex-direction column

  .box
    margin 3px 0

  .box:first-of-type
    margin-top 0

  .box:last-of-type
    margin-bottom 0

  .countdown
    position: relative
    font-size 8pt
    line-height 11pt
    color white
    align-items center
    justify-content center
    display flex

  .time
    float left
    text-align center
    color white05
    margin 0 10px

  .time span
    display block

  .time span:first-of-type
    font-weight 500
    color white

  .title
    font-weight 700
    color white
    font-size 8pt
    text-align center
    display block
    margin-bottom 5px
"""

options : options

render: (output) ->

  # Initialize our HTML.
  elapsedHTML = ''

  # Get our pieces.
  values = output.slice(0,-1).split(" ")

  # Create the DIVs for each piece of data.
  elapsedHTML = "
    <div id='outer'>
    </div>
  "
  return elapsedHTML

afterRender: ->
	for countdown in @options.countdowns
		countdown.millis = new Date(countdown.time).getTime()

# Update the rendered output.
update: (output, domEl) ->

  # Get our main DIV.
  div = $(domEl)

  if @options.widgetEnable
    # Get our pieces.
    values = output.slice(0,-1).split(" ")

    # Initialize our HTML.
    elapsedHTML = ''

    $countdownList = $(domEl).find("#outer")
    $countdownList.empty()

    now = new Date().getTime()

    # $root.html new Date
    # $root.html new Date @countdowns[1].time
    for countdown in @options.countdowns
      millisUntil = countdown.millis - now
      timeUntil = {}

      timeUntil.days = millisUntil // @MILLIS_IN_DAY
      millisUntil %= @MILLIS_IN_DAY

      timeUntil.hours = millisUntil // @MILLIS_IN_HOUR
      millisUntil %= @MILLIS_IN_HOUR

      timeUntil.minutes = millisUntil // @MILLIS_IN_MINUTE
      millisUntil %= @MILLIS_IN_MINUTE

      # timeUntil.seconds = millisUntil // @MILLIS_IN_SECOND
      # millisUntil %= @MILLIS_IN_SECOND

      $countdownList.append("""
        <div class='box'>
          <span class='title'>#{countdown.label}</span>
          <div class='countdown'>
            <div class='time'>
              <span>#{timeUntil.days}</span>
              <span>days</span>
            </div>
            <div class='time'>
              <span>#{timeUntil.hours}</span>
              <span>hours</span>
            </div>
            <div class='time'>
              <span>#{timeUntil.minutes}</span>
              <span>minutes</span>
            </div>
          </div>
        </div>
      """)

    # Sort out flex-box positioning.
    div.parent('div').css('order', '2')
    div.parent('div').css('flex', '0 1 auto')
  else
    div.remove()
