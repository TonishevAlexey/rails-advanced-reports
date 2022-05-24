class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question, only: %i[ create ]
  before_action :find_answer, only: %i[update grade_up grade_down grade destroy best reward]
  respond_to :json, :js
  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save

  end

  def best
    @answer.best_answer_false
    @answer.update(best: true)

  end

  def reward
    @answer.question.reward.user_id = @answer.user_id
    @answer.question.reward.save

  end

  def update
    @answer.update(answer_params)
  end

  def destroy
    if current_user.author_of?(@answer)
      @answer.destroy
    end
  end

  def grade_up
    unless current_user.author_of?(@answer)
      grade.value += 1
      grading = grade.gradings.find_by(user_id: current_user.id)
      grading.kind = grading.kind == "minus" || grading.kind == "default" ? "nil" : "plus"
      grading.save
      grade.save
      render json: { kind: grading.kind, value: grade.value , class: "answer",id: @answer.id}, status: :ok if grade.save
    end
  end

  def grade_down
    unless current_user.author_of?(@answer)
      grade.value -= 1
      grading = grade.gradings.find_by(user_id: current_user.id)
      grading.kind = grading.kind == "plus" || grading.kind == "default" ? "nil" : "minus"
      grading.save
      grade.save
      render json: { kind: grading.kind, value: grade.value, class: "answer",id: @answer.id }, status: :ok if grade.save
    end
  end

  private

  def grade
    if @answer.grade.present?
      @answer.grade.first
    else
      @answer.grade = [Grade.create(users: [current_user], value: 0)]
      @answer.save
      @answer.grade.first
    end
  end

  def answer_params
    params.require(:answer).permit(:body, files: [], links_attributes: [:_destroy, :id, :name, :link])
  end

  def find_question
    @question ||= Question.find(params[:question_id])
  end

  def find_answer
    @answer = current_user.answers.find(params[:id])
  end
end
