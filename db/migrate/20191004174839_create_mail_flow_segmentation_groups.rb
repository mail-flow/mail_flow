class CreateMailFlowSegmentationGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :mail_flow_segmentation_groups do |t|
      t.references :mail_flow_segmentation, null: false, foreign_key: {to_table: :mail_flow_segmentation}, index: { name: 'index_mail_flow_segmentation_groups_mail_flow_segmentation_id' }
      t.string :kind, null: false

      t.timestamps
    end
  end
end
