defmodule Maya.Release do
  @moduledoc """
  A module for release-related tasks.
  """

  @repo Maya.Repo

  def wait_for_db do
    IO.puts("Waiting for database to be available...")

    case {:persistent_term.get(:waited_for_db, false), System.get_env("RELEASE_COMMAND")} do
      {true, _} ->
        :ok

      {_, "true"} ->
        wait_for_db(0)

      {_, _} ->
        :ok
    end
  end

  def migrate do
    IO.puts("Running migrations...")

    Ecto.Migrator.run(Maya.Repo, :up, all: true)

    IO.puts("Migrations complete.")
  end

  defp wait_for_db(retries) when retries < 10 do
    case @repo.start_link(pool_size: 1) do
      {:ok, _pid} ->
        :persistent_term.put(:waited_for_db, true)
        :ok

      {:error, _} ->
        IO.puts("Database not available, waiting...")
        :timer.sleep(500)
        wait_for_db(retries + 1)
    end
  end

  defp wait_for_db(_retries) do
    IO.puts("Database not available after 10 retries, giving up.")
    System.stop(1)
  end
end