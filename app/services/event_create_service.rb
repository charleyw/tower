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
    prev_attrs = prev_assignee.present? ? {id: prev_assignee.id, name: prev_assignee.name} : nil
    next_attrs = next_assignee.present? ? {id: next_assignee.id, name: next_assignee.name} : nil
    data = {prev_assignee: prev_attrs, next_assignee: next_attrs}
    Event.create(target: todo, source: todo.project, initiator: initiator, action: Event::UPDATED_TODO_ASSIGNEE, data: data)
  end
end