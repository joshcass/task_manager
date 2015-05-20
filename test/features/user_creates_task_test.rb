require_relative '../test_helper'

class UserCreatesTaskTest < FeatureTest
  def test_creating_a_task
    visit '/tasks/new'
    fill_in 'task[title]', with: 'do something'
    fill_in 'task[description]', with: "don't put it off lazy ass"
    first('input[type="submit"]').click

    within('#task') do
      assert page.has_content?("do something")
    end
  end
end
