# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  # (adsbygoogle = window.adsbygoogle or []).push
  #   google_ad_client: window.ENV.AdsenceCode
  #   enable_page_level_ads: true

  #クリックしたときのファンクションをまとめて指定
  $('.tab li').click ->
    #.index()を使いクリックされたタブが何番目かを調べ、
    #indexという変数に代入します。
    index = $('.tab li').index(this)
    #コンテンツを一度すべて非表示にし、
    $('.tab-contents-item').css 'display', 'none'
    #クリックされたタブと同じ順番のコンテンツを表示します。
    $('.tab-contents-item').eq(index).css 'display', 'block'
    #一度タブについているクラスselectを消し、
    $('.tab li').removeClass 'select'
    #クリックされたタブのみにクラスselectをつけます。
    $(this).addClass 'select'
    return

  $('.owl-carousel').owlCarousel
    loop: true
    margin: 10
    responsiveClass:true
    autoplay:true
    autoplayTimeout:3000
    responsive:
      0:
        items: 1
        nav: false

  #
  # $('input[type=submit]').click (e) ->
  #   #e.preventDefault()
  #   $('input[type=submit]').css 'opacity': 1.0
  #   $(this).css 'opacity': '.5'
  #   return

  $('form[data-validate]').on 'input', ->
    $(this).find(':submit').attr 'disabled', !@checkValidity()
    return

  $ ->
    $('input[type=submit]').on 'click', ->
      $('input[type=submit]').css 'opacity': 1.0
      form = $(this).parents('form')
      form.attr 'action', $(this).data('action')
      if form.valid()
        $(this).css 'opacity': '.5'
      input = $("<input>").attr("type", "hidden").attr("name", "submit_type").val($(this).attr("name"))
      form.append(input)
      form.submit()
      return
    return

  $('#notice-close').click ->
    $('.notice').fadeOut 100
    return

  # $('.notice').hover (->
  #   $('.notice').css('display', 'none').fadeOut 1000
  #   return
  # ), ->
  #   $('.notice').css('display', 'none').fadeOut 1000
  #   return
  # return
