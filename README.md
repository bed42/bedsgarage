# Bedsgarage - channel

A tiny Elixir & Phoenix garage door server for running on a RaspberryPi with Raspbian

This is the 'channel' implementation.

* A dedicated supervised Task is spawned at server startup to monitor the garage door status
* The page loads to an uninitialised state
* When the page joins the channel - an async task is spawned to check the initial state
* State updates always occur via the channel
* Button presses also occur via the channel

## Configure GPIO Pins!

(from https://www.npmjs.com/package/homebridge-rasppi-gpio-garagedoor - see this for an important note on pin selection too)

  * Choose the GPIO pins that you are going to use, following the above information

  * Export the GPIO pins to be used and set their direction after reboot

  * Copy and edit this start script into your /etc/init.d directory.

  * Change the values to be the gpio pins that you are using.

  * chmod 755 /etc/init.d/garage-door-gpio # this makes the script executable

  * sudo update-rc.d /etc/init.d/garage-door-gpio defaults # this will set up the symlinks to run the script on startup.

  * sudo /etc/init.d/garage-door-gpio start and verify that your pins are exported by looking in ls /sys/class/gpio/ directory

  * Edit config.exs for your garage setup (GPIO pins)

## Build & Run

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
