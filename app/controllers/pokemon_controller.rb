class PokemonController < ApplicationController
	def capture
		@pokemon = Pokemon.find(params[:id])
    @pokemon.trainer_id = current_trainer.id
    @pokemon.save
    redirect_to :root
	end

  def damage
    @pokemon = Pokemon.find(params[:id])
    @pokemon.health -= 10
    if @pokemon.health == 0
      @pokemon.destroy
    else @pokemon.save
    end
    redirect_to trainer_path(params[:trainer])
  end

  def new
    @pokemons = Pokemon.new
  end

  def create
    @pokemon = Pokemon.new
    @pokemon.name = params[:pokemon][:name]
    @pokemon.level = 1
    @pokemon.health = 100
    @pokemon.trainer = current_trainer
    if @pokemon.save
      redirect_to trainer_path(params[:trainer])
    else
      render :new 
      flash[:error] = @pokemon.errors.full_messages.to_sentence
    end
  end
end
