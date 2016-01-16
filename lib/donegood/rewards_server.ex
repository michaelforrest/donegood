defmodule Donegood.RewardsServer do
  require Logger
  use GenServer

  alias Donegood.Rewards

  def start_link() do # required
    Logger.info("Starting Rewards service")
    {:ok, _pid} = Agent.start_link(fn -> %Rewards{} end, name: __MODULE__)
  end

  def update_user(user_id) do
    Logger.info("updating user #{user_id}")
  end
end
