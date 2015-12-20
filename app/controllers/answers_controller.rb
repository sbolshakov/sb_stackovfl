class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_answer, only: [:edit, :update, :destroy]
  before_action :authorized, only: [:edit, :update, :destroy]

  def new
    @answer = Answer.new
    @question = Question.find(params[:question_id])
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    if @answer.save
#      redirect_to @answer.question, notice: 'Your answer was successfully submitted!'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @answer.update(answer_params)
      redirect_to @answer.question, notice: 'Your answer was successfully updated!'
    else
      render :edit
    end
  end

  def destroy

    @answer.destroy
    # redirect_to question_path(@answer.question)

  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def authorized
    unless current_user.author_of?(@answer)
      redirect_to new_user_session_path
    end
  end

end
