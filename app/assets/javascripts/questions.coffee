# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#reply").on　"click", ->
    $("#reply-input-box").slideToggle();
    if $("#reply-arrow-img").hasClass("appeared")
      $("#reply-arrow-img").removeClass('appeared');
      $("#reply-arrow-img").addClass 'disappeared';
    else
      $("#reply-arrow-img").addClass('appeared');
      $("#reply-arrow-img").removeClass 'disappeared';

  if ($('#question').exists())
    html2canvas(document.querySelector('#question')).then (canvas) ->
      #document.body.appendChild canvas
      imageData = canvas.toDataURL('image/png')
      id = location.href.replace(location.protocol + "//" + location.host + "/questions/", "")
      $.ajax
        url: location.protocol + "//" + location.host + "/questions/add_image"
        type: 'POST'
        data: field:
          id: id
          data: imageData
        dataType: 'json'
      # $.ajax
      #   url: location.href
      #   type: 'POST'
      #   data: message: id: message_id
      #   dataType: 'json'
      #   return

  # $('body').html2canvas();
  # queue = html2canvas.Parse();
  # canvas = html2canvas.Renderer(queue,{elements:{length:1}});
  # img = canvas.toDataURL();
  # window.open(img);
  # element = $('#question')
  # # global variable
  # getCanvas = undefined
  # # global variable
  # $('#question').on 'click', ->
  #   html2canvas element.get(0), onrendered: (canvas) ->
  #     $('#question').append canvas
  #     getCanvas = canvas
  #     return
  #   return
  # $('#btn-Convert-Html2Image').on 'click', ->
  #   imgageData = getCanvas.toDataURL('image/png')
  #   # Now browser starts downloading it instead of just showing it
  #   newData = imgageData.replace(/^data:image\/png/, 'data:application/octet-stream')
  #   $('#btn-Convert-Html2Image').attr('download', 'hogehoge.png').attr 'href', newData
  #   return


  # $(".hoge").button('loading')   #=> loading状態にしとく
  # html2canvas $("#question").get(0), onrendered: (canvas) ->
  #     console.log "c"
  #     canvasImage = canvas.toDataURL("image/png")
  #     $(".hoge").attr('href', canvasImage)
  #     $(".hoge").button('reset')    #=> 完了したらクリック可能状態に戻す
  # if ($('#question').exists())
  #   html2canvas $('#question').get(0), onrendered: (canvas) ->
  #     console.log "c"
  #     dataURI = canvas.toDataURL('image/png')
  #     # document.body.appendChild(canvas);
  #     console.log "a"
  #     console.log dataURI
  #     console.log "b"
  #     $('#question').attr('href', dataURI)
  #     return



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
