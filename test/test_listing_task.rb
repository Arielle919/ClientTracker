require_relative 'helper'

class TestListingTasks < ClientTest
def test_client_incomplete_task_list_returns_relevant_results
    sammy_cole = Task.create(name: "Sammy Cole", appointment: "none", task: "Read Docs", taskCompleted: "no")
    sam_jones = Task.create(name: "Sam Jones", appointment: "none", task: "Sign Paper", taskCompleted: "no")
    tim_collins = Task.create(name: "Tim Collins", appointment: "none", task: "Sign Contract", taskCompleted: "no")

    command = "./clienttracker 'task processing'"
    expected = <<EOS.chomp
Incomplete Task:
#{sammy_cole.id} Sammy Cole Read Docs
#{sam_jones.id} Sam Jones Sign Paper
#{tim_collins.id} Tim Collins Sign Contract
EOS
    assert_command_output expected, command
  end

end
