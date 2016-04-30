class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :plan
  has_one :profile
  attr_accessor :stripe_card_token # Allows usage of hidden field value to create customer in Stripe server
  def save_with_payment
    if valid?
      # Charges customer and returns an id for the customer.
      customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token)
      # Set user property equal to Stripe's ID
      self.stripe_customer_token = customer.id
      # Save the user
      save!
    end
  end
end
