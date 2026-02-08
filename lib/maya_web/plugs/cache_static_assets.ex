defmodule MayaWeb.Plugs.CacheStaticAssets do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    if is_digested_asset?(conn.request_path) do
      put_resp_header(conn, "cache-control", "public, max-age=31536000")
    else
      conn
    end
  end

  defp is_digested_asset?(path) do
    if Application.get_env(:maya, :env) == :prod do
      digested_paths = 
        case :persistent_term.get(:digested_paths, nil) do
          nil ->
            manifest = File.read!("priv/static/cache_manifest.json") |> String.split("\n") |> tl() |> Enum.join("\n") |> Jason.decode!
            paths = Map.values(manifest) |> Enum.map(& &1["logical_path"])
            :persistent_term.put(:digested_paths, paths)
            paths
          paths ->
            paths
        end
      Enum.any?(digested_paths, &String.ends_with?(path, &1))
    else
      false
    end
  end
end