defmodule InvoicesWeb.Live.Users.New.IndexLive do
  @moduledoc """
  This live view will be used to create a new user
  """
  use FormsWeb, :live_view
  alias Invoices.Users

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <.simple_form id="invoices_user_creation_form" for={@form} class="grid gap-y-3" phx-change="validate" phx-submit="submit">
      <.input field={@form[:email]} type="email" label="Email Address" phx-debounce="blur" />
      <.input field={@form[:phone_number]} type="text" label="Phone Number" phx-debounce="blur" />
      <.input field={@form[:password]} type="password" label="Password" phx-debounce="blur" />

      <:actions>
        <.button type="submit" class="min-w-full">
          <span> Save User </span>
        </.button>
      </:actions>
    </.simple_form>
    """
  end

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl Phoenix.LiveView
  def handle_params(params, _url, %{assigns: %{live_action: action}} = socket) do
    {:noreply, apply_action(action, params, socket)}
  end

  defp apply_action(:index, _params, socket) do
    changeset = Users.change_user_for_creation()
    form = to_form(changeset, as: "user_form")

    assign(socket, :form, form)
  end

  @impl Phoenix.LiveView
  def handle_event("validate", %{"user_form" => params}, socket) do
    {:noreply, handle_validate(params, socket)}
  end

  @impl Phoenix.LiveView
  def handle_event("submit", %{"user_form" => params}, socket) do
    {:noreply, handle_submit(params, socket)}
  end

  defp handle_submit(params, socket) do
    case Users.create_user(params) do
      {:ok, _user} -> put_flash(socket, :info, "User created successfully")
      {:error, changeset} -> assign(socket, :form, to_form(changeset, as: "user_form"))
    end
  end

  defp handle_validate(params, socket) do
    changeset = params |> Users.change_user_for_creation() |> Map.put(:action, :validate)
    form = to_form(changeset, as: "user_form")

    assign(socket, :form, form)
  end
end
