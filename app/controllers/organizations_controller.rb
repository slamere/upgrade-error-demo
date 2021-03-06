class OrganizationsController < ApplicationController

  def index
    @organizations = Organization.all
  end

  def show
    @organization = Organization.find(params[:id])
  end

  def new
    @organization = Organization.new
    @organization.phones.build
  end

  def edit
    @organization = Organization.find(params[:id])
  end

  def create
    @organization = Organization.new(params[:organization])

    if @organization.save
      redirect_to(@organization, :notice => 'Organization was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @organization = Organization.find(params[:id])
    # FIXME: One solution to a rails 2.3.6 problem with association changes not saving is to uncomment this debug statement
    # logger.debug @organization.phones.inspect
    if @organization.update_attributes(params[:organization])
      redirect_to(@organization, :notice => 'Organization was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy

    redirect_to(organizations_url)
  end
end
