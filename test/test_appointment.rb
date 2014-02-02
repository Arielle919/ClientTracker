require_relative 'helper'

class TestListingAppointments < ClientTest
def test_client_appointment_list_returns_relevant_results
    sammy_cole = Appointment.create(name: "Sammy Cole", appointment: "02/20/2014", task: "Read Docs")
    sam_jones = Appointment.create(name: "Sam Jones", appointment: "01/27/2014", task: "Sign Paper")
    tim_collins = Appointment.create(name: "Tim Collins", appointment: "01/25/2014", task: "Sign Contract")

    command = "./clienttracker 'client appointments' --name 'Sammy Cole'"
    expected = <<EOS.chomp
All Appointments for #{sammy_cole.name}:
#{sammy_cole.id} Sammy Cole 02/20/2014
EOS
    assert_command_output expected, command
  end

def test_client_need_appointment_list_returns_relevant_results
    sammy_cole = Appointment.create(name: "Sammy Cole", appointment: "none", task: "Read Docs", needAppointment: "yes")
    sam_jones = Appointment.create(name: "Sam Jones", appointment: "none", task: "Sign Paper", needAppointment: "yes")
    tim_collins = Appointment.create(name: "Tim Collins", appointment: "none", task: "Sign Contract", needAppointment: "yes")

    command = "./clienttracker 'need appointments'"
    expected = <<EOS.chomp
Clients Need Appointments:
#{sammy_cole.id} Sammy Cole
#{sam_jones.id} Sam Jones
#{tim_collins.id} Tim Collins
EOS
    assert_command_output expected, command
  end

end
