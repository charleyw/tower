# == Schema Information
#
# Table name: events
#
#  id           :integer          not null, primary key
#  target_id    :integer
#  target_type  :string
#  source_id    :integer
#  source_type  :string
#  initiator_id :integer
#  action       :integer
#  data         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_events_on_source_id_and_source_type  (source_id,source_type)
#  index_events_on_target_id_and_target_type  (target_id,target_type)
#

FactoryGirl.define do
  factory :event do
    target_id 1
    target_type "MyString"
    source_id 1
    source_type "MyString"
    initiator_id 1
    data "MyText"
  end

  factory :created_todo_event, parent: :event do
    target factory: :todo
    action Event::CREATED_TODO
    source factory: :project
    initiator factory: :user
  end
end
