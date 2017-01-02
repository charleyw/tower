require 'rails_helper'

describe TodoService do
  describe '#delete_todo' do
    let(:todo){create(:todo)}
    let(:user){create(:user)}

    before do
      expect_any_instance_of(EventCreateService).to receive(:delete_todo).with(todo, user)
      described_class.new(user, todo).delete_todo
    end

    it 'should mark todo as soft deleted' do
      expect(todo.soft_deleted).to eq(true)
    end
  end
end
