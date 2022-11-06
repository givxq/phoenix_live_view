defmodule LiveLatestTestWeb.SearchLive do
  use LiveLatestTestWeb, :live_view

  alias LiveLatestTest.Stores

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        zip: "",
        stores: [],
        loading: false
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Find a Store</h1>
    <div id="search">
    
      <form phx-submit="zip-search">
        <input type="text" name="zip" value={@zip}
               placeholder="Zip Code"
               autofocus audocomplete="off"
               readonly={@loading}
               />
    
        <button type="submit">
          <img src="images/search.svg">
        </button>
      </form>
    
      <%= if @loading do %>
        <div class="loader">
          Loading...
        </div>
      <% end %>
    
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
                <img src="images/location.svg" width="40">
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

  def handle_event("zip-search", %{"zip" => zip}, socket) do
    socket =
      assign(socket,
        zip: zip,
        stores: [],
        loading: true
      )

    send(self(), {:run_zip_search, zip})
    {:noreply, socket}
  end

  def handle_info({:run_zip_search, zip}, socket) do
    # socket =
    #   assign(socket,
    #     stores: Stores.search_by_zip(zip),
    #     loading: false
    #   )

    # {:noreply, socket}

    case Stores.search_by_zip(zip) do
      [] ->
        socket =
          socket
          |> put_flash(:info, "No stores matching \"#{zip}\"")
          |> assign(stores: [], loading: false)

        {:noreply, socket}

      stores ->
        socket = assign(socket, stores: stores, loading: false)
        {:noreply, socket}
    end
  end
end
