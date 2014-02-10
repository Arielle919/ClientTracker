require_relative 'helper'

class TestClient < ClientTest

  def test_count_when_no_client
    assert_equal 0, Client.count
  end

  def test_count_of_multiple_clients
    Client.create(name: "Sam Adams", appointment: "01/22/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")
    Client.create(name: "Tim Adams", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")
    Client.create(name: "Sammy Adams", appointment: "01/21/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")
    assert_equal 3, Client.count
  end

  def test_to_s_prints_details
    client = Client.new(name: "Sam Adams", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")
    expected = "Sam Adams: 01/20/2014, Sign Docs, no, yes, id: #{client.id}"
    assert_equal expected, client.to_s
  end

  def test_update_doesnt_insert_new_row
    client = Client.create(name: "Sam Adams", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")
    foos_before = Client.count
    client.update(name: "Sammy Clams")
    foos_after = Client.count
    assert_equal foos_before, foos_after
  end

  def test_update_saves_to_the_database
    client = Client.create(name: "Sam Adams", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")
    id = client.id
    client.update(name: "Sammy Adams", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")
    updated_client = Client.find(id)
    expected = ["Sammy Adams", "01/20/2014", "Sign Docs", "no", "yes"]
    actual = [ updated_client.name, updated_client.appointment, updated_client.tasks,  updated_client.need_appointment, updated_client.task_completed]
    assert_equal expected, actual
  end

  def test_update_is_reflected_in_existing_instance
    client = Client.create(name: "Sam Adams", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")
    client.update(name: "Jim Jones", appointment: "01/20/2014", tasks: "Sign Papers", need_appointment: "no", task_completed: "yes")
    expected = ["Jim Jones", "01/20/2014", "Sign Papers", "no", "yes"]
    actual = [ client.name, client.appointment, client.tasks, client.need_appointment, client.task_completed]
    assert_equal expected, actual
  end

  def test_saved_clients_are_saved
    client = Client.new(name: "Sam Adams", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")
    foos_before = Client.count
    client.save
    foos_after = Client.count
    assert_equal foos_before + 1, foos_after
  end

  def test_save_creates_an_id
    client = Client.create(name: "Sam Adams", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")
    refute_nil client.id, "Client id shouldn't be nil"
  end

  def test_find_returns_the_row_as_client_object
    client = Client.find_or_create_by(name: "Foo")
    client = Client.create(name: "Sam Adams", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")
    found = Client.find(client.id)

    assert_equal client.name, found.name
    assert_equal client.id, found.id
    assert_equal client.appointment, found.appointment
    assert_equal client.tasks, found.tasks
    assert_equal client.need_appointment, found.need_appointment
    assert_equal client.task_completed, found.task_completed
  end

  def test_search_returns_client_objects
    Client.create(name: "Tim Adams", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")
    Client.create(name: "Sam Jones", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")
    Client.create(name: "Sam Adams", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")
    results = Client.search("Sam")
    assert results.all?{ |result| result.is_a? Client }, "Not all results were Clients"
  end

  def test_search_returns_appropriate_results
    client1 = Client.create(name: "Tim Adams", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")
    client2 = Client.create(name: "Sam Adams", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")
    client3 = Client.create(name: "Sam Adams", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")

    expected = [client2, client3]
    actual = Client.search("Sam")

    assert_equal expected, actual
  end

  def test_search_returns_empty_array_if_no_results
    Client.create(name: "Tim Adams", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")
    Client.create(name: "Sam Jones", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")
    Client.create(name: "Sam Adams", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")

    results = Client.search("Cassey")
    assert_equal [], results
  end

  def test_that_returns_all_clients_in_alphabetical_order
    Client.create(name: "Cam Jones", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")
    Client.create(name: "Sam Adams", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")
    results = Client.all
    expected = ["Cam Jones", "Sam Adams"]
    actual = results.map{ |client| client.name }

    assert_equal expected, actual
  end

  def test_all_returns_empty_array_if_no_clients
    results = Client.all
    assert_equal [], results
  end

  def test_equality_on_same_object
    client = Client.create(name: "Tim Adams", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")
    assert client == client
  end

  def test_equality_with_different_class
    client = Client.create(name: "Tim Adams", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")
    refute client == "Client"
  end

  def test_equality_with_different_client
    client1 = Client.create(name: "Sam Adams", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")
    client2 = Client.create(name: "Tim Adams", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")
    refute client1 == client2
  end

  def test_equality_with_same_client_different_object_id
    client1 = Client.create(name: "Tim Adams", appointment: "01/20/2014", tasks: "Sign Docs", need_appointment: "no", task_completed: "yes")
    client2 = Client.find(client1.id)
    assert client1 == client2
  end
end