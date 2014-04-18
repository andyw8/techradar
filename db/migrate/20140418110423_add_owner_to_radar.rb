class AddOwnerToRadar < ActiveRecord::Migration
  def change
    add_reference :radars, :owner, index: true
  end
end
