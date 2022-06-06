module Votes
  extend ActiveSupport::Concern

  def vote_up
    return if current_user.author_of?(parent)

    vote = vote_find
    vote.value += 1
    vote.kind = vote.kind == 'minus' ? 'nil' : 'plus'
    vote.save
    if vote.save
      render json: { kind: vote.kind, value: vote.value, class: controller_name, id: vote.votable_id },
             status: :ok
    end
  end

  def vote_down
    return if current_user.author_of?(parent)

    vote = vote_find
    vote.value -= 1
    vote.kind = vote.kind == 'plus' ? 'nil' : 'minus'
    vote.save
    if vote.save
      render json: { kind: vote.kind, value: vote.value, class: controller_name, id: vote.votable_id },
             status: :ok
    end
  end

  private

  def vote_find
    parent = controller_name.singularize.classify.constantize.find(params[:id])
    vote = parent.votes.find_or_create_by(user_id: current_user.id)
    parent.vote_ids << vote
    parent.save
    vote
  end

  def parent
    controller_name.singularize.classify.constantize.find(params[:id])
  end
end
