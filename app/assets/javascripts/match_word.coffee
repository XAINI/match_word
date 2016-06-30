class Matching
  constructor: (@$eml) ->
    @bind_event()

  through_ajax_request: (fetch_value)->
    jQuery.ajax
      url: "/match_word/insert",
      method: "post",
      data: {fetched_value: fetch_value}
    .success(msg) ->
      console.log "success"
    .error(msg) ->
      console.log "failure"


  bind_event: ->
    @$eml.on "click", ".footer-button .submit_word", =>
      console.log "Hey man! Nice to see you."
      fetch_text_area_value = jQuery(".body .part-left textarea").val()
      @through_ajax_request(fetch_text_area_value)
      jQuery(".body .part-right textarea").val(fetch_text_area_value)





jQuery(document).on "ready page:load", ->
  if jQuery(".matching_word").length > 0
    new Matching jQuery(".matching_word")
  