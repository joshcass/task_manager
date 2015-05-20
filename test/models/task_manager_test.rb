require_relative '../test_helper'

class TaskManagerTest < Minitest::Test
  def task_manger_for(*hashes)
    hashes.each {|data| TaskManager.create(data)}
  end

  def test_can_create_a_task
    task_manger_for({ :title       => "learn sinatra",
                         :description => "for realz!" })

    task = TaskManager.find(1)

    assert_equal "learn sinatra", task.title
    assert_equal "for realz!", task.description
    assert_equal 1, task.id
  end

  def test_can_return_all_tasks
    task_manger_for({:title       => "num 1",
                        :description => "descript"},
                       {:title       => "num 2",
                        :description => "descript2"})

    assert_equal 2, TaskManager.all.count
    assert_equal ["num 1", "num 2"], TaskManager.all.map(&:title)
  end

  def test_it_can_find_a_task
    task_manger_for({:title       => "num1",
                        :description => "script1"},
                       {:title       => "num2",
                        :description => "script2" },
                       {:title       => "num3",
                        :description => "script3"})

    task = TaskManager.find(2)

    assert_equal "num2", task.title
    assert_equal "script2", task.description
    assert_equal 2, task.id
  end

  def test_it_can_update_a_task
    task_manger_for({ :title       => "learn sinatra",
                         :description => "for realz!"})
    update_data = {:title       => "new",
                   :description => "newscript"}

    task = TaskManager.find(1)
    TaskManager.update(1, update_data)
    task_update = TaskManager.find(1)

    assert_equal "learn sinatra", task.title
    assert_equal "for realz!", task.description
    assert_equal 1, task.id

    assert_equal "new", task_update.title
    assert_equal "newscript", task_update.description
    assert_equal 1, task_update.id
  end

  def test_it_can_delete_a_task
    task_manger_for({:title       => "num1",
                        :description => "script1"},
                       {:title       => "num2",
                        :description => "script2" },
                       {:title       => "num3",
                        :description => "script3"})


    assert_equal 3, TaskManager.all.count
    assert_equal 2, TaskManager.find(2).id

    TaskManager.destroy(2)

    assert_equal 2, TaskManager.all.count
    assert_equal nil, TaskManager.raw_task(2)
  end
end
