class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.string :name
      t.string :appointment
      t.string :tasks
      t.string :needAppointment
    end
  end
end