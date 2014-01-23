require_relative 'helper'
require 'sqlite3'

class TestSearchingClients < ClientTest
  def test_search_returns_relevant_results
    `./clienttracker add Sam Adams --date 01/20/2014 --task "sign contract" --environment test`
    `./clienttracker add Tim Doe --date 01/25/2014 --task "sign docs" --environment test`
    `./clienttracker add Tim Jones --date 01/26/2014 --task "sign documents" --environment test`

    shell_output = ""
    IO.popen('./clienttracker search', 'r+') do |pipe|
      pipe.puts("Tim")
      pipe.close_write
      shell_output = pipe.read
    end
    assert_in_output shell_output, "Tim Doe", "Tim Jones"
    assert_not_in_output shell_output, "Sam Adams"
  end
end
