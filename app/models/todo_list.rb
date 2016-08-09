class TodoList < ActiveRecord::Base
	validates :title, presense: true
	validates :title, length: { minimum: 3 }
end
