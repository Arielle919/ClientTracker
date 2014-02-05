require_relative 'helper'

class TestListingTasks < ClientTest

def test_client_incomplete_task_list_returns_relevant_results
    sammy_cole = Task.create(name: "Sammy Cole", appointment: "none", task: "Read Docs", taskCompleted: "no")
    sam_jones = Task.create(name: "Sam Jones", appointment: "none", task: "Sign Paper", taskCompleted: "no")
    tim_collins = Task.create(name: "Tim Collins", appointment: "none", task: "Sign Contract", taskCompleted: "no")

    command = "./clienttracker 'task incomplete'"
    expected = <<EOS.chomp
Incomplete Task:
ID          NAME          APPOINTMENT          TASK
#{sammy_cole.id} --  Sammy Cole --  none --  Read Docs
#{sam_jones.id} --  Sam Jones --  none --  Sign Paper
#{tim_collins.id} --  Tim Collins --  none --  Sign Contract
EOS
  end

def test_client_complete_task_list_returns_relevant_results
    sammy_cole = Task.create(name: "Sammy Cole", appointment: "02/01/2014", task: "Read Docs", taskCompleted: "yes")
    sam_jones = Task.create(name: "Sam Jones", appointment: "02/02/2014", task: "Sign Paper", taskCompleted: "yes")
    tim_collins = Task.create(name: "Tim Collins", appointment: "02/03/2014", task: "Sign Contract", taskCompleted: "yes")

    command = "./clienttracker 'task complete'"
    expected = <<EOS.chomp
Task Complete:
ID         NAME         APPOINTMENT         TASK
#{sammy_cole.id} --  Sammy Cole --  02/01/2014 --  Read Docs
#{sam_jones.id} --  Sam Jones --  02/02/2014 --  Sign Paper
#{tim_collins.id} --  Tim Collins --  02/03/2014 --  Sign Contract
EOS
    assert_command_output expected, command
  end

end
