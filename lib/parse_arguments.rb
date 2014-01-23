require 'optparse'

class ParseArguments
  def self.parse
    options = { environment: "production" }
    OptionParser.new do |opts|
      opts.banner = "Usage: clienttracker [command] [options]"

      opts.on("--date [DATE]", "The date") do |date|
        options[:date] = date
      end

      opts.on("--task [TASK]", "The task") do |task|
        options[:task] = task
      end

      opts.on("--environment [ENV]", "The database environment") do |env|
        options[:environment] = env
      end
    end.parse!
    options
  end

  def self.validate options
    errors = []
    if options[:firstname].nil? || options[:firstname].empty? || options[:lastname].nil? || options[:lastname].empty?
      errors << "You must provide Client's first and lastname in order to add appointment and task.\n"
    end

    missing_things = []
    missing_things << "the date" unless options[:date]
    missing_things << "task" unless options[:task]
    unless missing_things.empty?
      errors << "You must provide #{missing_things.join(" and ")} for Client.\n"
    end
    errors
  end


end