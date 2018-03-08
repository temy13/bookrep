class LikesController < ApplicationController

  before_action :set_vars

  #ajax only
  def create
    if @likes.blank?
      @like = Like.new(user_id: params[:user_id], answer_id: params[:answer_id], like: true)
      @like.save
    else
      @likes.map{|like|
        like.like = true
        like.save
      }
    end
    respond_to do |format|
      format.js {}
    end
  end

  def destroy
    @likes.map{|like|
      like.like = false
      like.save
    } if @likes.present?
    respond_to do |format|
      format.js {}
    end
  end

  private
  def set_vars
    # params = params[:field]
    @answer = Answer.find(params[:answer_id])
    @likes = Like.where(user_id: params[:user_id], answer_id: params[:answer_id])
    @user = current_user
  end
  # # Never trust parameters from the scary internet, only allow the white list through.
  # def like_params
  #   params.require(:like).permit(:user_id, :answer_id)
  # end

end
