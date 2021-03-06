require("rspec")
require("pg")
require("task")
require("spec_helper")
require("pry")

DB = PG.connect({:dbname => 'to_do_test'})

describe(Task) do
  describe(".all") do
    it("is empty at first") do
      expect(Task.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("adds a task to the array of saved tasks") do
      test_task = Task.new({:description => "learn SQL", :list_id => 1, :deadline => "2017-09-10 00:00:00"})
      test_task.save()
      expect(Task.all()).to(eq([test_task]))
    end
  end

  describe("#description") do
    it("lets you read the description out") do
      test_task = Task.new({:description => "learn SQL", :list_id => 1, :deadline => "2017-09-10 00:00:00"})
      expect(test_task.description()).to(eq("learn SQL"))
    end
  end

  describe("#list_id") do
    it("lets you read the list ID out") do
      test_task = Task.new({:description => "learn SQL", :list_id => 1, :deadline => "2017-09-10 00:00:00"})
      expect(test_task.list_id()).to(eq(1))
    end
  end

  describe("#==") do
    it("is the same task if it has the same description and list ID") do
      task1 = Task.new({:description => "learn SQL", :list_id => 1, :deadline => "2017-09-10 00:00:00"})
      task2 = Task.new({:description => "learn SQL", :list_id => 1, :deadline => "2017-09-10 00:00:00"})
      expect(task1).to(eq(task2))
    end
  end

  describe("#sort") do
    it ("sorts tasks based on deadline parameter") do
      task1 = Task.new({:description => "learn SQL", :list_id => 1, :deadline => "2018-09-10 00:00:00"})
      task1.save()
      task2 = Task.new({:description => "learn SQL", :list_id => 2, :deadline => "2017-09-10 00:00:00"})
      task2.save()
      task3 = Task.new({:description => "learn SQL", :list_id => 3, :deadline => "2019-09-10 00:00:00"})
      task3.save()
      expect(Task.sort).to(eq([task2,task1,task3]))
    end
  end
end
