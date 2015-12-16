class AnswersController < ApplicationController
  before_action :authenticate_user!

  def new
    @answer = Answer.new
    @question = Question.find(params[:question_id])
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    if @answer.save
      redirect_to questions_path, notice: 'Your answer was successfully submitted!'
    else
      render :new
    end
  end

  def answer_params
    params.require(:answer).permit(:body)
  end

end
