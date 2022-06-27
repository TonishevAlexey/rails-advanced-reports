class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :question, only: %i[show edit update destroy]
  before_action :subscription, only: %i[show update]
  after_action :publish_question, only: :create
  authorize_resource
  include Votes

  def index
    @questions = Question.all
  end

  def show
    @answer = question.answers.new

  end

  def new
    @question = current_user.questions.new
  end

  def edit; end

  def update
    @question.update(question_params)
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
      @question.destroy
      redirect_to questions_path
  end

  private

  def question_params
    params.require(:question).permit(:title, :body,
                                     files: [], links_attributes: %i[_destroy id name link], reward_attributes: %i[id title image])
  end

  def subscription
    @subscription = @question.subscriptions.find_by(user: current_user)
  end

  def question
    @question ||= params[:id] ? Question.find(params[:id]) : Question.new
  end

  def publish_question
    return if @question.errors.any?
    ActionCable.server.broadcast(
      "questions",
      {
        question: ApplicationController.render(
          locals: { question: @question,
                    current_user: current_user,
          },
          partial: 'questions/question'
        )
      }
    )
  end
end
