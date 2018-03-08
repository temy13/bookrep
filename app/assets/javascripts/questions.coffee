# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->


  # if ($('#question').exists())
  #   html2canvas(document.querySelector('#question')).then (canvas) ->
  #     #document.body.appendChild canvas
  #     imageData = canvas.toDataURL('image/png')
  #     id = location.href.replace(location.protocol + "//" + location.host + "/questions/", "")
  #     $.ajax
  #       url: location.protocol + "//" + location.host + "/questions/add_image"
  #       type: 'POST'
  #       data: field:
  #         id: id
  #         data: imageData
  #       dataType: 'json'

  if ($('#questions').exists())
    page = getUrlParameter("page")
    if !page
      return
    $('.tab-contents-item').css 'display', 'none'
    $('.tab li').removeClass 'select'
    if page == "page_1"
      $('#unanswered-questions').css 'display', 'block'
      $('#unanswered-questions-tab').addClass 'select'
    else if page == "page_2"
      $('#answered-questions').css 'display', 'block'
      $('#answered-questions-tab').addClass 'select'
