require 'rho/rhoapplication'

class AppApplication < Rho::RhoApplication
  def initialize
    # Tab items are loaded left->right, @tabs[0] is leftmost tab in the tab-bar
    # Super must be called *after* settings @tabs!
    @tabs = nil
    #To remove default toolbar uncomment next line:
    #@@toolbar = nil



    super

  end

  def on_activate_app
     dev_id = Rho::Push.getDeviceId()

     puts "$$$$$ Application.onActivate() PUSH device id is = ["+dev_id.to_s+"]"

     # setup callback for push notifications
     Rho::Push.startNotifications("/app/Settings/push_callback")

     # start timer for wait when push device id will generate by system (actually for first run only when user should accept system UI request and grant rhights to application)
     # there are no push device ID until User grant rights to application via UI request from system
     Rho::Timer.start(500, '/app/Settings/wait_for_device_id', "rho_callback=1")


  end



end
