# check this url
# https://stripe.com/docs/checkout#integration-custom
$(document).ready ->
  return unless StripeCheckout?

  # Keeps track of whether we're in the middle of processing
  # a payment or not. This way we can tell if the 'closed'
 
  # event was due to a successful token generation, or the user
  # closing it by hand.
  submitting = false

  payButton = $('.pay-button')
  form = payButton.closest('form')
  indicator = form.find('.indicator').height( form.outerHeight() )
  handler = null

  createHandler = ->
    handler = StripeCheckout.configure
      # Grab the correct publishable key. Depending on
      # the selection in the interface.
      key: window.publishable["platform"]

      # The email of the logged in user.
      email: window.currentUserEmail

      #class 'processing' is a icon which loading 
      allowRememberMe: false
      
      closed: ->
        form.removeClass('processing') unless submitting
      
      token: ( token ) ->
        submitting = true
        form.find('input[name=token]').val( token.id )
        form.get(0).submit()
  createHandler()

  payButton.click ( e ) ->
    e.preventDefault()
    form.addClass( 'processing' )

    handler.open
      name: 'お支払い額'
      description: window.totalPrice + " 円"
      amount: ''