require 'rho'
require 'rho/rhocontroller'
require 'rho/rhoerror'
require 'helpers/browser_helper'

class SettingsController < Rho::RhoController
  include BrowserHelper

  def index
    @msg = @params['msg']
    render
  end

  def push_callback
    puts "$$$$$ push_callback : #{@params}"

    Alert.show_popup(
        :message=>"PUSH callback params = ["+@params.to_s+"]",
        :title=>"PUSH",
        :buttons => ["Ok"]
     )

    "rho_push"
  end

  def get_device_id
      # executed by press button in app/index
      dev_id = Rho::Push.getDeviceId()
      puts "$$$$$ Device ID from Ruby PUSH device id is = ["+dev_id.to_s+"]"
      Alert.show_popup(
          :message=>"Device ID from Ruby PUSH device id is = ["+dev_id.to_s+"]",
          :title=>"PUSH",
          :buttons => ["Ok"]
       )
  end

  def wait_for_device_id
      # timer callback for checking push device id

      puts "$$$$$ Settings.wait_for_device_id called !"

      dev_id = Rho::Push.getDeviceId()

      puts "$$$$$ current push device id is = ["+dev_id.to_s+"]"

      if dev_id != nil
          # now application receive push devic eid from system !
          Rho::Timer.stop('/app/Settings/wait_for_device_id')
          puts "$$$$$ Now we has push device id !"
          Alert.show_popup(
              :message=>"PUSH DeviceID received = ["+dev_id.to_s+"]",
              :title=>"PUSH",
              :buttons => ["Ok"]
           )
      else
          puts "$$$$$ Now we do not has push device id - should restart timer again !"
          Rho::Timer.start(500, '/app/Settings/wait_for_device_id', "rho_callback=1")
      end


  end


end
