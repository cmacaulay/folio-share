class ChangeCollaboratorsToCollaborations < ActiveRecord::Migration[5.0]
  def change
    rename_table :collaborators, :collaborations
  end
end
