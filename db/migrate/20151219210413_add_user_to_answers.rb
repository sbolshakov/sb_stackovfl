class AddUserToAnswers < ActiveRecord::Migration
  def change

    add_belongs_to :answers, :user, index: true, foreign_key: true

  end
end
