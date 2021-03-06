class PoolsController < ApplicationController
  # GET /pools
  # GET /pools.json
  def index
    @pools = Pool.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pools }
    end
  end

    # GET /pools/1
    # GET /pools/1.json
    def show
      @pool = Pool.find(params[:id])

      respond_to do |format|
        if @pool.members.include?(logged_in_user)
          format.html # show.html.erb
          format.json { render json: @pool }
          format.js
        else
          format.html { redirect_to root_path, alert: 'You are not a member of the selected pool' }
          format.json { render json: @pool, location: pools_path }
        end
      end
  end

  # GET /pools/new
  # GET /pools/new.json
  def new
    @pool = Pool.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pool }
    end
  end

  # GET /pools/1/edit
  def edit
    @pool = Pool.find(params[:id])
  end

  # POST /pools
  # POST /pools.json
  def create
    @pool = Pool.new({ name: params[:pool][:name] })

    respond_to do |format|
      if @pool.save
        membership = @pool.memberships.build({ user: logged_in_user })
        if membership.save
          format.html { redirect_to @pool, notice: "Welcome to #{@pool.name}" }
          format.json { render json: @pool, status: :created, location: @pool }
        else
          format.html { redirect_to pools_path, notice: "Unable to join #{@pool.name}" }
          format.json { render json: membership.errors, status: :unprocessable_entity }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @pool.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pools/1
  # PUT /pools/1.json
  def update
    @pool = Pool.find(params[:id])

    respond_to do |format|
      if @pool.update_attributes(params[:pool])
        format.html { redirect_to @pool, notice: 'Pool was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pool.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pools/1
  # DELETE /pools/1.json
  def destroy
    @pool = Pool.find(params[:id])
    @pool.destroy

    respond_to do |format|
      format.html { redirect_to pools_url }
      format.json { head :no_content }
    end
  end

  # GET /pools/join
  def join
  end

  # POST /pools/1/join
  # POST /pools/1/join.json
  def create_membership
    @pool = Pool.find_by_invite_code(params[:invite_code])

    if @pool
      if @pool.memberships.where(user_id: logged_in_user.id).any?
        respond_to do |format|
          format.html { redirect_to @pool, notice: "Welcome back to #{@pool.name}" }
          format.json { render status: :created, location: @pool }
        end
      
      else

        membership = @pool.memberships.build({
          user: logged_in_user
        })

        authenticated = @pool.authenticate(params[:invite_code])

        respond_to do |format|
          if authenticated && @pool.save
            format.html { redirect_to @pool, notice: "Welcome to #{@pool.name}" }
            format.json { render status: :created, location: @pool }
          elsif @authenticated === false
            flash[:invalid_code] = 'The invite code provided was invalid'
            format.html { render action: "join" }
            format.json { render json: @pool.errors, status: :unprocessable_entity }
          else
            format.html { render action: "join" }
            format.json { render json: @pool.errors, status: :unprocessable_entity }
          end
        end
      end
      
    else

      respond_to do |format|
        flash[:invalid_code] = 'The invite code provided was invalid'
        format.html { render action: "join" }
        format.json { render json: @pool.errors, status: :unprocessable_entity }
      end
    end
  end
end
