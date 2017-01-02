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
end
