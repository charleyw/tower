class EventCreateService
  def create_todo todo, user
    Event.create(target: todo, source: todo.project, initiator: user, action: Event::CREATED_TODO)
  end
end