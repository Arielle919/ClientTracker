require_relative 'helper'

class TestListingClients < ClientTest
  def test_list_returns_relevant_results
    sam_adams = Client.create(name: "Sam Adams", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")
    sam_jones = Client.create(name: "Sam Jones", appointment: "01/27/2014", tasks: "Sign Paper", need_appointment: "no", task_completed: "yes")
    tim_collins = Client.create(name: "Tim Collins", appointment: "01/25/2014", tasks: "Sign Contract", need_appointment: "no", task_completed: "yes")

    command_output = `./clienttracker list --environment test`
    assert_includes_in_order command_output,
      "All Clients:",
      "ID        NAME        APPOINTMENT        TASK",
      "#{sam_adams.id} -- Sam Adams -- 01/20/2014 -- Sign Docs -- no -- yes",
      "#{sam_jones.id} -- Sam Jones -- 01/27/2014 -- Sign Paper -- no -- yes",
      "#{tim_collins.id} -- Tim Collins -- 01/25/2014 -- Sign Contract -- no -- yes"
  end
end
