class ProjectsController < ApplicationController

  def index
    @projects = Project.order(month_donations: :desc).order(name: :asc).page(params[:page]).per(30)
    unless params[:search].blank?
      @projects = @projects.search(:name_or_about_contains => params[:search]).result
    end
  end

  def show
    @project = Project.find params[:id]
    @deposit_address = @project.deposit_address(current_sponsor)
    @project_sponsors = @project.sponsors.where(:private_donations => false)
  end

  def generate_address
    unless current_sponsor && (@project = Project.find params[:id])
      redirect_to root_path
      return
    end

    @deposit_address = DepositAddress.find_by_project_id_and_sponsor_id(@project.id, current_sponsor.id)

    if @deposit_address.nil?
      uri = URI("http://blockchain.info/api/receive")
      params = {
        method: "create",
        address: @project.bitcoin_address,
        callback: "http://coingiving.com/blockchain_info_callback?secret=#{CONFIG["blockchain_info"]["callback_secret"]}"
      }
      uri.query = URI.encode_www_form(params)
      p uri
      res = Net::HTTP.get_response(uri)
      p res
      if res.is_a?(Net::HTTPSuccess) && (bitcoin_address = JSON.parse(res.body)["input_address"])
        DepositAddress.create({project_id: @project.id, sponsor_id: current_sponsor.id, bitcoin_address: bitcoin_address})
      end
    end
    redirect_to project_path(@project)
  end

end
