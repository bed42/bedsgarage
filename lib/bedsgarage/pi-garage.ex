defmodule Bedsgarage.PiGarage do
  # this module controls
  require Logger

  def start_link() do
    Logger.info("PiGarage - start_link!")
    Task.start_link(fn -> init() end)
  end

  defp init() do
    #tell GPIO to listen to the open sensor
    Logger.info("PiGarage - init!")
    openGPIO = Application.fetch_env!(:bedsgarage, :openGPIO)
    {:ok, pid} = Gpio.start_link(openGPIO, :input)
    Gpio.set_int(pid, :both)
    Logger.info("PiGarage - set interrupt, starting loop!")
    loop(openGPIO)
  end

  # receive changes to the sensors
  defp loop(openGPIO) do
    receive do
      {:gpio_interrupt, pin, :rising} ->
        Logger.info("PiGarage - Open Pin = 1")
        sendOpenStatus()
        loop(openGPIO)
      {:gpio_interrupt, pin, :falling} ->
        Logger.info("PiGarage - Open Pin = 0")
        sendClosedStatus()
        loop(openGPIO)
    end
  end

  defp sendOpenStatus() do
    Bedsgarage.Endpoint.broadcast!("garage:status", "status", %{"status" => "Open", "img" => "open.png", "button" => "CLOSE"})
  end

  defp sendClosedStatus() do
    Bedsgarage.Endpoint.broadcast!("garage:status", "status", %{"status" => "Closed", "img" => "closed.png", "button" => "OPEN"})
  end

  def check_status() do
    Logger.info("PiGarage - Checking Status")
      openGPIO = Application.fetch_env!(:bedsgarage, :openGPIO)
      {:ok, pid} = Gpio.start_link(openGPIO, :input)
      case Gpio.read(pid) do
        0 -> sendClosedStatus()
        1 -> sendOpenStatus()
      end
  end

  def press_button() do
    buttonGPIO = Application.fetch_env!(:bedsgarage, :buttonGPIO)
    buttonSleep = Application.fetch_env!(:bedsgarage, :buttonSleep)
    {:ok, pid} = Gpio.start_link(buttonGPIO, :output)
    Gpio.write(pid, 1)
    Process.sleep(buttonSleep)
    Gpio.write(pid, 0)
  end

end
