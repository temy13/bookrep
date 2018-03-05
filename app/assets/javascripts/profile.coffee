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

  # $("#profile-checkbox-input")

# $(document).on("ready page:change", function() {
#     $('.tag-tooltip').tooltip("show");
# 		$('.tag-tooltip').tooltip("disable");
# });
