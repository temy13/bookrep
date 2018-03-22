# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#new_question').submit ->
    console.log "submit"
    $.each $('#request-users-tags').children(), (index, dom) ->
      e = $(dom)
      user = e.data()
      $('<input>').attr({
        type: 'hidden',
        id: 'question_requests_attributes_' + index + '_name',
        name: 'question[requests_attributes][' + index + '][name]'
        value: user.sname
      }).appendTo('#new_question');
      $('<input>').attr({
        type: 'hidden',
        id: 'question_requests_attributes_' + index + '_uid',
        name: 'question[requests_attributes][' + index + '][uid]'
        value: user.uid
      }).appendTo('#new_question');

    return true

  # if ($('#question').exists())
  #   # html2canvas($("#question")).then (canvas) ->
  #   html2canvas(document.querySelector('#question')).then (canvas) ->
  #     document.body.appendChild canvas
  #     #console.log $("#question")).getBoundingClientRect()
  #     console.log document.querySelector('#question').getBoundingClientRect()
  #     imageData = canvas.toDataURL('image/png')
  #     id = location.href.replace(location.protocol + "//" + location.host + "/questions/", "")
  #     $.ajax
  #       url: location.protocol + "//" + location.host + "/questions/add_image"
  #       type: 'POST'
  #       data: field:
  #         id: id
  #         data: imageData
  #       dataType: 'json'

  # if ($('#questions').exists())
  #   page = getUrlParameter("page")
  #   if !page
  #     return
  #   $('.tab-contents-item').css 'display', 'none'
  #   $('.tab li').removeClass 'select'
  #   if page == "page_1"
  #     $('#unanswered-questions').css 'display', 'block'
  #     $('#unanswered-questions-tab').addClass 'select'
  #   else if page == "page_2"
  #     $('#answered-questions').css 'display', 'block'
  #     $('#answered-questions-tab').addClass 'select'
