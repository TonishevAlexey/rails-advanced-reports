class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question, only: %i[ create ]
  before_action :find_answer, only: %i[update destroy best]

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save

  end

  def best
    answer = @answer.question.answers.find_by(best: true)
    answer.update(best: false) if answer
    @answer.update(best: true)

  end

  def update
    @answer.update(answer_params)
  end

  def destroy
    if current_user.author_of?(@answer)
      @answer.destroy
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def find_question
    @question ||= Question.find(params[:question_id])
  end

  def find_answer
    @answer = current_user.answers.find(params[:id])
  end
end
