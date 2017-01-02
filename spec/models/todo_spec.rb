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
end
