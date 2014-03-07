class Weather.Router.MainRouter extends Backbone.Router

  routes:
    '': 'index'
    'home': 'index'

  initialize: ->
    console.log('starting router')


  find_location: (position) ->
    geocoder = new google.maps.Geocoder()
    latlng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
    console.log(latlng)
    geocoder.geocode({'latLng': latlng}, @decode_location)

  decode_location: (results, status) ->
    console.log(status)
    console.log(results)

  index: ->
    console.log("index")
    now = new Date()
    $("#zip").val("33020")
    $("#start_date").val($.datepicker.formatDate('mm/dd/yy', now))
    $("#end_date").val($.datepicker.formatDate('mm/dd/yy', now))
    $("#update").trigger("click")
#    Weather.References.Charts.update_queries
#      start_date:  $("#start_date").val(),
#      end_date: "2014-03-7",
#      zip: "33020"
#    Weather.References.Charts.update_graphs()




#    navigator.geolocation.getCurrentPosition(@find_location)





