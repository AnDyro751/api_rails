class Api::V1::QuestionsController < ApplicationController
  before_action :authenticate, except: [:index,:show]
  before_action :set_question, except: [:index,:create]
  before_action :set_poll
  before_action(only:[:update,:destroy,:create]) { |controlador| controlador.authenticate_owner(@poll.user) }
  def index
    @questions = @poll.questions.reverse
  end

  def show
    #code
  end

  def create
    @question = @poll.questions.new(questions_params)
    if @question.save
      render "api/v1/questions/show"
    else
      render json:{errors:@question.errors.full_messages},status: :unprocessable_entity
    end
  end

  def update
    #code
  end

  def destroy
    #code
  end

  private

    def questions_params
      params.require(:question).permit(:description)
    end

    def set_poll
      @poll = MyPoll.find(params[:poll_id])
    end

    def set_question
      @question = Question.find(params[:id])
    end

end
