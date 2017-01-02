# == Schema Information
#
# Table name: todos
#
#  id              :integer          not null, primary key
#  name            :string
#  author_id       :integer
#  assignee_id     :integer
#  finished_at     :datetime
#  rank            :integer          default("0")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  project_id      :integer
#  soft_deleted    :boolean          default("f")
#  soft_deleted_at :datetime
#  state           :string           default("pending")
#
# Indexes
#
#  index_todos_on_assignee_id  (assignee_id)
#  index_todos_on_author_id    (author_id)
#  index_todos_on_project_id   (project_id)
#

FactoryGirl.define do
  factory :todo do
    name "MyString"
    assignee_id 1
    finished_at "2017-01-01 15:13:32"
    rank 1
    author factory: :user
    project
  end
end
