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
#
# Indexes
#
#  index_todos_on_assignee_id  (assignee_id)
#  index_todos_on_author_id    (author_id)
#

FactoryGirl.define do
  factory :todo do
    name "MyString"
    author_id 1
    assignee_id 1
    finished_at "2017-01-01 15:13:32"
    rank 1
  end
end
