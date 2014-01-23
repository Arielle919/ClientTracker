require_relative 'helper'
require 'sqlite3'

class TestEnteringClients < ClientTest
  def test_valid_client_gets_printed
    command = "./clienttracker add Sam Adams --date 01/25/2014 --task 'Sign Contract'"
    expected = "Theoretically creating: a Client named Sam Adams, appointment date: 01/25/2014 and Client Task: Sign Contract"
    assert_command_output expected, command
  end

  def test_valid_client_gets_saved
    `./clienttracker add Sam Adams --date 01/25/2014 --task 'Sign Contract' --environment test`
    results = database.execute("select Firstname, Lastname, Appointment, Task from Clients")
    expected = ["Sam", "Adams", "01/25/2014", "Sign Contract"]
    assert_equal expected, results[0]

    result = database.execute("select count(id) from Clients")
    assert_equal 1, result[0][0]
  end

  def test_invalid_client_doesnt_get_saved
    `./clienttracker add Sam Adams --date 01/25/2014`
    result = database.execute("select count(id) from Clients")
    assert_equal 0, result[0][0]
  end

  def test_error_message_for_missing_client_firstname_and_lastname
    command = "./clienttracker add"
    expected = "You must provide Client's first and lastname in order to add appointment and task.\nYou must provide the date and task for Client."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_date
    command = "./clienttracker add Sam Adams --task Needs to sign contract"
    expected = "You must provide the date for Client."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_task
    command = "./clienttracker add Sam Adams --date 01/25/2014"
    expected = "You must provide task for Client."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_date_and_task
    command = "./clienttracker add Sam Adams"
    expected = "You must provide the date and task for Client."
    assert_command_output expected, command
  end


end


