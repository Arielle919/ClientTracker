require_relative 'helper'

class TestSearchingClients < ClientTest
  def test_search_returns_relevant_results
    Client.create(name: "Sam Adams", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")
    Client.create(name: "Sam Jones", appointment: "01/27/2014", tasks: "Sign Paper", need_appointment: "no", task_completed: "yes")
    Client.create(name: "Tim Collins", appointment: "01/25/2014", tasks: "Sign Contract", need_appointment: "no", task_completed: "yes")

    shell_output = ""
    IO.popen('./clienttracker search --environment test', 'r+') do |pipe|
      pipe.puts("Sam")
      pipe.close_write
      shell_output = pipe.read
    end
    assert_in_output shell_output, "Sam Adams", "Sam Jones"
    assert_not_in_output shell_output, "Tim Collins"
  end
end