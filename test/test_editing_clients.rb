require_relative 'helper'

class TestEditingClients < ClientTest
  def test_updating_a_record_that_exists
    client = Client.new(name: "Sam Adams", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")
    client.save
    id = client.id
    command = "./clienttracker edit --id #{id} --name 'Sam Adams' --appointment 01/20/2014 --task 'Sign Docs' --need_appointment no task_completed yes"
    expected = "Client #{id} is now named Sam Adams, 01/20/2014, Sign Docs, no, yes"
    assert_command_output expected, command
  end

  def test_attempting_to_update_a_nonexistant_record
    command = "./clienttracker edit --id 218903123980123 --name 'Sam Adams' --appointment 01/20/2014 --task 'Sign Docs' --need_appointment no task_completed yes"
    expected = "Client 218903123980123 couldn't be found."
    assert_command_output expected, command
  end

  def test_attempting_to_update_with_no_changes
    client = Client.new(name: "Sam Adams", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")
    client.save
    id = client.id
    command = "./clienttracker edit --id #{id} --name 'Sam Adams' --appointment 01/20/2014 --task 'Sign Docs' --need_appointment no task_completed yes"
    expected = "Client #{id} is now named Sam Adams, 01/20/2014, Sign Docs, no, yes"
    assert_command_output expected, command
  end

  def test_attempting_to_update_with_bad_appointment_data
    skip
    client = Client.new(name: "Sam Adams", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")
    client.save
    id = client.id
    command = "./clienttracker edit --id #{id} --name 'Sam Adams' --appointment 01/20/2014 --task 'Sign Docs' --need_appointment no task_completed yes"
    expected = "Client can't be updated.  Date must be in this format: mm/dd/yyyy."
    assert_command_output expected, command
  end

  def test_attempting_to_update_partial_data_only_name
    client = Client.new(name: "Sam Adams", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")
    client.save
    id = client.id
    command = "./clienttracker edit --id #{id} --name 'Sammy Adams' --appointment 01/20/2014 --task 'Sign Docs' --need_appointment no task_completed yes"
    expected = "Client #{id} is now named Sammy Adams, 01/20/2014, Sign Docs, no, yes"
    assert_command_output expected, command
  end
end