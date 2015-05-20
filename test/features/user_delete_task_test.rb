require_relative '../test_helper'

class UserEditTask < FeatureTest
  def setup
    data = {:title => "do something",
            :description => "try harder!"}
    TaskManager.create(data)
  end

  def test_edit_task
    visit '/tasks'
    click_on 'Delete!'

    refute page.has_content?("do something")
  end
end
