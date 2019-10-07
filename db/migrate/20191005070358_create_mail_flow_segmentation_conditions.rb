class CreateMailFlowSegmentationConditions < ActiveRecord::Migration[6.0]
  def change
    create_table :mail_flow_segmentation_conditions do |t|
      t.references :mail_flow_segmentation_group, null: false, foreign_key: true, index: { name: 'index_mail_flow_segmentation_conditions_segmentation_group_id' }
      t.string :customer_attribute
      t.string :kind, null: false
      t.string :rule, null: false
      t.string :value, null: false
      t.string :second_value

      t.timestamps
    end
  end
end
