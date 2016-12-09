class Api::V1::MyPollsController < ApplicationController
  before_action :authenticate, except: [:index,:show]

  def index
    @polls = MyPoll.all.reverse
  end

  def show
    @poll = MyPoll.find(params[:id])
  end

  def create
    @poll = @current_user.my_polls.create(my_polls_params)
    if @poll.save
      render "api/v1/my_polls/show"
    else
      render json:{ error: @poll.errors.full_messages , status: :unprocessable_entity }
    end
  end

  def update
    #code
  end

  def destroy
    #code
  end

  private
    def my_polls_params
      params.require(:my_poll).permit(:title,:description,:expires_at)
    end

end
