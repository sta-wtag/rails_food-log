class CreateAuditLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :audit_logs do |t|
      t.string :backtrace
      t.string :data
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
