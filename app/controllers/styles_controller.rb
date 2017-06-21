class StylesController < ApplicationController
  before_action :set_style, only: [:show, :edit, :update, :destroy]

  # GET /styles
  # GET /styles.json
  def index
    @styles = Style.all
  end

  # GET /styles/1
  # GET /styles/1.json
  def show
  end

  # GET /styles/new
  def new
    @style = Style.new
  end

  # GET /styles/1/edit
  def edit
  end

  # POST /styles
  # POST /styles.json
  def create
    @style = Style.new()
    @style.name = style_params['name']
    @style.user_id = current_user.id
    tag_array = style_params['tags'].split(',')
    tag_array.each do |x|     
      if Tag.find_by(desc: x)
        @tag = Tag.find_by(desc: x)
      else
        @tag = Tag.create(desc: x)
      end
       @style.tags << @tag
        # StyleTag.create(style_id: @style.id, tag_id: @tag.id)
    end

    respond_to do |format|
      if @style.save
        params[:style]['images'].each do |a|
        @style_photo = @style.style_photos.create!(:image => a, :style_id => @style.id)
       end
        format.html { redirect_to @style, notice: 'Style was successfully created.' }
        format.json { render :show, status: :created, location: @style }
      else
        format.html { render :new }
        format.json { render json: @style.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /styles/1
  # PATCH/PUT /styles/1.json
  def update
        tag_array = style_params2['tags'].split(',')
    tag_array.each do |x|     
      if Tag.find_by(desc: x)
        @tag = Tag.find_by(desc: x)
      else
        @tag = Tag.create(desc: x)
      end
       @style.tags << @tag
        # StyleTag.create(style_id: @style.id, tag_id: @tag.id)
    end

    respond_to do |format|
      if @style.update(style_params)
        format.html { redirect_to @style, notice: 'Style was successfully updated.' }
        format.json { render :show, status: :ok, location: @style }
      else
        format.html { render :edit }
        format.json { render json: @style.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /styles/1
  # DELETE /styles/1.json
  def destroy
    @style.destroy
    respond_to do |format|
      format.html { redirect_to styles_url, notice: 'Style was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_style
      @style = Style.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def style_params
      params.require(:style).permit(:name, :user_id, style_photos_attributes: [:id, :style_id, :image])
    end

    def style_params2
      params.require(:style).permit(:tags)
    end
end
