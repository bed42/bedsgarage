defmodule Bedsgarage.PageController do
  use Bedsgarage.Web, :controller
  alias Bedsgarage.PiGarage

#  plug :get_status

#  defp get_status(conn, _) do

      #todo - support an optional closed sensor
#      {status, button, img} = case PiGarage.get_open_status do
#        0 -> {"Closed","OPEN","closed.png"}
#        1 -> {"Open","CLOSE","open.png"}
#      end
#
#      assign(conn, :status, status)
#      |> assign(:img, img)
#      |> assign(:button, button)
#  end

  def index(conn, _params) do
    render conn, "index.html"
  end

  def press(conn, _params) do
    PiGarage.press_button
    text conn, "Button Pressed!"
  end

end
