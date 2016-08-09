require 'spec_helper'

describe "Editing todo lists" do
	# Creates a TodoList object for each of the tests when they run
	let!(:todo_list) { TodoList.create(title: "Groceries", description: "Grocery list.") }

	def update_todo_list(options={})
		options[:title] ||= "My todo list"
		options[:description] ||= "This is my todo list"
		todo_list = options[:todo_list]
		# Go to todo_lists path in the browser
		visit "/todo_lists"
		# Use CSS id selector with the current todo_list object's id
		# That way the correct "Edit" link is clicked
		within "#todo_list_#{todo_list.id}" do
			click_link "Edit"
		end
		# Fills out and submits the updated todo list item
		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Update Todo list"
	end

	it "updates a todo list successfully with correct information" do
		
		update_todo_list(todo_list: todo_list, title: "New title", description: "New description")
		# Takes the most recently used variable from the database and reloads it
		todo_list.reload

		expect(page).to have_content("Todo list was successfully updated")
		expect(todo_list.title).to eq("New title")
		expect(todo_list.description).to eq("New description")
	end

	it "displays an error when there's no title" do
		update_todo_list(todo_list: todo_list, title: "", description: "New description")
		expect(page).to have_content("error")
	end

	it "displays an error when the title is too short" do
		update_todo_list(todo_list: todo_list, title: "Oh", description: "New description")
		expect(page).to have_content("error")
	end

	it "displays an error when there is no description given" do
		update_todo_list(todo_list: todo_list, title: "New title", description: "")
		expect(page).to have_content("error")
	end

	it "displays an error when the description is too short" do
		update_todo_list(todo_list: todo_list, title: "New title", description: "Nope")
		expect(page).to have_content("error")
	end
end
