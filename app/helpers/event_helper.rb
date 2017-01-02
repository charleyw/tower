module EventHelper
  def update_assignee_action_text data
    if data.key?(:prev_assignee) && data.key?(:next_assignee)
      "把 #{data[:prev_assignee][:name]} 的任务指派给 #{data[:next_assignee][:name]} ："
    elsif data.key? :next_assignee
      "给 #{data[:next_assignee][:name]} 指派了任务："
    elsif data.key? :prev_assignee
      "取消了 #{data[:prev_assignee][:name]} 的任务："
    end
  end

  def update_deadline_action_text data
    "将任务完成时间从 #{format_deadline data[:prev_deadline_at]} 修改为 #{format_deadline data[:next_deadline_at]}："
  end

  def format_deadline deadline
    return '没有截止日期' unless deadline.present?
    deadline.strftime('%m月%d日')
  end
end
