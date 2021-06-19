class QuestionsController < ApplicationController
  before_action :set_lesson
  before_action :set_lesson_question, only: %i[show update destroy]

  # GET /lessons/:lesson_id/questions
  def index
    json_response(@lesson.questions)
  end

  # GET /questions/1
  def show
    render json: @question
  end

  # POST /courses/:course_id/lessons
  def create
    @lesson.questions.create!(question_params)
    json_response(@lesson, :created)
  end

  # PATCH/PUT /questions/1
  def update
    if @question.update(question_params)
      render json: @question
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /questions/1
  def destroy
    @question.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end

  def set_lesson_question
    @question = @lesson.questions.find_by!(id: params[:id]) if @lesson
  end

  # Only allow a list of trusted parameters through.
  def question_params
    params.require(:question).permit(:title, :a, :b, :c, :d, :correct, :lesson_id)
  end
end
