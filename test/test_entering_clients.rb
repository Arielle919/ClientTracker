require_relative 'helper'

class TestEnteringClients < MiniTest::Unit::TestCase
  def test_valid_client_gets_printed
    command = "./clienttracker add Sam Adams --date 01/25/2014 --task Sign Contract"
    expected = "Theoretically creating: a Client named Sam Adams, appointment date: 01/25/2014 and Client Task: Sign Contract"
    assert_command_output expected, command
  end

  def test_valid_client_gets_saved
    skip "needs implementation"
    assert false, "Missing test implementation"
  end

  def test_invalid_client_doesnt_get_saved
    skip "needs implementation"
    assert false, "Missing test implementation"
  end

  def test_error_message_for_missing_client_firstname_and_lastname
    command = "./clienttracker add"
    expected = "You must provide Client's first and lastname in order to add appointment and task."
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


