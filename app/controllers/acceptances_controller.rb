class AcceptancesController < ApplicationController

  def new
    @feature = Feature.find(params[:feature_id])
    @project = @feature.project

    @acceptance = Acceptance.new

    respond_with(@acceptance, @feature, @project) do |format|
      format.html { render }
    end
  end

  def create
    @acceptance = Acceptance.new(params[:acceptance])
    @feature = Feature.find(params[:feature_id])

    @acceptance.feature = @feature
    @project = @feature.project

    flash[:notice] = 'Acceptance test was successfully added.' if @acceptance.save

    respond_with(@acceptance) do |format|
      format.html { redirect_to project_feature_path(:code => params[:project_id], :id => params[:feature_id]) }
    end
  end

  def destroy
    @acceptance = Acceptance.find(params[:id])

    @acceptance.destroy

    respond_to do |format|
      flash[:notice] = 'Acceptance test was successfully deleted.'
      format.html { redirect_to project_feature_path(:code => params[:project_id], :id => params[:feature_id]) }
    end
  end

  # Ajax actions
  def update_acceptance
    @acceptance = Acceptance.find(params[:acceptance_id])

    @acceptance.accepted = !@acceptance.accepted

    respond_with(@acceptance) do |format|
      if @acceptance.save
        format.json { render :json => @acceptance }
      end
    end
  end
end