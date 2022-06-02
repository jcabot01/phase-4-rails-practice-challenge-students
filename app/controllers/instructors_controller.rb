class InstructorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  #GET /instructors
  def index
    instructor = Instructor.all 
    render json: instructor, status: :ok 
  end

  #GET /instructor/:id
  def show
    instructor = find_instructor
    render json: instructor, status: :ok
  end

  #POST /instructors
  def create
    instructor = Instructor.create!(instructor_params)
    render json: instructor, status: :created 
  end

  #PATCH /instructors/:id
  def update
    instructor = find_instructor
    instructor.update!(instructor_params)
    render json: instructor, status: :accepted
  end

  #DELETE /instructors/:id
  def destroy
    instructor = find_instructor
    instructor.destroy
    head :no_content
  end


  private
  def find_instructor
    Instructor.find(params[:id])
  end

  def instructor_params
    params.permit(:name)
  end

  def render_not_found_response
    render json: { error: "Instructor not found" }, status: :not_found
  end

  def render_unprocessable_entity_response(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
end
