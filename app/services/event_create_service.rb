class EventCreateService
  def create_todo todo, initiator
    Event.create(target: todo, source: todo.project, initiator: initiator, action: Event::CREATED_TODO)
  end

  def delete_todo todo, initiator
    Event.create(target: todo, source: todo.project, initiator: initiator, action: Event::DELETED_TODO)
  end

  def finish_todo todo, initiator
    Event.create(target: todo, source: todo.project, initiator: initiator, action: Event::FINISHED_TODO)
  end

  def update_todo_assignee todo, prev_assignee, next_assignee, initiator
    data = {}
    data.merge!(prev_assignee: {id: prev_assignee.id, name: prev_assignee.name}) if prev_assignee.present?
    data.merge!(next_assignee: {id: next_assignee.id, name: next_assignee.name}) if next_assignee.present?
    Event.create(target: todo, source: todo.project, initiator: initiator, action: Event::UPDATED_TODO_ASSIGNEE, data: data)
  end

  def update_todo_deadline todo, prev_deadline, next_deadline, initiator
    data = {}
    data.merge!(prev_deadline_at: prev_deadline) if prev_deadline.present?
    data.merge!(next_deadline_at: next_deadline) if next_deadline.present?
    Event.create(target: todo, source: todo.project, initiator: initiator, action: Event::UPDATED_TODO_DEADLINE, data: data)
  end
end