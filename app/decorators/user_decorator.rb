class UserDecorator < Draper::Decorator
  include Draper::LazyHelpers
  delegate_all

  def show_partner
    @partner = GetPartner.call(self, params[:event_id])
    if @partner
      render 'partner', partner: @partner
    end
  end
end