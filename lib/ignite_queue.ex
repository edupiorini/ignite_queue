defmodule IgniteQueue do
  @moduledoc """
  Documentation for `IgniteQueue`.
  """

  @doc """
  Queue using GenServer

  ## Examples

  """
  use GenServer

  # CLIENT
  @doc """
  Starts GenServer process by calling GenServer.start_link/2
  """
  @typedoc """
  A list that accepts any type inside
  """
  @type initial_queue :: [any()]

  @type err_message :: String.t()

  @spec start_link(initial_queue) :: {:ok, pid} | {:error, err_message}
  def start_link(initial_queue) when is_list(initial_queue) do
    GenServer.start_link(__MODULE__, initial_queue)
  end

  def start_link(_any_type) do
    {:error, "Should receive a list"}
  end

  def enqueue(pid, element) do
    GenServer.cast(pid, {:enqueue, element})
  end

  def dequeue(pid) do
    GenServer.call(pid, :dequeue)
  end

  # --------------------------------------------------------------------
  # SERVER

  @impl true
  def init(queue) do
    {:ok, queue}
  end

  @impl true
  def handle_cast({:enqueue, element}, state) do
    {:noreply, state ++ [element]}
  end

  @impl true
  def handle_call(:dequeue, _from, [head | tail]) do
    {:reply, head, tail}
  end

  @impl true
  def handle_call(:dequeue, _from, []) do
    {:reply, nil, []}
  end
end
