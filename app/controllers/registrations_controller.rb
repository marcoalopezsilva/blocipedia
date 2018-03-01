class RegistrationsController < Devise::RegistrationsController

include ChargesHelper

    def edit
        @stripe_btn_data = {
        key: "#{ Rails.configuration.stripe[:publishable_key] }",
        description: "Premium Membership - #{current_user.email}",
        amount: Amount.default
        }
    end

end
