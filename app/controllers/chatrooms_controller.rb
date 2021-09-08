class ChatroomsController < ApplicationController
  before_action :load_chatrooms

  def index
    # @chatrooms = Chatroom.where(user: current_user)
    # if the product of the chatroom is included in the product of the user
    # so select chatrooms if the chatroom.user is the current user or their products are
    # included in the products of the chatroom
    @chatrooms = Chatroom.all.select do |chatroom|
      chatroom.user == current_user || current_user.products.include?(chatroom.product)
    end
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    redirect_to chats_path if current_user != @chatroom.product.user && current_user != @chatroom.user

    @message = Message.new
    @chatrooms = Chatroom.all.select do |chatroom|
      chatroom.user == current_user || current_user.products.include?(chatroom.product)
    end
  end

  def new
    @product = Product.find(params[:product_id])
    @chatroom = Chatroom.find_by(user: current_user, product: @product)
    if @chatroom
      redirect_to chatroom_path(@chatroom)
    else
      @chatroom = Chatroom.new
      create
    end
  end

  def create
    @product = Product.find(params[:product_id])
    # chatroom_params basically works like a hash with key value pairs
    # so we can call the .merge method on it
    # this allows us to append additional key value pairs
    # because a chatroom belongs to a user and a product
    # we need to append the value for a user and a product to it
    # thus we .merge product = @product where that is Product.find(product_params)
    # and the user is the current user aka the client
    @new_chatroom = Chatroom.new
    @new_chatroom.product = @product
    @new_chatroom.user = current_user
    # problem is, now need to work out how to make it so that if a chatroom already exists
    # with current user and current product
    # render the existing chatroom instead of making a new one
    # iterate through all chatrooms and check if a user == current user and
    # a @chatroom.product is same as current product?
    # @chatrooms.each do |chatroom|
    #   if chatroom.user == current_user && @chatroom.product == @product
    #   redirect_to chatroom_path(@chatroom)
    if @new_chatroom.save
      flash[:success] = "Room #{@new_chatroom.name} was created successfully"
      redirect_to chatroom_path(@new_chatroom)
    else
      @product = Product.find(params[:product_id])
      render :new
    end
  end

  def destroy
    @chatroom.destroy
    redirect_to chats_path
  end

  private

  def load_chatrooms
    @chatrooms = Chatroom.all
    @chatroom = Chatroom.find(params[:id]) if params[:id]
  end

  def chatroom_parameters
    params.require(:chatroom).permit(:name, :product_id)
  end
end
