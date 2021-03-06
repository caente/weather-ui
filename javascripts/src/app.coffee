window.Weather =
  Models: {}
  Views: {}
  Router: {}
  References:
    {
      Views: {
        HistoricView: {}
      }
      HistoricIds: {
        temp_chart: "historic_temp"
        rain_chart: "historic_rain"
      }
      Constants:
        {
          root_url: 'http://54.85.65.194:8080/weather'
#          root_url: 'http://localhost:8080/weather'
        }
      temperature_options:
        {
          label: "Temperature behavior (Fahrenheit/day)",
          id: "temp_chart",
          endpoint: "temperature"
        }
      rain_options:
        {
          label: "Rain behavior (inches/day)",
          id: "rain_chart",
          endpoint: "rain"
        }
      sun_options:
        {
          endpoint: "sun"
        }
    }

  initialize: ->
    console.log('starting...')
    Weather.References.Views.DataView = new Weather.Views.DataView() unless Weather.References.Views.DataView
    $("#data").html(Weather.References.Views.DataView.render().el)
    Weather.References.Charts = new Weather.Charts()
    new Weather.Router.MainRouter
    Backbone.history.start()
    console.log('done starting')




