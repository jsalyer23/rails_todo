class TodoItemsController < ApplicationController
  def index
  	@todo_list = TodoList.find(params[:todo_list_id])
    @todo_items = TodoItem.where(todo_list_id: @todo_list.id)
  end

  def new
  	@todo_list = TodoList.find(params[:todo_list_id])
  	@todo_item = @todo_list.todo_items.new
  end

  def create
  	@todo_list = TodoList.find(params[:todo_list_id])
  	@todo_item = @todo_list.todo_items.new(todo_item_params)

  	if @todo_item.save
  		flash[:success] = "Added todo list item"
  		redirect_to todo_list_todo_item_path(@todo_list.id, @todo_item.todo_list_id)
  	else
  		flash[:error] = "Your new todo list item has NOT been saved"
  		render action: :new
  	end
  end

  def show
    @todo_items = TodoItem.where(todo_list_id: params[:todo_list_id])
  end

  private
  def todo_item_params
  	params[:todo_item].permit(:content)
  end
end
