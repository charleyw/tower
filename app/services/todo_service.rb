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
end