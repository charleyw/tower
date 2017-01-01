class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = Event.by_projects(current_user.projects).includes(:target, :source)
  end
end
