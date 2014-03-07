class Weather.Views.SunAverage extends Backbone.View
  template: JST['javascripts/src/templates/sun_average.jst']

  render: ->
    template = @template(@model)
    @$el.html(template)
    @