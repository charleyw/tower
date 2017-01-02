class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    redirect_to team_events_path(team_id: current_user.teams.first.id)
  end
end
