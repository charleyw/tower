class CreateProjectMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :project_members do |t|
      t.belongs_to :project
      t.belongs_to :user

      t.timestamps
    end
  end
end
