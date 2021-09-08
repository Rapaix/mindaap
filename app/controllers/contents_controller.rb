class ContentsController < ApplicationController
  before_action :authenticate_user!
  def index
    @contents = current_user.contents
  end

  # toma cuidado com a grafia dos atributos
  def new
    @content = Content.new
  end

  def create
    # byebug
    @content = current_user.contents.build(content_params)

    if @content.save
      redirect_to contents_path, notice: 'Content Sucessfully created'
    else
      render :new
    end
  end

  def edit
    @content = Content.find(params[:id])
  end

  def content_params
    params.require(:content).permit(:title, :description)
  end
end
