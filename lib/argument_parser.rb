require 'optparse'

class ArgumentParser
  def self.parse
    options = { environment: "production" }
    OptionParser.new do |opts|
      opts.banner = "Usage: clienttracker [command] [options]"

      opts.on("--appointment [APPOINTMENT]", "The appointment") do |appointment|
        options[:appointment] = appointment
      end

      opts.on("--task [TASK]", "The task") do |task|
        options[:task] = task
      end

      opts.on("--id [ID]", "The id of the object we are editing") do |id|
        options[:id] = id
      end

      opts.on("--name [NAME]", "The name of the client") do |name|
        options[:name] = name
      end

      opts.on("--environment [ENV]", "The database environment") do |env|
        options[:environment] = env
      end

      opts.on("--needAppointment [APP]", "Client need appointment") do |app|
        options[:needAppointment] = app
      end

      opts.on("--taskCompleted [COM]", "Client Task Completed") do |com|
        options[:taskCompleted] = com
      end

    end.parse!
    options[:name] ||= ARGV[1]
    options[:command] = ARGV[0]
    options
  end

  def self.validate options
    errors = []
    if options[:name].nil? or options[:name].empty?
      errors << "You must provide the name for the client you are adding.\n"
    end
    missing_things = []
    missing_things << "task" unless options[:task]
    missing_things << "appointment" unless options[:appointment]
    unless missing_things.empty?
      errors << "You must provide the #{missing_things.join(" and ")} for the client you are adding.\n"
    end
    errors
  end
end
