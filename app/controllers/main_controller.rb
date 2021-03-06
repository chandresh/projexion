class MainController < ApplicationController
    respond_to :html, :json
    before_filter :authenticate_user!

    def index
      @projects = current_user.projects

      params[:next_offset] = 11
      project_ids = []
      @projects.each do |project|
        project_ids << project.id
      end
      #Events initial list only. The rest is fetched using ajax on EventsController
      @events = Event.where(:project_id => project_ids).desc("created_at").limit(10)
              
      # TODO: Limit this. Use batch?
#      @meetings = Meeting.where(["start_time > ? and project_id in (?)", Time.now, @projects]).order('meetings.start_time')
      @meetings = Meeting.where(:project_id => project_ids)

      # TODO: Limit this. 
      @tasks = @current_user.tasks
    end
end
