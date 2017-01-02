class TodoService
  def initialize(current_user, todo = nil)
    @todo = todo
    @current_user = current_user
  end

  def delete_todo
    if @todo.soft_destroy
      EventCreateService.new.delete_todo @todo, @current_user
    end
  end

  def finish_todo
    @todo.finish
    EventCreateService.new.finish_todo @todo, @current_user
  end

  def assign_todo_to user
    prev_assignee = @todo.assignee
    @todo.update(assignee: user)
    EventCreateService.new.update_todo_assignee @todo, prev_assignee, user, @current_user
  end
end