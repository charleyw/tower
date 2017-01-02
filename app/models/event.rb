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

class Event < ApplicationRecord
  CREATED_TODO = 1
  DELETED_TODO = 2
  FINISHED_TODO = 3
  UPDATED_TODO_ASSIGNEE = 4
  UPDATED_TODO_DEADLINE = 5

  serialize :data
  belongs_to :target, polymorphic: true
  belongs_to :source, polymorphic: true
  belongs_to :initiator, class_name: 'User'

  scope :by_projects, ->(projects) {where(source_type: 'Project', source_id: projects.map(&:id))}
  scope :recent, ->{order(created_at: :desc)}
end
