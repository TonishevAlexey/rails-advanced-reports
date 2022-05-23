class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question, only: %i[ create ]
  before_action :find_answer, only: %i[update destroy best reward]

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
    @answer.question.reward.user_id =@answer.user_id
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

  private

  def answer_params
    params.require(:answer).permit(:body,files: [], links_attributes: [:_destroy, :id, :name, :link])
  end

  def find_question
    @question ||= Question.find(params[:question_id])
  end

  def find_answer
    @answer = current_user.answers.find(params[:id])
  end
end
