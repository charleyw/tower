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

Todo.find_or_create_by(project: Project.first, author: user, name: 'First todo')