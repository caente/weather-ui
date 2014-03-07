class Weather.Charts

  update_queries: (options) ->
    Weather.References.sun_options.start_date = options.start_date
    Weather.References.sun_options.end_date = options.end_date
    Weather.References.sun_options.zip = options.zip

    Weather.References.rain_options.start_date = options.start_date
    Weather.References.rain_options.end_date = options.end_date
    Weather.References.rain_options.zip = options.zip

    Weather.References.temperature_options.start_date = options.start_date
    Weather.References.temperature_options.end_date = options.end_date
    Weather.References.temperature_options.zip = options.zip


  limit_reached: (msg) ->
    template = JST['javascripts/src/templates/error.jst']
    $(".alert").html(template({
      msg: msg
    }))
    @show_alert()

  hide_alert: ->
    $('.alert').addClass("hide")

  show_alert: ->
    $('.alert').removeClass("hide")

  sunny_days: (options) ->
    sunnyModel = new Weather.Models.WeatherQuery(options)
    sunnyModel.fetch
      success: (percent) =>
        Weather.References.Views.SunAverage = new Weather.Views.SunAverage(model: percent.toJSON())
        $("#sunny_days").html(Weather.References.Views.SunAverage.render().el)
      error: (model,resp) =>
        @select_error_msg(resp.status)

  select_error_msg: (status) ->
    if status == 409
      @limit_reached("The limit of the Weather Service have been reach, wait a few seconds and try again.")
    else
      @limit_reached("No information found.")

  create_historic: (options) ->
    historicModel = new Weather.Models.WeatherQuery(options)
    historicModel.fetch
      success: (plot) =>
        data = plot.toJSON()
        Weather.References.Views.HistoricView[options.id] = new Weather.Views.HistoricView(model:
          label: options.label,
          chart_id: options.id) unless Weather.References.Views.HistoricView[options.id]
        container = Weather.References.HistoricIds[options.id]
        $("#" + container).html(Weather.References.Views.HistoricView[options.id].render().el)
        @draw_chart("#" + options.id, data.values, data.dates)
      error: (model,resp) =>
        @select_error_msg(resp.status)


  draw_chart: (id, data, labels) ->
    options = {
      scaleFontColor: "BLACK",
    }
    plot = {
      labels: labels,
      datasets: [
        {
          fillColor: "BLACK",
          strokeColor: "BLACK",
          pointColor: "WHITE",
          pointStrokeColor: "BLACK",
          data: data
        }
      ]
    }
    @create_chart(id, plot, options)

  create_chart: (id, data, options) ->
    ctx = $(id).get(0).getContext('2d')
    new Chart(ctx).Line(data, options)

  update_graphs: ->
    @sunny_days(Weather.References.sun_options)
    @create_historic(Weather.References.rain_options)
    @create_historic(Weather.References.temperature_options)