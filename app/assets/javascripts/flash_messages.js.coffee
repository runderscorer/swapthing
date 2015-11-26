jQuery ->
  setTimeout (->
    $('.notice-top, .alert-top, .renew-top, .error-top').slideUp 300
  ), 5000

  $('.notice-top, .error-top').on 'click', ->
    $(this).slideUp 300