Minno Ruby SDK
================

This is the basic Ruby SDK for synchronous server-side integration with Minno.

For more information, visit our [API Documentation page](https://www.minno.co/docs).

Usage
-----

This SDK contains a single function `is_purchase_valid?()` that returns a
boolean indicating whether the purchase was valid. To start, here is an example
of its server-side usage:

    require "./minno.rb"

    # Receive these POST variables from your minnoCallback() Javascript function
    user_id = params[:userId]
    invitem_id = params[:invitemId]
    verif_token = params[:verifToken]

    if Minno.is_purchase_valid?(user_id, invitem_id, verif_token)
        # Deliver the purchased item to your user!
    else
        # Oops, the user hasn't purchased this item!
    end

After a user completes a purchase, we call the client-side `minnoCallback()`
function with the `userId`, `invitemId`, and `verifToken` as arguments. You can
then POST these arguments to your server endpoint, which uses our SDK to verify
the purchase before giving the user access to your premium item.

The implementation of the verification is very simple--it uses Ruby's net/https
module to perform a synchronous GET request to our purchase-verification
endpoint.

Feedback
--------

If you have any questions or comments about this package, feel free to email us
at support@minno.co! We'd love to hear your thoughts!
