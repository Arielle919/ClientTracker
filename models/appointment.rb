class Appointment
  attr_accessor :name, :appointment, :task, :needAppointment
  attr_reader :id

  def initialize attributes = {}
    update_attributes(attributes)
  end

  def self.create(attributes = {})
    appointmentID = Appointment.new(attributes)
    appointmentID.save
    appointmentID
  end

  def update attributes = {}
    update_attributes(attributes)
    save
  end

  def save
    database = Environment.database_connection
    if id
      database.execute("update appointments set name = '#{name}', appointment = '#{appointment}', task = '#{task}', needAppointment = '#{needAppointment}' where id = #{id}")
    else
      database.execute("insert into appointments(name, appointment, task, needAppointment) values('#{name}', '#{appointment}', '#{task}', '#{needAppointment}')")
      # database.execute("insert into appointments(clientID, name, appointment, needAppointment) values(@id, '#{name}', '#{appointment}', '#{needAppointment}')")

      @id = database.last_insert_row_id
    end
    # ^ fails silently!!
    # ^ Also, susceptible to SQL injection!
  end

  def self.find id
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from appointments where id = #{id}")[0]
    if results
      appointmentID = Appointment.new(name: results["name"], appointment: results["appointment"], task: results["task"], needAppointment: results["needAppointment"])
      appointmentID.send("id=", results["id"])
      appointmentID
    else
      nil
    end
  end

  def self.search(search_term = nil)
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select appointments.* from appointments where name LIKE '%#{search_term}%' order by name ASC")
    results.map do |row_hash|
      appointmentID = Appointment.new(name: row_hash["name"], appointment: row_hash["appointment"], task: row_hash["task"],  needAppointment: row_hash["needAppointment"])
      appointmentID.send("id=", row_hash["id"])
      appointmentID
    end
  end

  # class << self
  #   alias :all :search
  # end
  # ^ is an alternative to:
  def self.all
    search
  end

  # def price
  #   sprintf('%.2f', @price) if @price
  # end
  # def appointment=(appointment)
  #   @appointment = appointment.to_i
  # end

  def to_s
    "Client Name: #{name}: Appointment Date: #{appointment}, Need Appointment: #{needAppointment}, id: #{id}"
    # "Client Name: #{name}: Appointment Date: #{appointment} Task: #{task}, Need Appointment: #{needAppointment}, id: #{id}"
  end

  def ==(other)
    other.is_a?(Appointment) && self.to_s == other.to_s
  end

  protected

  def id=(id)
    @id = id
  end

  def update_attributes(attributes)
    # @price = attributes[:price]
    # @calories = attributes[:calories]
    # @name = attributes[:name]
    # ^ Long way
    # Short way:
    [:name, :appointment, :task, :needAppointment].each do |attr|
      if attributes[attr]
        # self.calories = attributes[:calorie]
        self.send("#{attr}=", attributes[attr])
      end
    end
  end
end