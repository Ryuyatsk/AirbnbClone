class AddColumnToReservation < ActiveRecord::Migration[5.0]
  def change
    add_column :reservations, :self_booking, :boolean
  end
end
