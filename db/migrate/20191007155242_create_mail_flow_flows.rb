class CreateMailFlowFlows < ActiveRecord::Migration[6.0]
  def change
    create_table :mail_flow_flows do |t|
      t.string :name, null: false
      t.boolean :active, default: false, null: false

      t.timestamps
    end
  end
end
