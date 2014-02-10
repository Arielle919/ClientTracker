class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :appointment
      t.string :tasks
      t.string :need_appointment
      t.string :task_completed
    end
  end
end
