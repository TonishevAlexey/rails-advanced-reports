class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :question, only: [:show, :edit, :update,:grade_up ,:grade_down ,:grade, :destroy]

  def index
    @questions = Question.all
  end

  def show
    @answer = question.answers.new
  end

  def new
    @question = current_user.questions.new
  end
  def edit
  end
  def update
    if @question.update(question_params)
      redirect_to @question
    else
      render :edit
    end
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
  def grade_up
    unless current_user.author_of?(@question)
      grade.value += 1
      grading = grade.gradings.find_by(user_id: current_user.id)
      grading.kind = grading.kind == "minus" || grading.kind == "default" ? "nil" : "plus"
      grading.save
      grade.save
      render json: { kind: grading.kind, value: grade.value , class: "answer",id: @question.id}, status: :ok if grade.save
    end
  end

  def grade_down
    unless current_user.author_of?(@question)
      grade.value -= 1
      grading = grade.gradings.find_by(user_id: current_user.id)
      grading.kind = grading.kind == "plus" || grading.kind == "default" ? "nil" : "minus"
      grading.save
      grade.save
      render json: { kind: grading.kind, value: grade.value, class: "answer",id: @question.id }, status: :ok if grade.save
    end
  end

  private

  def grade
    if @question.grade.present?
      @question.grade.first
    else
      @question.grade = [Grade.create(users: [current_user], value: 0)]
      @question.save
      @question.grade.first
    end
  end

  def question_params
    params.require(:question).permit(:title, :body,
                                     files: [], links_attributes: [:_destroy, :id, :name, :link], reward_attributes: [ :id, :title, :image])
  end

  def question
    @question ||= params[:id] ? Question.find(params[:id]) : Question.new
  end
end
