class AnswersController < ApplicationController
  before_action :find_question, only: %i[update create]
  before_action :find_answer, only: %i[update]


  def create
    @answer = @question.answers.new(answer_params)
    @question = @answer.question

    if @answer.save
      redirect_to @answer.question
    else
      redirect_to question_path(@question.id)
    end
  end

  def update
    @answer.update(answer_params)
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def find_question
    @question ||= Question.find(params[:question_id])
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end
end
