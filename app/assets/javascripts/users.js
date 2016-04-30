// Load document before executing jQuery functions.
$(document).ready(function() {
  
  // Grab the meta tag from html head and then use Stripe API to set a 
  // variable "setPublishableKey" to hold the contents of that meta tag.
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));

  // When users clicks submit (Sign Up on Premium), use the click function
  // to listen for events.
  $("#form-submit-btn").click(function(event) {

    // Prevent default form submit action.
    event.preventDefault();
    
    // Disable submit button after click so users don't accidentally send 
    // repeated data.
    $('input[type=submit]').prop('disabled', true);
    var error = false;
    
    // Store variables to hold the card data which were obtained from the form.
    var ccNum = $('#card_number').val(),
        cvcNum = $('#card_code').val(),
        expMonth = $('#card_month').val(),
        expYear = $('#card_year').val();

    // If there's no error, send the card information to Stripe
    // servers and then get back a token to store in our database.
    // NOTE: We are never storing the users' card information.
    if (!error) {
      // Get the Stripe token:
      Stripe.createToken({
        number: ccNum,
        cvc: cvcNum,
        exp_month: expMonth,
        exp_year: expYear
      }, stripeResponseHandler); // Run this function when Stripe returns with a token.
    }
    return false;
  }); // form submission
  
  // Handles the card token.
  function stripeResponseHandler(status, response) {
    // Get a reference to the form:
    var f = $("#new_user");

    // Get the token from the response:
    var token = response.id;

    // Add hidden field to form which will be the response.id
    // Add the token to the form:
    f.append('<input type="hidden" name="user[stripe_card_token]" value="' + token + '" />');

    // Submit the form:
    f.get(0).submit(); 
  }
});