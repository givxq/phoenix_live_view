defmodule LiveLatestTestWeb.LicenseLive do
  use LiveLatestTestWeb, :live_view

  alias LiveLatestTest.Licenses
  import Number.Currency

  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(1000, self(), :tick)
    end

    expiration_time = Timex.shift(Timex.now(), hours: 1)

    socket =
      assign(socket,
        seats: 3,
        amount: Licenses.calculate(3),
        expiration_time: expiration_time,
        time_remaining: time_remaining(expiration_time)
      )

    {:ok, socket}
  end

  defp time_remaining(expiration_time) do
    DateTime.diff(expiration_time, Timex.now())
  end

  def render(assigns) do
    ~H"""
    <div id="license">
      <div class="card">
        <div class="content">
          <div class="seats">
            <img scr="images/license.svg">
            <span>
              Your license is currently for
              <strong><%= @seats %></strong> seats.
            </span>
          </div>
    
          <form phx-change="update">
            <input type="range" min="1" max="10" name="seats" value= {@seats} />
          </form>
    
          <div class="amount">
            <%= number_to_currency(@amount) %>
          </div>
    
          <div class="time">
           <%= @expiration_time %>
          </div>
        </div>
      </div>
    </div>
    """
  end

  def handle_event("update", %{"seats" => seats}, socket) do
    seats = String.to_integer(seats)

    socket =
      assign(socket,
        seats: seats,
        amount: Licenses.calculate(seats)
      )

    {:noreply, socket}
  end
end
