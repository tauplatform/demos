require 'rho'
require 'rho/rhocontroller'
require 'rho/rhoerror'
require 'helpers/browser_helper'

class SettingsController < Rho::RhoController
  include BrowserHelper
  
  @@barcode_result = nil

  def index
  	@barcode_result = @@barcode_result
    @msg = @params['msg']
    render
  end

  def scan
  	puts ">>>>> BEFORE SCAN"
  	@@barcode_result = nil
  	Rho::Barcode.take({}, url_for(:action => :scan_received))
  	puts ">>>>> AFTER SCAN, RENDERING"
  	#render :action => :index
  end

  def scan_received  	
  	@@barcode_result = @params  	
  	puts ">>>>> SCAN RECEIVED: #{@barcode_result}"
  	Rho::WebView.navigate( url_for :action => :index )
  	#render :action => :index
  end
  
end
