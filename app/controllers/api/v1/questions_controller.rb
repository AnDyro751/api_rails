class Api::V1::QuestionsController < ApplicationController
  before_action :authenticate, except: [:index,:show]
  # before_action :set_question, except: [:index,:create]
  before_action :set_question, only: [:show,:update,:destroy]
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
    if @question.update(questions_params)
      render "api/v1/questions/show"
    else
      render json:{errors:@question.errors.full_messages},status: :unprocessable_entity
    end
  end

  def destroy
    if @question.destroy
      head :ok
    else
      render json:{errors: "No se pudo eliminar la encuesta"},status: :unprocessable_entity
    end
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
