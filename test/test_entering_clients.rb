require_relative 'helper'

class TestEnteringClients < ClientTest
  def test_valid_client_information_gets_printed
    command = "./clienttracker add 'Sam Adams' --appointment 01/20/2014 --task 'Sign Docs'"
    expected = "A client named Sam Adams, 01/20/2014, Sign Docs was created."
    assert_command_output expected, command
  end

  def test_valid_client_gets_saved
    `./clienttracker add 'Sam Adams' --appointment 01/20/2014 --task 'Sign Docs' --environment test`
    database.results_as_hash = false
    results = database.execute("select name, appointment, task from clients")
    expected = ["Sam Adams", "01/20/2014", "Sign Docs"]
    assert_equal expected, results[0]

    result = database.execute("select count(id) from clients")
    assert_equal 1, result[0][0]
  end

  def test_invalid_client_doesnt_get_saved
    `./clienttracker add 'Sam Adams' --appointment 01/20/2014`
    result = database.execute("select count(id) from clients")
    assert_equal 0, result[0][0]
  end

  def test_error_message_for_missing_task
    command = "./clienttracker add 'Sam Adams' --appointment 01/20/2014"
    expected = "You must provide the task for the client you are adding."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_appointment_and_task
    command = "./clienttracker add 'Sam Adams'"
    expected = "You must provide the task and appointment for the client you are adding."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_appointment
    command = "./clienttracker add 'Sam Adams' --task 'sign papers'"
    expected = "You must provide the appointment for the client you are adding."
    assert_command_output expected, command
  end


  def test_error_message_for_missing_name
    command = "./clienttracker add"
    expected = "You must provide the name for the client you are adding.\nYou must provide the task and appointment for the client you are adding."
    assert_command_output expected, command
  end
end
