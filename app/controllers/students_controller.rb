class StudentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  #GET /students
  def index
    students = Student.all 
    render json: students, status: :ok 
  end

  #GET /student/:id
  def show
    student = find_student
    render json: student, status: :ok
  end

  #POST /students
  def create
    student = Student.create!(student_params)
    render json: student, status: :created 
  end

  #PATCH /students/:id
  def update
    student = find_student
    student.update!(student_params)
    render json: student, status: :accepted
  end

  #DELETE /students/:id
  def destroy
    student = find_student
    student.destroy
    head :no_content
  end


  private
  def find_student
    Student.find(params[:id])
  end

  def student_params
    params.permit(:name, :major, :age, :instructor_id)
  end

  def render_not_found_response
    render json: { error: "Student not found" }, status: :not_found
  end

  def render_unprocessable_entity_response(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
end
