class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :question, only: %i[show edit update destroy]
  include Votes

  def index
    @questions = Question.all
  end

  def show
    @answer = question.answers.new

  end

  def new
    @question = current_user.questions.new
    gon.question_id = @question.id

  end

  def edit; end

  def update
    @question.update(question_params) if current_user.author_of?(@question)
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
      redirect_to @question, notice: 'Not your question!'
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body,
                                     files: [], links_attributes: %i[_destroy id name link], reward_attributes: %i[id title image])
  end

  def question
    @question ||= params[:id] ? Question.find(params[:id]) : Question.new
  end
end
