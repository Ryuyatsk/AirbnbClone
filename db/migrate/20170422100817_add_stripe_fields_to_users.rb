class AddStripeFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :publishable_key, :string
    add_column :users, :secret_key, :string
    add_column :users, :stripe_user_id, :string
    add_column :users, :currency, :string
    add_column :users, :stripe_account_type, :string
  end
end
