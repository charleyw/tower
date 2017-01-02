require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe 'GET index' do
    let!(:user){create(:user)}
    let!(:team){create(:team)}
    let!(:project){create(:project, team: team, users: [user])}
    let!(:event){create(:event, target: create(:todo), source: project, action: Event::CREATED_TODO)}
    let!(:event_belongs_to_other_team){create(:created_todo_event)}

    before do
      sign_in(user)
    end

    it 'should display event index page' do
      get :index, params: {team_id: team.id}
      expect(response.status).to eq(200)
    end

    it 'should show visible events' do
      get :index, params: {team_id: team.id}
      expect(assigns(:events)).to eq([event])
    end
  end
end
