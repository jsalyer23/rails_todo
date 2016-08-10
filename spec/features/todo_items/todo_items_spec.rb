require 'spec_helper'

describe "Viewing todo items" do
	let!(:todo_list) { TodoList.create(title: "Groceries", description: "Grocery list")}

	def visit_todo_list(list)
		visit "/todo_lists"
		within "#todo_list_#{list.id}" do
			click_link "List Items"
		end
	end

	it "displays the title of the todo list on the page" do
		visit_todo_list(todo_list)
		within("h1") do
			expect(page).to have_content(todo_list.title)
		end
	end

	it "displays no items when the todo list is empty" do 
		visit_todo_list(todo_list)
		expect(page.all("ul.todo_items li").size).to eq(0)
	end
end