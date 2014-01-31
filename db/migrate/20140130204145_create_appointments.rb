class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.references :physician, index: true
      t.references :patient, index: true
      t.text :notes
      t.date :datetime

      t.timestamps
    end
  end
end
