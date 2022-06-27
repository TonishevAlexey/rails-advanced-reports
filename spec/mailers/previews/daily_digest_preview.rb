# Preview all emails at http://localhost:3000/rails/mailers/daily_digest
class DailyDigestPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/daily_digest/digest
  def digest
    DailyDigestMailer.digest(User.all.first)
  end
  # Preview this email at http://localhost:3000/rails/mailers/daily_digest/answer
  def answer
    DailyDigestMailer.answer(User.all.first, Answer.all.first)
  end
end
