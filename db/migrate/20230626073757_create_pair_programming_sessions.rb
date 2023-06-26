class CreatePairProgrammingSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :pair_programming_sessions do |t|
      t.integer :project_id, null: false
      t.integer :host_user_id, null: false
      t.integer :visitor_user_id, null: false

      t.timestamps
    end

    add_foreign_key :pair_programming_sessions, :users, column: :host_user_id
    add_foreign_key :pair_programming_sessions, :users, column: :visitor_user_id
    add_foreign_key :pair_programming_sessions, :projects
  end
end
