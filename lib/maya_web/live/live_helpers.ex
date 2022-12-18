defmodule MayaWeb.LiveHelpers do
  import Phoenix.LiveView
  alias Maya.Accounts
  alias Maya.Accounts.User
  alias MayaWeb.Router.Helpers, as: Routes

  defp find_current_user(session) do
    with user_token when not is_nil(user_token) <- session["user_token"],
         %User{} = user <- Accounts.get_user_by_session_token(user_token),
         do: user
  end
end
