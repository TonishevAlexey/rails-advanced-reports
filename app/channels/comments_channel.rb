class CommentsChannel < ApplicationCable::Channel
  def follow(params)
    stream_from "comments_question_#{params['question_id']}"
  end
end
