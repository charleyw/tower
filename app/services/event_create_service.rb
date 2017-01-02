class EventCreateService
  def create_todo todo, user
    Event.create(target: todo, source: todo.project, initiator: user, action: Event::CREATED_TODO)
  end

  def delete_todo todo, user
    Event.create(target: todo, source: todo.project, initiator: user, action: Event::DELETED_TODO)
  end

  def finish_todo todo, user
    Event.create(target: todo, source: todo.project, initiator: user, action: Event::FINISHED_TODO)
  end
end