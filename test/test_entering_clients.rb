require_relative 'helper'

class TestEnteringClients < ClientTest
  def test_valid_client_information_gets_printed
    command = "./clienttracker add Sam --appointment 01/20/2014 --tasks 'Sign Docs' --need_appointment no task_completed yes"
    expected = "A client named Sam, 01/20/2014, Sign Docs, no, yes, was created."
    assert_command_output expected, command
  end

  def test_valid_client_gets_saved
    execute_popen("./clienttracker add Sam --appointment 01/20/2014 --tasks 'Sign Docs' --need_appointment no task_completed yes --environment test")
    client = Client.all.first
    expected = ["Sam", "01/20/2014", "Sign Docs", "no", "yes"]
    actual = [client.name, client.appointment, client.tasks, client.need_appointment, client.task_completed]
    assert_equal expected, actual
    assert_equal 1, Client.count
  end

  def test_invalid_client_doesnt_get_saved
    execute_popen("./clienttracker add 'Sam Adams' --appointment 01/20/2014")
    assert_equal 0, Client.count
  end

  def test_error_message_for_missing_task
    command = "./clienttracker add 'Sam Adams' --appointment 01/20/2014 --need_appointment no task_completed yes"
    expected = "You must provide the task for the client you are adding."
    assert_command_output expected, command
  end


  def test_error_message_for_missing_appointment_and_task
    command = "./clienttracker add 'Sam Adams'"
    expected = "You must provide the task and appointment for the client you are adding."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_appointment
    command = "./clienttracker 'Sam Adams' --tasks 'Sign Docs' --need_appointment no task_completed yes"
    expected = "You must provide the appointment for the client you are adding."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_name
    command = "./clienttracker add"
    expected = "You must provide the name for the client you are adding.  You must provide the task and appointment for the client you are adding."
    assert_command_output expected, command
  end
end