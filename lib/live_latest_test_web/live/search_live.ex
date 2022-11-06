defmodule LiveLatestTestWeb.SearchLive do
  use LiveLatestTestWeb, :live_view

  alias LiveLatestTest.Stores

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        zip: "",
        stores: Stores.list_stores()
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Find a Store</h1>
    <div id="search">
      <div class="stores">
        <ul>
          <%= for store <- @stores do %>
            <li>
              <div class="firsr-line">
                <div class="name">
                  <%= store.name %>
                </div>
                <div class="status">
                  <%= if store.open do %>
                    <span class="open">Open</span>
                  <% else %>
                    <span class="closed">Closed</span>
                  <% end %>
                </div>
              </div>
              <div class="second-line">
                <img src="images/location.svg">
                <%= store.street %>
              </div>
              <div class="phone_number">
                <img src="images/phone.svg">
                <%= store.phone_number %>
              </div>
            </li>
          <% end %>
        </ul>
      </div>
    </div>
    """
  end
end
