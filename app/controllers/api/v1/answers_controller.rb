module Api
  module V1
    class AnswersController < Api::V1::BaseController
      authorize_resource

      def index
        render json: question.answers
      end

      def show
        render json: answer
      end

      def create
        @answer = question.answers.new(answer_params)
        answer.user = current_resource_owner
        render json: @answer
      end

      def update
        if answer.update(answer_params)
          render json: answer
        else
          head :unprocessable_entity
        end
      end

      def destroy
        head :ok if answer.destroy
      end

      private

      def answer
        @answer ||= Answer.find(params[:id])
      end

      def question
        @question ||= Question.find(params[:question_id])
      end

      def answer_params
        params.require(:answer).permit(:body)
      end
    end
  end
end
