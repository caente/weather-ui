class Weather.Views.HistoricView extends Backbone.View

  template: JST['javascripts/src/templates/historic.jst']

  render: ->
    template = @template(@model)
    @$el.html(template)
    @