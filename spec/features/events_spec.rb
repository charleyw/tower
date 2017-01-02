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
end