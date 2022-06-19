module Votes
  extend ActiveSupport::Concern
  included do
    before_action :find_vote, only: %i[vote_up vote_down]
  end
  def vote_up
    @vote.value += 1
    @vote.kind = @vote.kind == 'minus' ? 'nil' : 'plus'
    @vote.save
    if @vote.save
      render json: { kind: @vote.kind, value: @vote.value, class: controller_name, id: @vote.votable_id },
             status: :ok
    end
  end

  def vote_down
    @vote.value -= 1
    @vote.kind = @vote.kind == 'plus' ? 'nil' : 'minus'
    @vote.save
    if @vote.save
      render json: { kind: @vote.kind, value: @vote.value, class: controller_name, id: @vote.votable_id },
             status: :ok
    end
  end

  private

  def find_vote
    parent = controller_name.singularize.classify.constantize.find(params[:id])
    @vote = parent.votes.find_or_create_by(user_id: current_user.id)
    parent.vote_ids << @vote
    parent.save
    @vote
  end

  def parent
    controller_name.singularize.classify.constantize.find(params[:id])
  end
end
