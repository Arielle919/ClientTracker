require_relative 'helper'
require_relative '../models/client'

class TestClient < ClientTest
  def test_to_s_prints_details
    client = Client.new(name: "Sam Adams", appointment: "01/20/2014", task: "Sign Docs")
    expected = "Sam Adams: 01/20/2014, Sign Docs, id: #{client.id}"
    assert_equal expected, client.to_s
  end

  def test_update_doesnt_insert_new_row
    client = Client.create(name: "Sam Adams", appointment: "01/20/2014", task: "sign docs")
    foos_before = database.execute("select count(id) from clients")[0][0]
    client.update(name: "Kim Harris")
    foos_after = database.execute("select count(id) from clients")[0][0]
    assert_equal foos_before, foos_after
  end

  def test_update_saves_to_the_database
    client = Client.create(name: "Foo", appointment: "01/20/2014", task: "Sign Docs")
    id = client.id
    client.update(name: "Bar", appointment: "01/20/2014", task: "Sign Docs")
    updated_client = Client.find(id)
    expected = ["Bar", "01/20/2014", "Sign Docs"]
    actual = [ updated_client.name, updated_client.appointment, updated_client.task]
    assert_equal expected, actual
  end

  def test_update_is_reflected_in_existing_instance
    client = Client.create(name: "Sam Adams", appointment: "01/20/2014", task: "Sign Docs")
    client.update(name: "Jim Jones", appointment: "01/20/2014", task: "Sign Papers")
    expected = ["Jim Jones", "01/20/2014", "Sign Papers"]
    actual = [ client.name, client.appointment, client.task  ]
    assert_equal expected, actual
  end

  def test_saved_clients_are_saved
    client = Client.new(name: "Foo", appointment: "01/20/2014", task: "Sign Docs")
    foos_before = database.execute("select count(id) from clients")[0][0]
    client.save
    foos_after = database.execute("select count(id) from clients")[0][0]
    assert_equal foos_before + 1, foos_after
  end

  def test_save_creates_an_id
    client = Client.create(name: "Foo", appointment: "01/20/2014", task: "Sign Docs")
    refute_nil client.id, "Client id shouldn't be nil"
  end

  def test_find_returns_nil_if_unfindable
    assert_nil Client.find(12342)
  end

  def test_find_returns_the_row_as_client_object
    client = Client.create(name: "Foo", appointment: "01/20/2014", task: "Sign Docs")
    found = Client.find(client.id)

    assert_equal client.name, found.name
    assert_equal client.id, found.id
  end

  def test_search_returns_client_objects
    Client.create(name: "foo", appointment: "01/20/2014", task: "Sign Docs")
    Client.create(name: "Tim Adams", appointment: "01/21/2014", task: "Sign Papers")
    Client.create(name: "Tim Ross", appointment: "01/22/2014", task: "Sign Contract")
    results = Client.search("Tim")
    assert results.all?{ |result| result.is_a? Client }, "Not all results were Clients"
  end

  def test_search_returns_appropriate_results
    client1 = Client.create(name: "foo", appointment: "01/20/2014", task: "Sign Docs")
    client2 = Client.create(name: "Tim Adams", appointment: "01/20/2014", task: "Sign Papers")
    client3 = Client.create(name: "Tim Ross", appointment: "01/20/2014", task: "Sign Papers")

    expected = [client2, client3]
    actual = Client.search("Tim")

    assert_equal expected, actual
  end

  def test_search_returns_empty_array_if_no_results
    Client.create(name: "foo", appointment: "01/20/2014", task: "Sign Docs")
    Client.create(name: "Tim Adams", appointment: "01/21/2014", task: "Sign Papers")
    Client.create(name: "Tim Ross", appointment: "01/22/2014", task: "Sign Contract")

    results = Client.search("Sam")
    assert_equal [], results
  end

  def test_all_returns_all_clients_in_alphabetical_order
    Client.create(name: "Sam Adams", appointment: "01/20/2014", task: "Sign Docs")
    Client.create(name: "Anna Adams", appointment: "01/21/2014", task: "Sign Papers")
    Client.create(name: "Tim Ross", appointment: "01/22/2014", task: "Sign Contract")

    results = Client.all
    expected = ["Anna Adams", "Sam Adams", "Tim Ross"]
    actual = results.map{ |client| client.name }

    assert_equal expected, actual
  end

  def test_all_returns_empty_array_if_no_clients
    results = Client.all
    assert_equal [], results
  end

  def test_equality_on_same_object
    client = Client.create(name: "Sam Adams", appointment: "01/20/2014", task: "Sign Docs")
    assert client == client
  end

  def test_equality_with_different_class
    client = Client.create(name: "Sam Adams", appointment: "01/20/2014", task: "Sign Docs")
    refute client == "Client"
  end

  def test_equality_with_different_client
    client1 = Client.create(name: "Sam Adams", appointment: "01/20/2014", task: "Sign Docs")
    client2 = Client.create(name: "Tim Adams", appointment: "01/22/2014", task: "Sign Papers")
    refute client1 == client2
  end

  def test_equality_with_same_client_different_object_id
    client1 = Client.create(name: "Sam Adams", appointment: "01/20/2014", task: "Sign Docs")
    client2 = Client.find(client1.id)
    assert client1 == client2
  end
end
