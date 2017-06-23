class CreateAudioRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :audio_records do |t|
      t.text :b64field
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
