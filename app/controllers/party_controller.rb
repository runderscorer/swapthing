class PartyController < ApplicationController
  def index
    @parties = Party.all
  end

  def new
    @party = Party.new
  end

  def create
    @party = Party.new(party_params)

    if @party.save
      redirect_to parties_path
    end
  end

  def edit
    @party = Party.find(params[:id])
  end

  def update
    @party = Party.find(params[:id])

    if @party.update_attributes(party_params)
      redirect_to parties_path
    end
  end

  def destroy
    @party = Party.find(params[:id])
    @party.destroy
    redirect_to parties_path
  end

  private

  def party_params
    params.require(:party).permit(:name, :date, :description, :max_spend)
  end
end