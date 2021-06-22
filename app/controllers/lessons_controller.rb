class LessonsController < ApplicationController
  # before_action :set_lesson
  before_action :set_course
  before_action :set_course_lesson, only: %i[show update destroy]

  # GET /lessons
  def index
    data = @course.lessons.paginate(page: params[:page], per_page: params[:size])
    render json: { data: data, status: 200 }
  end

  # GET /lessons/1
  def show
    render json: @course_lesson
  end

  # GET /lessonDetail/1
  # def detail
  #   render json: @lesson
  # end

  # POST /courses/:course_id/lessons
  def create
    @course.lessons.create!(lesson_params)
    json_response(@course, :created)
  end

  # PATCH/PUT /lessons/1
  def update
    if @course_lesson.update(lesson_params)
      render json: @lesson
    else
      render json: @course_lesson.errors, status: :unprocessable_entity
    end
  end

  # DELETE /lessons/1
  def destroy
    @course_lesson.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.find(params[:course_id])
  end

  # def set_lesson
  #   @lesson = Lesson.find(params[:id])
  # end

  # Only allow a list of trusted parameters through.
  def lesson_params
    params.require(:lesson).permit(:title, :description, :course_id)
  end

  def set_course_lesson
    @course_lesson = @course.lessons.find_by!(id: params[:id]) if @course
  end
end
