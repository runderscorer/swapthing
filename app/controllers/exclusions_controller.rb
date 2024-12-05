class ExclusionsController < ApplicationController
  def create
    session[:return_to] ||= request.referer

    exclusion = Exclusion.new(exclusion_params)
    partner_exclusion = exclusion.build_partner_exclusion!

    if exclusion.save && partner_exclusion.save
      flash[:notice] = 'Yay. Excluded successfully!'
    else
      flash[:error] = exclusion&.errors&.full_messages&.first || 'Uh oh. Something went wrong.'
    end

    redirect_to session.delete(:return_to)
  end

  private

  def exclusion_params
    params.require(:exclusion).permit(:user_id, :excluded_user_id)
  end
end
