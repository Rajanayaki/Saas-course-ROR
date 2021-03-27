require "./connect_db.rb"
require "active_record"
require "date"

connect_db!

class Todo < ActiveRecord::Base
  def due_today?
    due_date == Date.today
  end

  def self.add_task(task)
    todo_task = { "todo_text" => task[:todo_text], "due_date" => Date.today + task[:due_in_days], "completed" => false }
    @todo = Todo.create(todo_task)
  end

  def self.mark_as_complete!(id)
    todo = all.find { id }
  end

  def to_displayable_string
    display_status = completed ? "[X]" : "[]"
    display_date = due_today? ? nil : due_date
    puts "#{id}. #{display_status} #{todo_text} #{display_date}"
  end

  def self.show_list
    puts "My Todo-list"
    puts "Overdue"
    all.each { |todo|
      if todo.due_date < Date.today
        puts todo.to_displayable_string
      end
    }
    puts "Due Today"
    all.each { |todo|
      if todo.due_date == Date.today
        puts todo.to_displayable_string
      end
    }
    puts "Due Later"
    all.each { |todo|
      if todo.due_date > Date.today
        puts todo.to_displayable_string
      end
    }
  end
end
