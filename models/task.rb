class Task
  attr_accessor :name, :appointment, :task, :taskCompleted
  attr_reader :id

  def initialize attributes = {}
    update_attributes(attributes)
  end

  def self.create(attributes = {})
    taskID = Task.new(attributes)
    taskID.save
    taskID
  end

  def update attributes = {}
    update_attributes(attributes)
    save
  end

  def save
    database = Environment.database_connection
    if id
      database.execute("update tasks set name = '#{name}', appointment = '#{appointment}', task = '#{task}', taskCompleted = '#{taskCompleted}' where id = #{id}")
    else
      database.execute("insert into tasks(name, appointment, task, taskCompleted) values('#{name}', '#{appointment}', '#{task}', '#{taskCompleted}')")

      @id = database.last_insert_row_id
    end
  end

  def self.find id
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from tasks where id = #{id}")[0]
    if results
      taskID = Task.new(name: results["name"], appointment: results["appointment"], task: results["task"], taskCompleted: results["taskCompleted"])
      taskID.send("id=", results["id"])
      taskID
    else
      nil
    end
  end

  def self.search(search_term = nil)
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select tasks.* from tasks where name LIKE '%#{search_term}%' order by name ASC")
    results.map do |row_hash|
      tasks = Task.new(name: row_hash["name"], appointment: row_hash["appointment"], task: row_hash["task"])
      tasks.send("id=", row_hash["id"])
      tasks
    end
  end

  def self.all
    search
  end

  def to_s
    "Client Name: #{name}: Task Date: #{appointment}, Need Task: #{taskCompleted}, id: #{id}"
  end

  def ==(other)
    other.is_a?(Task) && self.to_s == other.to_s
  end

  protected

  def id=(id)
    @id = id
  end

  def update_attributes(attributes)
    [:name, :appointment, :task, :taskCompleted].each do |attr|
      if attributes[attr]
        self.send("#{attr}=", attributes[attr])
      end
    end
  end
end
