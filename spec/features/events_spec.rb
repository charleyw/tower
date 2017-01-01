require 'rails_helper'

xdescribe 'Events list page', feature: true do
  let(:user){FactoryGirl.create(:user)}
  let(:team){FactoryGirl.create(:team)}
  let(:project){FactoryGirl.create(:project, team: team, project_members: [create(:project_member, user: user)])}

  context 'user have an create todo event' do
    before do
      FactoryGirl.create(:todo, name: 'Tooodooo', author: user, project: project)
      login_as(user, scope: :user)
      visit '/teams/-/events/'
    end

    it 'should show "user created todo"' do
      within first('.event') do
        expect(page).to have_content("#{user.name} 创建了任务：#{Todo.first.name}")
      end
    end
  end
end