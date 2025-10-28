class CreateHackathonEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :hackathon_events do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :event_type, null: false, default: 0
      t.datetime :scheduled_at, null: false, index: true
      t.integer :duration
      t.string :meeting_link
      t.string :video_url
      t.integer :status, null: false, default: 0, index: true

      t.timestamps
    end
  end
end
