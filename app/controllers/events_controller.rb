class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = Event.by_projects(current_user.projects_by_team_id(params[:team_id])).recent.includes(:target, :source)
  end
end
