class Api::V1::MyPollsController < ApplicationController
  before_action :authenticate, except: [:index,:show]
  before_action :set_poll, only: [:show,:update]
  def index
    @polls = MyPoll.all.reverse
  end

  def show
  end

  def create
    @poll = @current_user.my_polls.create(my_polls_params)
    if @poll.save
      render "api/v1/my_polls/show"
    else
      render json:{ errors: @poll.errors.full_messages , status: :unprocessable_entity }
    end
  end

  def update
    if @poll.user == @current_user
      @poll.update(my_polls_params)
      render "api/v1/my_polls/show"
    else
      render json:{error:"No tienes autorizada esta accion ! D:" }, status: :unauthorized
    end
  end

  def destroy
    #code
  end

  private
    def my_polls_params
      params.require(:my_poll).permit(:title,:description,:expires_at)
    end

    def set_poll
      @poll = MyPoll.find(params[:id])
    end

end
