# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  if ($('#profile-posts').exists())
    page = getUrlParameter("page")
    if !page
      return
    $('.tab-contents-item').css 'display', 'none'
    $('.tab li').removeClass 'select'
    if page == "page_q"
      $('#profile-posts-q').css 'display', 'block'
      $('#profile-posts-q-tab').addClass 'select'
    else if page == "page_a"
      $('#profile-posts-a').css 'display', 'block'
      $('#profile-posts-a-tab').addClass 'select'

  $("#profile-checkbox-input").on 'change', ->
    if $(this).prop("checked") == true && $("#profile-email-input").val() == ""
      $('.email-tag-tooltip').tooltip("show")
      $('.email-tag-tooltip').tooltip("disable")
      # $('.email-tag-tooltip').tooltip("destroy")

  $("#profile-email-input").on 'change', ->
    if $("#profile-email-input").val() != ""
      $('.email-tag-tooltip').tooltip("hide")

  # gbTip = $('.email-tag-tooltip').tipr()
  # gbTip.unbind 'mouseenter mouseleave'



# $(document).on("ready page:change", function() {
# 		$('.tag-tooltip').tooltip("disable");
# });
