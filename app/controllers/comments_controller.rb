class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_resource, only: :create

  def create
    @comment = @resource.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy if current_user.author_of?(@comment)
  end

  private

  def find_resource
    return @resource = Answer.find(params[:comment][:answer_id]) if params[:comment][:answer_id]
    @resource = Question.find(params[:comment][:question_id]) if params[:comment][:question_id]
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
