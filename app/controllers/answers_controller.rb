class AnswersController < ApplicationController
  before_action :set_question
  before_action :set_question_answer, only: %i[show update destroy]

  # GET /answers
  def index
    json_response(@question.answers)
  end

  # GET /answers/1
  def show
    render json: @answer
  end

  # POST /answers
  def create
    @question.answers.create!(answer_params)
    json_response(@question, :created)
  end

  # PATCH/PUT /answers/1
  def update
    if @answer.update(answer_params)
      render json: @answer
    else
      render json: @answer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /answers/1
  def destroy
    @answer.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_question_answer
    @answer = @question.answers.find_by!(id: params[:id]) if @question
  end

  # Only allow a list of trusted parameters through.
  def answer_params
    params.require(:answer).permit(:selected, :is_correct, :question_id)
  end
end
