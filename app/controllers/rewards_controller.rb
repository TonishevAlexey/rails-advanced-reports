class RewardsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @rewards = current_user.rewards
  end

end
