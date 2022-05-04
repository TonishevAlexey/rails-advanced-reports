class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @questions = Question.all
  end

  def show
    @answer = question.answers.new
  end

  def new
    @question = current_user.questions.new
  end

  def create
    @question = current_user.questions.new(question_params)

    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def destroy
    if current_user.author_of?(question)
      @question.destroy
      redirect_to questions_path
    else
      redirect_to @question, notice: "Not your question!"
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def question
    @question ||= params[:id] ? Question.find(params[:id]) : Question.new
  end
end
