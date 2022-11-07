class FixColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :movies, :realised_on, :released_on
  end
end
