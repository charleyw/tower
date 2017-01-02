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
  COMMENTED_TODO = 6

  serialize :data
  belongs_to :target, polymorphic: true
  belongs_to :source, polymorphic: true
  belongs_to :initiator, class_name: 'User'

  scope :by_projects, ->(projects) {where(source_type: 'Project', source_id: projects.map(&:id))}
  scope :recent, ->{order(created_at: :desc)}

  def action_name
    case action
      when CREATED_TODO
        '创建了任务'
      when DELETED_TODO
        '删除了任务'
      when FINISHED_TODO
        '完成了任务'
      when UPDATED_TODO_ASSIGNEE
        update_assignee_action_text
      when UPDATED_TODO_DEADLINE
        update_deadline_action_text
      when COMMENTED_TODO
        '回复了任务'
      else
        ''
    end
  end

  def commented_todo?
    action == COMMENTED_TODO
  end

  private
  def update_assignee_action_text
    if data.key?(:prev_assignee) && data.key?(:next_assignee)
      "把 #{data[:prev_assignee][:name]} 的任务指派给 #{data[:next_assignee][:name]}"
    elsif data.key? :next_assignee
      "给 #{data[:next_assignee][:name]} 指派了任务"
    elsif data.key? :prev_assignee
      "取消了 #{data[:prev_assignee][:name]} 的任务"
    end
  end

  def update_deadline_action_text
    "将任务完成时间从 #{format_deadline data[:prev_deadline_at]} 修改为 #{format_deadline data[:next_deadline_at]}"
  end

  def format_deadline deadline
    return '没有截止日期' unless deadline.present?
    deadline.strftime('%m月%d日')
  end
end
