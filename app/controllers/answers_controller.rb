class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_answer, only: [:destroy]

  def new
    @answer = Answer.new
    @question = Question.find(params[:question_id])
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    if @answer.save
      redirect_to questions_path, notice: 'Your answer was successfully submitted!'
    else
      render :new
    end
  end

  def destroy

    @answer.destroy if current_user.author_of?(@answer)
    redirect_to question_path(@answer.question)

  end

  def answer_params
    params.require(:answer).permit(:body)
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

end
