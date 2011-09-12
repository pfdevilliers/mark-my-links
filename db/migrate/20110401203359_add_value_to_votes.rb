class AddValueToVotes < ActiveRecord::Migration
  def self.up
    add_column :votes, :value, :integer
  end

  def self.down
    remove_column :votes, :value
  end
end
