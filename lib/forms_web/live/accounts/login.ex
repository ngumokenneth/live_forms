defmodule FormsWeb.Live.Accounts.Login do
  @moduledoc false
  use FormsWeb, :live_view

  alias Forms.Accounts
  alias Forms.Accounts.User

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <div class="container grid mx-auto max-w-md border border-gray-300 shadow-md rounded-sm px-4 pb-5">
      <.simple_form for={@form} id="login_form" class="my-8" phx-change="validate" phx-submit="submit">
        <.input label="Email Address" field={@form[:email]} type="text" />
        <.input label="Password" field={@form[:password]} type="password" />

        <:actions>
          <.button type="submit" class="w-full py-4 bg-blue-600 hover:bg-blue-900">
            Login
          </.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl Phoenix.LiveView
  def handle_params(_params, _url, socket) do
    {:noreply, prepare_socket_for_login(socket)}
  end

  def prepare_socket_for_login(socket) do
    changeset = Accounts.change_user_for_login()
    form = to_form(changeset, as: "login")

    assign(socket, :form, form)
  end

  @impl Phoenix.LiveView
  def handle_event("validate", %{"login" => params}, socket) do
    {:noreply, handle_validate(params, socket)}
  end

  @impl Phoenix.LiveView
  def handle_event("submit", %{"login" => params}, socket) do
    {:noreply, handle_submit(params, socket)}
  end

  defp handle_submit(%{"email" => _, "password" => _} = params, socket) do
    case Accounts.login(params) do
      {:ok, _user} -> push_navigate(socket, to: ~p"/home")
      {:error, :not_found} -> put_flash(socket, :error, "User not found")
      {:error, :invalid_credentials} -> put_flash(socket, :error, "Invalid credentials")
    end
  end

  defp handle_validate(%{"email" => _, "password" => _} = params, socket) do
    changeset = Accounts.change_user_for_login(%User{}, params)
    form = to_form(%{changeset | action: :validate}, as: "login")

    assign(socket, :form, form)
  end
end
