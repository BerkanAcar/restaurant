class CommentsController < ApplicationController
  before_action :authenticate_customer!
  before_action :get_comment, only: [:update, :destroy, :edit]
  before_action :get_place, only: [:create, :update, :destroy, :edit]
  before_action :authorize_customer!, only: [:edit, :update, :destroy]
  
  def create
    @comment = @place.comments.new(comment_params)
    @comment.customer_id = current_customer.id
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
  end

  def update
    if @comment.update(comment_params)
      redirect_to place_path(@place)
    else
      flash.now[:danger] = "error"
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to place_path(@place)
  end

  private

  def get_comment
    @comment = Comment.find(params[:id])
  end

    def authorize_customer!
      redirect_to root_path, notice: 'Başkalarının yorumlarına müdahele edemezsin!!!' unless @comment.customer_id == current_customer.id
    end

    def get_place
      @place = Place.find(params[:place_id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
end
