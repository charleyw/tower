class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    # Todo: should limit projects in specified team
    @events = Event.by_projects(current_user.projects).recent.includes(:target, :source)
  end
end
