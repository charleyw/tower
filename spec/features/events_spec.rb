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

  describe 'user created a todo then assign to a user' do
    let!(:todo){create(:todo, author: user, assignee: nil, project: project)}
    let!(:assignee){create(:user)}
    let!(:another_assignee){create(:user)}

    before do
      TodoService.new(user, todo).assign_todo_to assignee
      TodoService.new(user, todo).assign_todo_to another_assignee
      TodoService.new(user, todo).assign_todo_to nil
      login_as(user, scope: :user)
      visit team_events_path(team_id: team.id)
    end

    it 'should show "user was assigned to todo" at third' do
      within '.event:nth-of-type(3)' do
        expect(page).to have_content("#{user.name} 给 #{assignee.name} 指派了任务： #{todo.name}")
      end
    end

    it 'should show "change assignee of todo" when assign to another at second' do
      within '.event:nth-of-type(2)' do
        expect(page).to have_content("#{user.name} 把 #{assignee.name} 的任务指派给 #{another_assignee.name} ： #{todo.name}")
      end
    end

    it 'should show "cancel assignee of todo" when assign to another at first' do
      within first('.event') do
        expect(page).to have_content("#{user.name} 取消了 #{another_assignee.name} 的任务： #{todo.name}")
      end
    end
  end

  describe 'user created todo and update deadline' do
    let!(:todo){create(:todo, author: user, assignee: nil, project: project)}
    let!(:deadline_one){DateTime.now - 2.days}
    let!(:deadline_two){DateTime.now - 1.days}

    before do
      TodoService.new(user, todo).update_todo_deadline deadline_one
      TodoService.new(user, todo).update_todo_deadline deadline_two
      TodoService.new(user, todo).update_todo_deadline nil
      login_as(user, scope: :user)
      visit team_events_path(team_id: team.id)
    end

    it 'should show nil deadline to a specified date' do
      within '.event:nth-of-type(3)' do
        expect(page).to have_content("#{user.name} 将任务完成时间从 没有截止日期 修改为 #{deadline_one.strftime('%m月%d日')}： #{todo.name}")
      end
    end

    it 'should show update deadline' do
      within '.event:nth-of-type(2)' do
        expect(page).to have_content("#{user.name} 将任务完成时间从 #{deadline_one.strftime('%m月%d日')} 修改为 #{deadline_two.strftime('%m月%d日')}： #{todo.name}")
      end
    end

    it 'should show update deadline to nil deadline' do
      within first('.event') do
        expect(page).to have_content("#{user.name} 将任务完成时间从 #{deadline_two.strftime('%m月%d日')} 修改为 没有截止日期： #{todo.name}")
      end
    end
  end

  describe 'user comment on todo' do
    let!(:todo){create(:todo, author: user, project: project)}
    let!(:comment){create(:comment, commentable: todo, author: user)}

    before do
      login_as(user, scope: :user)
      visit team_events_path(team_id: team.id)
    end

    it 'should show nil deadline to a specified date' do
      within first('.event') do
        expect(page).to have_content("#{user.name} 回复了任务： #{todo.name}")
        expect(page).to have_content(comment.content)
      end
    end
  end
end
