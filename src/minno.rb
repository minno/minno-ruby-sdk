#!/usr/bin/env ruby
#
# Copyright 2011 Minno, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
#
# Author: Calvin Young <calvin@minno.co>

require "json"
require "net/https"

module Minno
  def Minno.is_purchase_valid?(user_id, invitem_id, verif_token)
    # Returns a boolean indicating whether the purchase was valid.
    #
    # Performs a synchronous GET request to the Minno purchase verification
    # endpoint.
    #
    # Args:
    #     user_id, string: the user whose purchase we are validating
    #     invitem_id, string: the id of the inventory item the user purchased
    #     verif_token, string: the temporary verification token used to validate
    #         the purchase
    #
    # Returns:
    #     bool: True of the user purchased the item, False otherwise
    #
    if user_id == nil || invitem_id == nil || verif_token == nil
      return false
    end

    # Query the Minno purchase-verification endpoint with the user_id,
    # invitem_id, and verif_token
    https = Net::HTTP.new("www.minno.co", 443)
    https.use_ssl = true
    https.verify_mode = OpenSSL::SSL::VERIFY_PEER
    response = https.request_get("/p/%s/%s?verifToken=%s" % [user_id,
                                                            invitem_id,
                                                            verif_token])
    # Parse the response to JSON so we can read the isValid flag
    json_response = JSON.parse(response.body)

    return json_response["isValid"]
  end
end
