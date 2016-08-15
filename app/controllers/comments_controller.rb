class CommentsController < ApplicationController
  before_action :get_place, only: [:create, :update, :destroy, :edit]
  def create
    @comment = @place.comments.new(comment_params)
    #@comment.place_id = @place.id
    if @comment.save
      redirect_to place_path(@place)
    else
      flash[:danger] = "Yorum boş olamaz."
      redirect_to place_path(@place)
      #render template: 'places/show'
    end
  end

  def edit
    @comment = @place.comments.find(params[:id])
  end

  def update
    @place.comments.find(params[:id])
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to place_path(@place)
    else
      flash.now[:danger] = "error"
      render :edit
    end
  end

  def destroy
    @comment = @place.comments.find(params[:id])
    @comment.destroy
    redirect_to place_path(@place)
  end

  private
    def get_place
      @place = Place.find(params[:place_id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
end
