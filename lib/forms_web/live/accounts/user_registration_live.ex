defmodule FormsWeb.Live.Accounts.UserRegistrationLive do
  use FormsWeb, :live_view
  alias Forms.Accounts
  alias Forms.Accounts.User

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl Phoenix.LiveView
  def handle_params(_unsigned_params, _uri, socket) do
    {:noreply, prepare_socket_for_registration(socket)}
  end

  @impl Phoenix.LiveView
  def handle_event("validate", %{"user" => user_params}, socket) do
    {:noreply, handle_validate(user_params, socket)}
  end

  def handle_event("submit", %{"user" => user_params}, socket) do
    {:noreply, handle_submit(user_params, socket)}
  end

  def prepare_socket_for_registration(socket) do
    changeset = Accounts.change_user_for_login()
    form = to_form(changeset, as: "user")

    assign(socket, :form, form)
  end

  defp handle_validate( user_params, socket) do
    changeset = Accounts.change_user(%User{}, user_params)

    form = to_form(%{changeset | action: :validate}, as: "user")
    assign(socket, :form, form)
  end

  def handle_submit(user_params, socket) do
    case Accounts.register_user(user_params) do
      {:ok, _user} ->
        push_navigate(socket, to: ~p"/login")

      {:error, :registration_failed} ->
        put_flash(socket, :error, "registration failed")
    end
  end
end
