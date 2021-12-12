class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def show; end

  def new; end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to @question
    else
      render :new
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def question
    @question ||= Question.find(params[:id])
  end

  helper_method :question
end
