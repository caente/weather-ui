class Weather.Views.DataView extends Backbone.View

  template: JST['javascripts/src/templates/data.jst']

  events:
    'click #update' : 'update'


  render: ->
    template = @template()
    @$el.html(template)
    @

  validate_date_range: (start_date,end_date)->
    d1 = Date.parse(start_date)
    d2 = Date.parse(end_date)
    interval = d2 - d1
    days = Math.floor(interval / (1000 * 60 * 60 * 24))
    console.log(days)
    days


  update: ->
    start_date = $("#start_date").val()
    end_date = $("#end_date").val()
    zip = $("#zip").val()
    days = @validate_date_range(start_date,end_date)
    if(days <= 25)
      Weather.References.Charts.update_queries
        start_date: start_date,
        end_date: end_date,
        zip: zip
      Weather.References.Charts.update_graphs()
    else
      Weather.References.Charts.limit_reached("The date range has to be less or equals than 25 days, " + days + " are too many")

