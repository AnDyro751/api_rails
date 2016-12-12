class Api::V1::AnswersController < ApplicationController
  before_action :authenticate, except: [:index]
  before_action :set_answer, except: [:create]
  before_action :set_poll
  before_action(only:[:update,:destroy,:create]) { |controlador| controlador.authenticate_owner(@poll.user) }

  def create
    @answer = Answer.new(answers_params)
    if @answer.save
      render "api/v1/answers/show"
    else
      render json:{errors:@answer.errors.full_messages},status: :unprocessable_entity
    end
  end

  def update
    if @answer.update(answers_params)
      render "api/v1/answers/show"
    else
      render json:{errors:@answer.errors.full_messages},status: :unprocessable_entity
    end
  end

  def destroy
    if @answer.destroy
      head :ok
    else
      render json:{errors: "No se pudo eliminar la respuesta"},status: :unprocessable_entity
    end
  end

  private

    def answers_params
      params.require(:answer).permit(:description,:question_id)
    end

    def set_poll
      @poll = MyPoll.find(params[:poll_id])
    end

    def set_answer
      @answer = Answer.find(params[:id])
    end

end
