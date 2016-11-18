require 'rho'
require 'rho/rhocontroller'
require 'rho/rhoerror'
require 'helpers/browser_helper'

class CustomBackTestController < Rho::RhoController
  include BrowserHelper
  
  def index
    puts ">>> INDEX: #{@params}"
    @msg = @params['msg']
    render
  end

  def custom_back
    puts ">>> CUSTOM_BACK: #{@params}"
    @back = @params['back']
    render :back => @back
  end

  def do_navigate
    puts ">>> DO_NAVIGATE: #{@params}"
    back_url = @params['back_url']
    url = url_for :action => :custom_back, :query => { :back => back_url }
    Rho::WebView.navigate(url)
  end
  
end
