class Api::V1::MyPollsController < ApplicationController

  def index
    @polls = MyPoll.all.reverse
  end

  def show
    @poll = MyPoll.find(params[:id])
  end

  def create
    #code
  end

  def update
    #code
  end

  def destroy
    #code
  end

end
