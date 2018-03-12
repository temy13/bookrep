$ ->

  replyToggle = () ->
    $("#reply-input-box").slideToggle();
    if $("#reply-arrow-img").hasClass("appeared")
      $("#reply-arrow-img").removeClass('appeared');
      $("#reply-arrow-img").addClass 'disappeared';
    else
      $("#reply-arrow-img").addClass('appeared');
      $("#reply-arrow-img").removeClass 'disappeared';

  $("#reply").on　"click", -> replyToggle()

  n = 10
  before_query = ""

  $(document).on 'click', '.option-add', ->
    v = $(this).data("value")
    console.log "add click: " + v
    $(".add-option-" + v).removeClass "hide"
    # $(".add-option-" + v).addClass "show"
    $(this).addClass "hide"

  setListItem = (index, user) ->
    img = user.image
    imgurl = img.scheme + "://" + img.host + img.path
    console.log "index: " + index
    console.log "show: " + index<10
    if index < 10
      r = "<li class='option-user-item row' >"
    else
      r = "<li class='option-user-item hide row add-option-" + Math.floor(index/n) + "' >"
    r += "<div class='col-3'><div class='option-user-image'><image src=" + imgurl + " /></div></div>"
    r += "<div class='option-names col-7'>"
    username = user.name
    name = if username.length < 8 then username else username.slice(0, 7) + "..."
    r += "<div class='option-user-name' >" + name + "</div>"
    r += "<div class='option-user-sname' >" + user.screen_name + "</div>"
    r += "<div class='option-user-uid' >" + user.uid + "</div></div>"
    r += "<div class='col-2'><div class='option-checkbox'><label><input class='checkbox option-checkbox-input' type='checkbox' name='" + user.screen_name + "' value='" + user.uid + "'>"
    r += "<span class='checkbox-icon'></span></label></div></div>"
    return r

  updateOptions = (cursor, force) ->
    cursor = cursor || -1
    force = force || false
    query = $("#reply-search").val()
    $.ajax
      url: 'reply_options'
      type: 'GET'
      data:
        cursor: cursor
        query: query
      dataType: 'json'
      success: (data) ->
        if cursor <= 0 && query == before_query && query != "" && !force
          return
        $('ul#option-users').empty()
        $.each data["options"], (index, val) ->
          i = index/n
          console.log "index: " + index
          console.log "i: " + i
          if index == n
            e =  $("<li id='option-add-" + i + "' class='option-user-item option-add' data-value='" + i + "'>もっと見る</li>")
            $('ul#option-users').append e
            return
          if index % n == 0 && index > 0
            e = $("<li id='option-add-" + i + "' class='option-user-item option-add hide add-option-" + (i-1) + "'  data-value='" + (i) + "'>もっと見る</li>")
            $('ul#option-users').append e
            return

          $('ul#option-users').append setListItem index, val
          return
        before_query = query
        return
      error : (XMLHttpRequest, textStatus, errorThrown) ->
        console.log("error");
        console.log("XMLHttpRequest : " + XMLHttpRequest.status);
        console.log("textStatus     : " + textStatus);
        console.log("errorThrown    : " + errorThrown.message);
        return


  #$("#reply-search").on 'change change keyup paste click', ->
  $("#reply-search").on 'change paste click keyup', ->
    if $("#reply-search").val().length > 2
      updateOptions()

  $("#reply-search").on 'click', ->
    $("html,body").animate({scrollTop:$('#reply-search').offset().top - 20});

  $("#user-search-exec").on　"click", -> updateOptions(-1, true)


  showModal = (event) ->
    event.preventDefault()
    $shade = $('<div></div>')
    $shade.attr('id', 'shade').on 'click', hideModal
    $modalWin = $('#modalwin')
    posX = ($("#center").width() - $modalWin.outerWidth()) / 2
    posY = $(window).height()/10
    $(".modal-close").on 'click', hideModal
    $(".modal-back-button").on 'click', hideModal

    updateOptions -1

    $modalWin.before($shade).css(
      left: posX
      top: posY).removeClass('hide').addClass('show').on 'click', 'button', ->
      hideModal()
      return
    $("html,body").animate({scrollTop:$('#modalwin').offset().top - 20});
    return

  showModalWQ = (event) ->
    replyToggle()
    showModal(event)
    return

  hideModal = ->
    users = $('.option-checkbox-input:checked').map(->
      console.log $(this)
      $(this).val()
      {"sname":$(this).context.name, "uid":$(this).val()}
    ).get()
    $.each users, (index, user) ->
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
    $('#shade').remove()
    $('#modalwin').removeClass('show').addClass 'hide'
    $("html,body").animate({scrollTop:$('#question_content').offset().top - 20});
    return

  $('.show-modal').on 'click', showModal
  $('.show-modal-wq').on 'click', showModalWQ
  return



# ---
# generated by js2coffee 2.2.0
