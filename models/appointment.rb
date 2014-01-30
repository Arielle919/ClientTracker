class Appointment
  attr_accessor :name
  attr_reader :id

  def initialize(name)
    self.name = name
  end

  def name=(name)
    @name = name.strip
  end

  def self.all
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from appointments order by name ASC")
    results.map do |row_hash|
      appointment = Appointment.new(row_hash["name"])
      appointment.send("id=", row_hash["id"])
      appointment
    end
  end

  def self.find_or_create name
    database = Environment.database_connection
    database.results_as_hash = true
    appointment = Appointment.new(name)
    results = database.execute("select * from appointments where name = '#{appointment.name}'")

    if results.empty?
      # database.execute("insert into appointments(name) values('#{appointment.name}')")
      database.execute("insert into appointments(clientID, name, appointment, needAppointment) values(@id, '#{name}', '#{appointment}', '#{needAppointment}')")

      appointment.send("id=", database.last_insert_row_id)
    else
      row_hash = results[0]
      appointment.send("id=", row_hash["id"])
    end
    appointment
  end

  protected

  def id=(id)
    @id = id
  end
end
