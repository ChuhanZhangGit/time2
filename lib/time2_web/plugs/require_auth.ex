
# Source: Nate Tuck, https://github.com/NatTuck/lens
defmodule Time2Web.Plugs.RequireAuth do
  import Plug.Conn

  def init(args), do: args 

  def call(conn, _args) do
    token = List.first(get_req_header(conn, "x-auth"))
    case Phoenix.Token.verify(Time2Web.Endpoint, "session", token, max_age: 86400) do
      {:ok, user_id} ->
        assign(conn, :current_user, Time2.Users.get_user!(user_id))
      {:error, err} ->
        conn
        |> put_resp_header("content-type", "application/json; charset=UTF-8")
        |> send_resp(:unprocessable_entity, Jason.encode!(%{"error" => err}))
        |> halt()
    end
  end
end
