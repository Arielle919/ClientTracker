require_relative 'helper'

class TestListingClients < ClientTest
  def test_list_returns_relevant_results
    # create will be new+save
    sam_adams = Client.create(name: "Sam Adams", appointment: "01/20/2014", task: "Sign Docs")
    sam_jones = Client.create(name: "Sam Jones", appointment: "01/27/2014", task: "Sign Paper")
    tim_collins = Client.create(name: "Tim Collins", appointment: "01/25/2014", task: "Sign Contract")

    command = "./clienttracker list"
    expected = <<EOS.chomp
All Clients:
Sam Adams: 01/20/2014, Sign Docs, id: #{sam_adams.id}
Sam Jones: 01/27/2014, Sign Paper, id: #{sam_jones.id}
Tim Collins: 01/25/2014, Sign Contract, id: #{tim_collins.id}
EOS
    assert_command_output expected, command
  end
end
