class SponsorsController < InheritedResources::Base

  def index
    @sponsors = Sponsor.order(name: :asc).order(month_donations: :desc).page(params[:page]).per(30)
  end

  def show
    @sponsor = Sponsor.find(params[:id])
    @deposits = @sponsor.deposits.order(:created_at => :desc).page(params[:page]).per(30)
  end

end