class ContentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_content, only: %i[show edit destroy update]
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
      associate_tags!
      redirect_to contents_path, notice: 'Content Sucessfully created'
    else
      render :new
    end
  end

  def update
    if @content.update(content_params)
      associate_tags!
      redirect_to contents_path, notice: 'Content Sucessfully created'
    else
      render :edit
    end
  end

  def show; end

  def destroy
    @content.destroy
    redirect_to contents_path, notice: 'Content successfully destroyed!'
  end

  def edit; end

  def set_content
    @content = Content.find(params[:id])
  end

  def tags_params
    params.require(:content).permit(tags: [])[:tags].reject(&:blank?)
  end

  def associate_tags!
    tags = tags_params.map do |tag_name|
      current_user.tags.where(name: tag_name).first_or_initialize
    end
    @content.tags = tags
  end

  def content_params
    params.require(:content).permit(:title, :description)
  end
end
