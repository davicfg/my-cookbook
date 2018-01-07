class RemoveCusineFromRecipes < ActiveRecord::Migration[5.1]
  def change
    remove_reference :recipes, :cuisine, foreign_key: true
  end
end
