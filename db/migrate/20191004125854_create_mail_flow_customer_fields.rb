class CreateMailFlowCustomerFields < ActiveRecord::Migration[6.0]
  def change
    create_table :mail_flow_customer_fields do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :mail_flow_customer_fields, :name, unique: true
  end
end
