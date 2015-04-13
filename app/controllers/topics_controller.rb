class TopicsController < ApplicationController
  before_action :set_topic, :only => [ :show, :edit, :update, :destroy]
  def set_topic
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    flash[:notice] = "topic was successfully created"
    @topic = Topic.new(topic_params)
    if @topic.save
      redirect_to :action => :index
    else
      render :action => :new
    end
  end

  def edit

  end

  def update
    flash[:notice] = "topic was successfully updated"
    if @topic.update(topic_params)
      redirect_to topic_url(@topic)
    else
      render :action => :edit
    end
  end

  def show
    respond_to do |format|
      format.html { @page_title = @topic.title } # show.html.erb
      format.json { render :json => @topic.to_json }

  end
  end

  def index
    @topics = Topic.page(params[:page]).per(10)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @topics.to_json }
  end
  end

  def destroy
    flash[:alert] = "topic was successfully deleted"
    @topic.destroy

    redirect_to topics_url
  end

    private
      def topic_params
        params.require(:topic).permit(:title, :cover, :content)
      end
end
