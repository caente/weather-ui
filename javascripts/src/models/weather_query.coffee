class Weather.Models.WeatherQuery extends Backbone.Model

  initialize: (options) ->
    @start_date = options.start_date
    @end_date =options.end_date
    @zip = options.zip
    @endpoint = options.endpoint

  url: ->
    Weather.References.Constants.root_url + "/" + @endpoint + "?start_date=" + @start_date + "&end_date=" + @end_date + "&zip=" + @zip