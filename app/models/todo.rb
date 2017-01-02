# == Schema Information
#
# Table name: todos
#
#  id          :integer          not null, primary key
#  name        :string
#  author_id   :integer
#  assignee_id :integer
#  finished_at :datetime
#  rank        :integer          default("0")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  project_id  :integer
#
# Indexes
#
#  index_todos_on_assignee_id  (assignee_id)
#  index_todos_on_author_id    (author_id)
#  index_todos_on_project_id   (project_id)
#

class Todo < ApplicationRecord
  after_create :create_event
  belongs_to :author, class_name: 'User'
  belongs_to :assignee, class_name: 'User', optional: true
  belongs_to :project

  private
  def create_event
    EventCreateService.new.create_todo self, self.author
  end
end
