class CreateTeamMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :team_members do |t|
      t.belongs_to :team
      t.belongs_to :user

      t.timestamps
    end
  end
end
