class CommentsController < ApplicationController
  before_action :get_place, only: [:create, :update, :show, :destroy]
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

  def show
    @comment = @place.comments.find(params[:id])
  end

  def edit
    
  end

  def update
    @place.comments.find(params[:id])
    if @place.comments.update(comment_params)
      redirect_to edit_place_comment_path(@comment)
    else
      flash.now[:danger] = "error"
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
