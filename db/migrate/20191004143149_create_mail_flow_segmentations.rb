class CreateMailFlowSegmentations < ActiveRecord::Migration[6.0]
  def change
    create_table :mail_flow_segmentation do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
