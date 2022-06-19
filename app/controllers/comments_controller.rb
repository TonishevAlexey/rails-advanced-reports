class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_resource, only: :create
  after_action :publish_comment,  only: :create
  authorize_resource
  def create
    @comment = @resource.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  private
  def publish_comment
    question_id = @resource.class.to_s == "Question" ? @resource.id : @resource.question.id
    return if @comment.errors.any?
    ActionCable.server.broadcast(
      "comments_question_#{question_id}",
      {
        comment: ApplicationController.render(
          partial: 'comments/comment',
          locals: {
            comment: @comment,
            current_user: current_user,
          }
        ),

        comment_parent: @comment.commentable.class.to_s.downcase,
        parent_id: @comment.commentable.id

    }
    )
  end
  def find_resource
    return @resource = Answer.find(params[:comment][:answer_id]) if params[:comment][:answer_id]
    @resource = Question.find(params[:comment][:question_id]) if params[:comment][:question_id]
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
