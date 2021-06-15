defmodule IgniteQueueTest do
  @moduledoc """
  Tests IgniteQueue funcionality
  """
  use ExUnit.Case
  doctest IgniteQueue

  describe "start_link/1" do
    test "When receives a list, starts a GenServer process" do
      list = [1, 2, 3]

      response = IgniteQueue.start_link(list)

      assert {:ok, _pid} = response
    end

    test "When an invalid term is given, returns an error" do
      term = :invalid_term

      response = IgniteQueue.start_link(term)

      expected_response = {:error, "Should receive a list"}

      assert expected_response == response
    end
  end

  describe "enqueue/2" do
    test "When receiving a term, returns :ok" do
      term = 3

      {:ok, pid} = IgniteQueue.start_link([1, 2])

      response = IgniteQueue.enqueue(pid, term)

      expected_response = :ok

      assert response == expected_response
    end
  end

  describe "dequeue/2" do
    test "Returns the head of the queue" do
      {:ok, pid} = IgniteQueue.start_link([1, 2])

      response = IgniteQueue.dequeue(pid)

      expected_response = 1

      assert response == expected_response
    end

    test "When queue is empty, returns nil" do
      {:ok, pid} = IgniteQueue.start_link([])

      response = IgniteQueue.dequeue(pid)

      expected_response = nil

      assert response == expected_response
    end
  end
end
