class AddStripeCustomerTokenToUsers < ActiveRecord::Migration
  def change
    # Make a column for users and name it "stripe_customer_token"
    # and save it as a string.
    add_column :users, :stripe_customer_token, :string
  end
end
