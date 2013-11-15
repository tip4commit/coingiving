class SponsorsController < InheritedResources::Base

  def index
    @sponsors = Sponsor.page(params[:page]).per(30)
  end

end