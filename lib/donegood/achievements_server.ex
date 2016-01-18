defmodule Donegood.AchievementsServer do
  require Logger
  use GenServer

  alias Donegood.Achievements

  def start_link() do # required
    Logger.info("Starting Rewards service")
    {:ok, _pid} = Agent.start_link(fn -> %Achievements{} end, name: __MODULE__)
  end

  def update_user(user_id) do
    Logger.info("Achievements: Refresh user #{user_id}")
  end
end
