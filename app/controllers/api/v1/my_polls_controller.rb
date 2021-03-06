class Api::V1::MyPollsController < ApplicationController
  before_action :authenticate, except: [:index,:show]
  before_action :set_poll, only: [:show,:update,:destroy]
  before_action(only:[:update,:destroy]) { |controlador| controlador.authenticate_owner(@poll.user) }

  layout "api/v1/application"

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
    @poll.update(my_polls_params)
    render "api/v1/my_polls/show"
  end

  def destroy
    @poll.destroy
    render json:{message:"Se ha eliminado la encuesta:" }
  end


  private

    def my_polls_params
      params.require(:my_poll).permit(:title,:description,:expires_at)
    end

    def set_poll
      @poll = MyPoll.find(params[:id])
    end

end
