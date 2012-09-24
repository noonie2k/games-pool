class GamesController < ApplicationController
  # GET /games
  # GET /games.json
  def index
    @games = Game.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @game = Game.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game }
    end
  end

  def hold
    @game = Game.find(params[:id])

    respond_to do |format|
      if @game.owner == logged_in_user
        format.html { redirect_to game_path(@game), alert: "You can't place holds on your own games!" }
      elsif Loan.active.md5(@game.md5).where(user_id: logged_in_user.id).any?
        format.html { redirect_to game_path(@game), alert: "You have an existing hold on #{@game.title}" }
      elsif @game.loans.new({ user: logged_in_user }).save
        format.html { redirect_to game_path(@game), notice: "A hold has been requested of #{@game.owner.name} for #{@game.title}" }
      else
        format.html { redirect_to game_path(@game), alert: "An error was encountered when attempting to hold #{@game.title}" }
      end
    end
  end

  def issue
  end

  def return
  end

  # GET /games/new
  # GET /games/new.json
  def new
    @game = Game.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/find
  # POST /games/find/:title.json
  def find
    respond_to do |format|
      format.html
      format.js
      format.json do
        if params[:game].present? && params[:game][:title].present?
          search = GiantBomb::Search.new
          search.limit(10)
          search.resources('game')
          search.fields('id,name,image')
          search.query(params[:game][:title])
          results = search.fetch_response
          render json: results
        else
          render json: { results: [] }
        end
      end
    end
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id])
  end

  # POST /games
  # POST /games.json
  def create
    @game = logged_in_user.games.build(params[:game])

    respond_to do |format|
      if @game.save
        format.html { redirect_to account_user_path(logged_in_user), notice: "#{@game.title} was created successfully" }
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { render action: "new" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.json
  def update
    @game = Game.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        format.html { redirect_to account_user_path(logged_in_user), notice: "#{@game.title} was updated successfully" }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to account_user_path(logged_in_user) }
      format.json { head :no_content }
    end
  end
end
