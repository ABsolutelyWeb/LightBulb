class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id       # Tie the two tables together. For each profile, we have a user id.
      
      t.string :first_name
      t.string :last_name
      t.string :job_title
      t.text :description
      
      # Premium content
      t.string :contact_email  # Only seen by premium users. 
      t.string :phone_number   # Only seen by premium users.
      
      t.timestamps
    end
  end
end
