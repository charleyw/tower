require 'rails_helper'

describe EventCreateService do
  let(:todo){create(:todo)}
  let(:user){create(:user)}

  describe '#create_todo' do
    subject{EventCreateService.new.create_todo(todo, todo.author)}

    it 'action should be the created todo' do
      expect(EventCreateService.new.create_todo(todo, todo.author).action).to eq(Event::CREATED_TODO)
      expect(subject.action).to eq(Event::CREATED_TODO)
    end

    it 'target should be the todo' do
      expect(subject.target).to eq(todo)
    end

    it 'initiator should be the user' do
      expect(subject.initiator).to eq(todo.author)
    end
  end

  describe '#delete_todo' do
    subject{EventCreateService.new.delete_todo(todo, user)}

    it 'action should be the created todo' do
      expect(subject.action).to eq(Event::DELETED_TODO)
    end

    it 'target should be the todo' do
      expect(subject.target).to eq(todo)
    end

    it 'initiator should be the user' do
      expect(subject.initiator).to eq(user)
    end
  end

  describe '#update_todo_assignee' do
    context 'add new assignee' do
      let(:assignee){create(:user)}
      subject{EventCreateService.new.update_todo_assignee(todo, nil, assignee,user)}

      it 'action should be the update todo assignee' do
        expect(subject.action).to eq(Event::UPDATED_TODO_ASSIGNEE)
      end

      it 'data show nil for prev assignee' do
        expect(subject.data).not_to include(:prev_assignee)
      end

      it 'data show next assignee attrs' do
        expect(subject.data[:next_assignee]).to include({id: assignee.id, name: assignee.name})
      end
    end

    context 'update assignee' do
      let(:assignee){create(:user)}
      let(:another_assignee){create(:user)}
      subject{EventCreateService.new.update_todo_assignee(todo, assignee, another_assignee,user)}

      it 'action should be the update todo assignee' do
        expect(subject.action).to eq(Event::UPDATED_TODO_ASSIGNEE)
      end

      it 'data show prev assignee attrs' do
        expect(subject.data[:prev_assignee]).to include(id: assignee.id, name: assignee.name)
      end

      it 'data show next assignee attrs' do
        expect(subject.data[:next_assignee]).to include({id: another_assignee.id, name: another_assignee.name})
      end
    end

    context 'cancel assignee' do
      let(:assignee){create(:user)}
      let(:another_assignee){create(:user)}
      subject{EventCreateService.new.update_todo_assignee(todo, assignee, nil, user)}

      it 'action should be the update todo assignee' do
        expect(subject.action).to eq(Event::UPDATED_TODO_ASSIGNEE)
      end

      it 'data show prev assignee attrs' do
        expect(subject.data[:prev_assignee]).to include(id: assignee.id, name: assignee.name)
      end

      it 'data show nil for next assignee' do
        expect(subject.data).not_to include(:next_assignee)
      end
    end
  end
end
