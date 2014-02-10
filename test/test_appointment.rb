require_relative 'helper'

class TestListingAppointments < ClientTest
def test_client_appointment_list_returns_relevant_results
    sammy_cole = Client.create(name: "Sammy Cole", appointment: "02/20/2014", tasks: "Read Docs")
    sam_jones = Client.create(name: "Sam Jones", appointment: "01/27/2014", tasks: "Sign Paper")
    tim_collins = Client.create(name: "Tim Collins", appointment: "01/25/2014", tasks: "Sign Contract")

    command_output = `./clienttracker 'client appointments' --name 'Sammy Cole' --environment test`
    assert_includes_in_order command_output,
      "All Appointments for #{sammy_cole.name}:",
      "ID          NAME          APPOINTMENT",
      "#{sammy_cole.id} --  Sammy Cole --  02/20/2014"
  end

end
