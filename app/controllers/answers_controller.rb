class AnswersController < ApplicationController
  before_action only: %i[create_answers]

  # GET /answers/1
  def show
    render json: @answer
  end

  # POST /answers
  def create_answers
    @result = Answer.create(answers_params[:answers])
    json_response(@result, :created)
  end

  private

  # Only allow a list of trusted parameters through.
  def answer_params
    params.require(:answer).permit(:selected, :is_correct, :question_id, :lesson_id, :user_id)
  end

  # Only allow a list of trusted parameters through.
  def answers_params
    params.permit(answers: %i[selected is_correct question_id])
  end
end
