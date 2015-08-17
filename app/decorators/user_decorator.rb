class UserDecorator < Draper::Decorator
  include Draper::LazyHelpers
  delegate_all

  def show_partner(user)
    @partner = GetPartner.call(self, params[:event_id])
    if @partner && @partner == user
      render 'partner_row', partner: @partner
    else
      render 'user_row', user: user
    end
  end

  def show_partner(user)

  end
end