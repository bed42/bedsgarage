defmodule Bedsgarage.StatusChannel do
  use Phoenix.Channel
  alias Bedsgarage.PiGarage

  require Logger

  intercept ["status"]

  def join("garage:status", _message, socket) do
      #do initial check async when the client joins to update initiate state
      Task.async(fn -> PiGarage.check_status() end)
      {:ok, socket}
  end

  def handle_in("press-button", _, socket) do
    PiGarage.press_button()
    {:noreply, socket}
  end

  def handle_out("status", payload, socket) do
    Logger.info("StatusChanel OUT - #{inspect payload}")
    push(socket, "status", payload)
    {:noreply, socket}
  end
  #open and closed status gets broadcast to here by Bedsgarage.PiGarage
end
