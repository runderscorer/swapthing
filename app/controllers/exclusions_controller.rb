class ExclusionsController < ApplicationController
  def create
    session[:return_to] ||= request.referer

    exclusion = Exclusion.new(exclusion_params)

    if exclusion.save
      flash[:notice] = 'Yay. Excluded successfully!'
    else
      flash[:error] = 'Uh oh. Something went wrong. Try again.'
    end

    redirect_to session.delete(:return_to)
  end

  private

  def exclusion_params
    params.require(:exclusion).permit(:user_id, :excluded_user_id)
  end
end
