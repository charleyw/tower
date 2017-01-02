require 'rails_helper'

describe 'Events list page', feature: true do
  let(:user){FactoryGirl.create(:user)}
  let(:team){FactoryGirl.create(:team)}
  let(:project){FactoryGirl.create(:project, team: team, users: [user])}

  context 'user created a todo' do
    before do
      create(:todo, name: 'Tooodooo', author: user, project: project)
      login_as(user, scope: :user)
      visit team_events_path(team_id: team.id)
    end

    it 'should show "user created todo"' do
      within first('.event') do
        # 1 more extra space after "：" due to a whole page text search
        expect(page).to have_content("#{user.name} 创建了任务： #{Todo.last.name}")
      end
    end
  end

  context 'user created a todo then delete' do
    let!(:todo){create(:todo, author: user, project: project)}

    before do
      TodoService.new(user, todo).delete_todo
      login_as(user, scope: :user)
      visit team_events_path(team_id: team.id)
    end

    it 'should show "user deleted todo" at first' do
      within first('.event') do
        expect(page).to have_content("#{user.name} 删除了任务： #{todo.name}")
      end
    end

    it 'should show "user created todo" at second' do
      within '.event:nth-of-type(2)' do
        expect(page).to have_content("#{user.name} 创建了任务： #{todo.name}")
      end
    end
  end

  context 'user created a todo then finish' do
    let!(:todo){create(:todo, author: user, project: project)}

    before do
      TodoService.new(user, todo).finish_todo
      login_as(user, scope: :user)
      visit team_events_path(team_id: team.id)
    end

    it 'should show "user finished todo" at first' do
      within first('.event') do
        expect(page).to have_content("#{user.name} 完成了任务： #{todo.name}")
      end
    end

    it 'should show "user created todo" at second' do
      within '.event:nth-of-type(2)' do
        expect(page).to have_content("#{user.name} 创建了任务： #{todo.name}")
      end
    end
  end
end