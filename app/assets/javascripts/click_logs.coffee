# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("a[rel=book_affiliate]").on "click", ->
    data = $(this).data()
    $.ajax
      url: location.protocol + "//" + location.host + "/click_logs/book_affiliate"
      type: 'POST'
      data: field:
        user_id: data.userId
        answer_id: data.answerId
        book_id: data.bookId
      dataType: 'json'
