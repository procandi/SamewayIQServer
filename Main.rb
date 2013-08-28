# encoding: UTF-8


#require class
require 'sinatra/base'
require 'logger'
require 'json'
if RUBY_VERSION=~/1\.9\../
  #require_relative 'Main'
  require_relative 'models/DBHandle'
  require_relative 'models/UserHandle'
  require_relative 'models/SettingHandle'
else
  #require 'Main'
  require 'models/DBHandle'
  require 'models/UserHandle'
  require 'models/SettingHandle'
end


class Main < Sinatra::Base
  
  #query from database with ChartNO by RESTful, and convert result to JSON for request
  get '/QueryByChartNO/:uid' do
    begin      
      #get parameter
      ChartNO=params[:uid]
      
      #setup logger
      @logger=Logger.new("log.txt","daily")
      
      #connect to database
      @db=DBHandle.new(SettingHandle::DBTYPE,SettingHandle::DBIP,SettingHandle::DBID,SettingHandle::DBPW,SettingHandle::DBSID)
      @logger.info("QueryByChartNO #{SettingHandle::DBIP},#{SettingHandle::DBSID} connect ok.")
      
      #make user function
      uh=UserHandle.new(@db)
      
      #get result
      uh.GetExamByPatient(ChartNO)
    rescue => e
      @logger.debug("QueryByChartNO has crashed.") if @logger!=nil
      @logger.debug(e) if @logger!=nil
      'error'
    ensure
      @db.dbh.disconnect() if @db!=nil
      @logger.info("QueryByChartNO closed database.") if @logger!=nil
    end
  end
  
  
  #run sinatra server when this site is unstart
  run! if app_file == $0
end