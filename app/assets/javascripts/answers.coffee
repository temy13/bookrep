# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



$ ->
  change_title = (title, id) ->
      $('#answer-title-input').val title
      $('#answer-title-input-form').val title
      $('#answer-book-id').val id
      $('#answer-title-tag').find(".title-tag").text title
      $('#answer-title-dummy-input').addClass("d-none")
      $('#answer-title-tag').removeClass("d-none")

  $('#answer-title-remove').on 'click', ->
      $('#answer-title-input').val null
      $('#answer-title-input-form').val null
      $('#answer-book-id').val null
      $('#answer-title-tag').find(".title-tag").text ""
      $('#answer-title-dummy-input').removeClass("d-none")
      $('#answer-title-tag').addClass("d-none")


  autoCompleteItem = (item) ->
    r = "<div class='answer-title-suggest-image col-2'><image src=" + item.imgurl + " /></div>"
    r += "<div class='answer-title-suggest-text col-10'>"
    r += "<div class='answer-title-suggest-title'>" + item.title + "</div>"
    r += "<div class='answer-title-suggest-authors'>" + item.authors + "</div>"
    r += "</div>"
    return r

  $('#answer-title-input').change ->
    $('#answer-title-input-form').val $("#answer-title-input").val()

  $('#answer_form').submit ->
    #validation
    if $('#answer-title-input-form').val() != ""
      return true
    if $('#answer-title-input').val() != ""
      $('#answer-title-input-form').val $('#answer-title-input').val()
      return true
    if $('#answer-title-tag').find(".title-tag").text() != ""
      $('#answer-title-input-form').val $('#answer-title-tag').find(".title-tag").text()
      return true
    $('#answer-title-input').addClass("input-error")
    $('input[type=submit]').css 'opacity': 1.0
    return false


  if ($('#answer-title-input').exists())
    $('#answer-title-input').on 'click', ->
      $("html,body").animate({scrollTop:$('#answer-title-input').offset().top - 20});

    $('#answer-title-input').autocomplete(
      source: '/answers/auto_complete.json'
      delay: 200
      minLength: 1
      # focus: (event, ui) ->
      #   change_title(ui.item.title, ui.item.id)
      #   false
      select: (event, ui) ->
        change_title(ui.item.title, ui.item.id)
        false
    ).data('ui-autocomplete')._renderItem = (ul, item) ->
      $('<li class="answer-title-suggest-item row">')
        .attr('data-value', item.title)
        .data('ui-autocomplete-item', item)
        .append('<a class="answer-title-suggest">' + autoCompleteItem(item) + '</a>')
        .appendTo ul
    return
