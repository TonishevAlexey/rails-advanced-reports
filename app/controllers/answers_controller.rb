class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question, only: %i[update create]
  before_action :find_answer, only: %i[update destroy]


  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    if @answer.save
      redirect_to @answer.question, notice: "Your answer successfully created."
    else
      render 'questions/show'
    end
  end

  def update
    @answer.update(answer_params)
  end

  def destroy
    if current_user.author_of?(@answer)
      @answer.destroy
      redirect_to @answer.question, notice: "Your answer successfully deleted."
    else
      render 'questions/show', notice: "Not your answer!"
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
