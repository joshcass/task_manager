require_relative '../test_helper'

class UserEditTask < FeatureTest
  def setup
   data = {:title => "do something",
           :description => "try harder!"}
   TaskManager.create(data)
  end

  def test_edit_task
    visit '/tasks'
    click_on 'Edit'

    fill_in 'task[title]', with: "don't do it"
    fill_in 'task[description]', with: "seriously don't"
    first('input[type="submit"]').click

    within('#task_title') do
      assert page.has_content?("don't do it")
    end
  end
end
