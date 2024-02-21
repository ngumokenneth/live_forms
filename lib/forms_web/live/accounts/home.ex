defmodule FormsWeb.Live.Accounts.Home do
  @moduledoc false
  use FormsWeb, :live_view

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <div>
      Welcome back
    </div>
    """
  end
end
