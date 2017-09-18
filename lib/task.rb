class Task
  attr_reader(:description, :list_id, :deadline)

  def initialize(attributes)
    @description = attributes.fetch(:description)
    @list_id = attributes.fetch(:list_id)
    @deadline = attributes.fetch(:deadline)
  end

  def self.all
    returned_tasks = DB.exec("SELECT * FROM tasks;")
    tasks = []
    returned_tasks.each() do |task|
      description = task.fetch("description")
      list_id = task.fetch("list_id").to_i() # The information comes out of the database as a string.
      deadline = task.fetch("deadline")
      tasks.push(Task.new({:description => description, :list_id => list_id, :deadline => deadline}))
    end
    tasks
  end

  def save
    DB.exec("INSERT INTO tasks (description, list_id, deadline) VALUES ('#{@description}', '#{@list_id}', '#{@deadline};')")
  end

  def ==(another_task)
    (self.description.==another_task.description).&(self.list_id.==another_task.list_id).&(self.deadline.==another_task.deadline)
  end

  def sort
    task_deadline = DB.exec("SELECT description FROM tasks ORDER BY deadline;")
  end

end
