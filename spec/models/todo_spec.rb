# == Schema Information
#
# Table name: todos
#
#  id              :integer          not null, primary key
#  name            :string
#  author_id       :integer
#  assignee_id     :integer
#  finished_at     :datetime
#  rank            :integer          default("0")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  project_id      :integer
#  soft_deleted    :boolean          default("f")
#  soft_deleted_at :datetime
#
# Indexes
#
#  index_todos_on_assignee_id  (assignee_id)
#  index_todos_on_author_id    (author_id)
#  index_todos_on_project_id   (project_id)
#

require 'rails_helper'

RSpec.describe Todo, type: :model do
  describe '#after_create' do
    let(:user){create(:user)}
    let(:team){create(:team)}
    let(:project){create(:project, team: team, users: [user])}

    it 'should create after create event' do
      expect_any_instance_of(EventCreateService).to receive(:create_todo).with(instance_of(Todo), user)
      create(:todo, name: 'Tooodooo', author: user, project: project)
    end
  end

  describe '#soft_destroy' do
    let(:todo){create(:todo)}

    before do
      todo.soft_destroy
    end

    it 'should mark as soft deleted' do
      expect(todo.soft_deleted).to eq(true)
    end
  end
end
