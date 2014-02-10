class Client < ActiveRecord::Base

 default_scope { order("name ASC") }

  def self.search(search_term = nil)
    Client.where("name LIKE ?", "%#{search_term}%").to_a
  end

  def to_s
    "#{name}: #{appointment}, #{tasks}, #{need_appointment}, #{task_completed}, id: #{id}"
  end

end
