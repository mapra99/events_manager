class CreateAttendings < ActiveRecord::Migration[6.0]
  def change
    create_table :attendings, id: false do |t|
      t.integer :attendee_id
      t.integer :event_id
    end

    add_foreign_key :attendings, :users, column: :attendee_id
    add_foreign_key :attendings, :events, column: :event_id

    add_index :attendings, [:attendee_id, :event_id]    
  end
end
