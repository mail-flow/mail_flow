class CreateMailFlowCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :mail_flow_customers do |t|
      t.integer :original_id
      t.string :email
      t.string :name
      t.string :first_name
      t.string :family_name
      t.string :phone_number
      t.string :address
      t.string :zip
      t.string :city
      t.jsonb :customer_fields, default: {}
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
    add_index :mail_flow_customers, :original_id, unique: true
    add_index :mail_flow_customers, :email
    add_index :mail_flow_customers, :customer_fields
    add_index :mail_flow_customers, :name
    add_index :mail_flow_customers, :phone_number
    execute "CREATE INDEX mail_flow_customers_customer_fields ON mail_flow_customers USING GIN(customer_fields)"
  end
end
