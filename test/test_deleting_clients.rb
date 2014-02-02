require_relative 'helper'

class TestDeletingClients < ClientTest
  def test_printing_a_correct_deleted_client
    client = Client.new(name: "Sam Adams", appointment: "01/20/2014", task: "Sign Contract")
    client.save
    id = client.id
    command = "./clienttracker delete --id #{id}"
    expected = "client '#{client.id}' named: '#{client.name}' was deleted."
    assert_command_output expected, command
  end

  def test_attempting_to_delete_a_nonexistant_record
    command = "./clienttracker delete --id 343456562312"
    expected = "Client Id doesn't exist!!!"
    assert_command_output expected, command
  end

end
