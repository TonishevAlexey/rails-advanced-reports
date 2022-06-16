class AnswersChannel < ApplicationCable::Channel
  def follow(params)
    stream_from "questions/#{params["question_id"]}"
  end
end