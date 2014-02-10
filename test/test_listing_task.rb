require_relative 'helper'

class TestListingTasks < ClientTest

  def test_client_incomplete_task_list_returns_relevant_results
    sam_adams = Client.create(name: "Sam Adams", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "no")
    sam_jones = Client.create(name: "Sam Jones", appointment: "01/27/2014", tasks: "Sign Paper", need_appointment: "no", task_completed: "no")
    tim_collins = Client.create(name: "Tim Collins", appointment: "01/25/2014", tasks: "Sign Contract", need_appointment: "no", task_completed: "no")

    command_output = `./clienttracker 'task incomplete' --environment test`
    assert_includes_in_order command_output,
      "Incomplete Task:",
      "ID        NAME        APPOINTMENT        TASK",
      "#{sam_adams.id} -- Sam Adams -- 01/20/2014 -- Sign Docs -- no -- no",
      "#{sam_jones.id} -- Sam Jones -- 01/27/2014 -- Sign Paper -- no -- no",
      "#{tim_collins.id} -- Tim Collins -- 01/25/2014 -- Sign Contract -- no -- no"
  end

  def test_client_complete_task_list_returns_relevant_results
    sam_adams = Client.create(name: "Sam Adams", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")
    sam_jones = Client.create(name: "Sam Jones", appointment: "01/27/2014", tasks: "Sign Paper", need_appointment: "no", task_completed: "yes")
    tim_collins = Client.create(name: "Tim Collins", appointment: "01/25/2014", tasks: "Sign Contract", need_appointment: "no", task_completed: "yes")

    command_output = `./clienttracker 'task complete' --environment test`
    assert_includes_in_order command_output,
      "Complete Task:",
      "ID        NAME        APPOINTMENT        TASK",
      "#{sam_adams.id} -- Sam Adams -- 01/20/2014 -- Sign Docs -- no -- yes",
      "#{sam_jones.id} -- Sam Jones -- 01/27/2014 -- Sign Paper -- no -- yes",
      "#{tim_collins.id} -- Tim Collins -- 01/25/2014 -- Sign Contract -- no -- yes"
  end

  def test_client_task_list_returns_relevant_results
    sam_adams = Client.create(name: "Sam Adams", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")
    sam_jones = Client.create(name: "Sam Jones", appointment: "01/27/2014", tasks: "Sign Paper", need_appointment: "no", task_completed: "yes")
    tim_collins = Client.create(name: "Tim Collins", appointment: "01/25/2014", tasks: "Sign Contract", need_appointment: "no", task_completed: "yes")

    command_output = `./clienttracker 'client tasks' --name 'Sam Adams' --environment test`
    assert_includes_in_order command_output,
      "All Tasks for #{sam_adams.name}:",
      "ID        NAME        APPOINTMENT        TASK",
      "#{sam_adams.id} -- Sam Adams -- 01/20/2014 -- Sign Docs -- no -- yes"
  end

end



