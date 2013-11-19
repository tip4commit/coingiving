# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

init = () ->
  $('.qrcode').each () ->
    $(this).qrcode({text:$(this).attr('data-qrcode'), width:128, height:128});

$ init
$(document).on 'page:load', init