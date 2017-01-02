# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.find_or_create_by(email: 'user1@example.com') do |u|
  u.name = '用户1'
  u.password = '1234567890'
  u.password_confirmation = '1234567890'
end

user2 = User.find_or_create_by(email: 'user2@example.com') do |u|
  u.name = '用户2'
  u.password = '1234567890'
  u.password_confirmation = '1234567890'
end

user3 = User.find_or_create_by(email: 'user3@example.com') do |u|
  u.name = '用户3'
  u.password = '1234567890'
  u.password_confirmation = '1234567890'
end

Team.find_or_create_by(name: 'Team-1') do |team|
  team.team_members << TeamMember.create(user: User.first)
end

Project.find_or_create_by(name: 'Project-1') do |project|
  project.team = Team.first
  project.project_members << ProjectMember.create(user: User.first)
end

actions = []

actions << proc {|n| Todo.create(name: "创建你的第#{n}个项目", project: Project.first, author: user)}
actions << proc {
  todo = Todo.not_deleted.sample
  TodoService.new(User.all.sample, todo).delete_todo if todo.present?
}

actions << proc {
  todo = Todo.not_deleted.not_finished.sample
  TodoService.new(User.all.sample, todo).finish_todo if todo.present?
}

actions << proc {
  todo = Todo.not_deleted.not_finished.sample
  if todo.present?
    assignees = todo.assignee.present? ? User.all.to_a.push(nil) : User.all
    TodoService.new(User.all.sample, todo).assign_todo_to assignees.sample
  end
}

actions << proc { |n|
  todo = Todo.not_deleted.not_finished.sample
  if todo.present?
    deadlines = todo.deadline_at.present? ? [DateTime.now + n.days, nil] : [DateTime.now + n.days]
    TodoService.new(User.all.sample, todo).update_todo_deadline deadlines.sample
  end
}

actions << proc { |n|
  todo = Todo.not_deleted.sample
  Comment.create(commentable: todo, content: "这是评论#{n}!", author: User.all.sample) if todo.present?
}

100.times do |n|
  actions.sample.call(n)
end