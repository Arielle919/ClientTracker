class Client
  attr_accessor :name, :appointment, :task
  attr_reader :id

  def initialize attributes = {}
    update_attributes(attributes)
  end

  def self.create(attributes = {})
    client = Client.new(attributes)
    client.save
    client
  end

  def update attributes = {}
    update_attributes(attributes)
    save
  end

  def save
    database = Environment.database_connection
    if id
      database.execute("update clients set name = '#{name}', appointment = '#{appointment}', task = '#{task}' where id = #{id}")
    else
      database.execute("insert into clients(name, appointment, task) values('#{name}', '#{appointment}', '#{task}')")
      @id = database.last_insert_row_id
    end
    # ^ fails silently!!
    # ^ Also, susceptible to SQL injection!
  end

  def self.find id
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from clients where id = #{id}")[0]
    if results
      client = Client.new(name: results["name"], appointment: results["appointment"], task: results["task"])
      client.send("id=", results["id"])
      client
    else
      nil
    end
  end

  def self.search(search_term = nil)
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select clients.* from clients where name LIKE '%#{search_term}%' order by name ASC")
    results.map do |row_hash|
      client = Client.new(name: row_hash["name"], appointment: row_hash["appointment"], task: row_hash["task"])
      client.send("id=", row_hash["id"])
      client
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
    "#{name}: #{appointment}, #{task}, id: #{id}"
  end

  def ==(other)
    other.is_a?(Client) && self.to_s == other.to_s
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
    [:name, :appointment, :task].each do |attr|
      if attributes[attr]
        # self.calories = attributes[:calorie]
        self.send("#{attr}=", attributes[attr])
      end
    end
  end
end
