require_relative 'helper'

class TestSearchingClients < ClientTest
  def test_search_returns_relevant_results
    `./clienttracker add 'Sam Adams' --appointment 01/20/2014 --task 'Sign Docs' --environment test`
    `./clienttracker add 'Sam Jenkins' --appointment 01/21/2014 --task 'Sign Papers' --environment test`
    `./clienttracker add 'Tim Web' --appointment 01/22/2014 --task 'Sign Contract' --environment test`

    shell_output = ""
    IO.popen('./clienttracker search --environment test', 'r+') do |pipe|
      pipe.puts("Sam")
      pipe.close_write
      shell_output = pipe.read
    end
    assert_in_output shell_output, "Sam Adams", "Sam Jenkins"
    assert_not_in_output shell_output, "Tim Web"
  end
end
