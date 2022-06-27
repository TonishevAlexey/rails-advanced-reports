class DailyDigestMailer < ApplicationMailer
  def digest(user)
    @questions = Question.where('created_at > ?', 1.days.ago)
    mail to: user.email, subject: "New questions"
  end

  def answer(user, answer)
    @question = answer.question.title.to_s
    @answer = answer.body
    mail to: user.email, subject: "New #{@question} answers"
  end
end
