defmodule Time2Web.UserView do
  use Time2Web, :view
  alias Time2Web.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      group: user.group,
      email: user.email,
      name: user.name,
      manager: user.manager}
  end
end
