require 'rails_helper'

describe TodoService do
  let(:todo){create(:todo)}
  let(:user){create(:user)}

  describe '#delete_todo' do
    before do
      expect_any_instance_of(EventCreateService).to receive(:delete_todo).with(todo, user)
      described_class.new(user, todo).delete_todo
    end

    it 'should mark todo as soft deleted' do
      expect(todo.soft_deleted).to eq(true)
    end
  end

  describe '#assign_todo_to' do
    let(:assignee){create(:user)}

    context 'todo has no assignee' do
      let(:todo_no_assignee){create(:todo, assignee: nil)}

      it 'should update assignee' do
        described_class.new(user, todo_no_assignee).assign_todo_to assignee
        expect(todo_no_assignee.assignee).to eq(assignee)
      end

      it 'should call event create service with nil prev assignee' do
        expect_any_instance_of(EventCreateService).to receive(:update_todo_assignee).with(todo_no_assignee, nil, assignee, user)
        described_class.new(user, todo_no_assignee).assign_todo_to assignee
      end
    end

    context 'todo has assignee' do
      it 'should call event create service with prev assignee & next assignee' do
        expect_any_instance_of(EventCreateService).to receive(:update_todo_assignee).with(todo, todo.assignee, assignee, user)
        described_class.new(user, todo).assign_todo_to assignee
      end
    end

    context 'cancel todo assignee' do
      it 'should set assignee nil' do
        described_class.new(user, todo).assign_todo_to nil
        expect(todo.assignee).to eq(nil)
      end

      it 'should call event create service with nil next assignee' do
        expect_any_instance_of(EventCreateService).to receive(:update_todo_assignee).with(todo, todo.assignee, nil, user)
        described_class.new(user, todo).assign_todo_to nil
      end
    end
  end
end
