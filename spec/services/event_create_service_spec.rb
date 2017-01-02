require 'rails_helper'

describe EventCreateService do
  describe '#create_todo' do
    let(:todo){create(:todo)}

    context 'create todo event' do
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
  end
end
