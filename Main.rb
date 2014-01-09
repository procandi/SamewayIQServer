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
  #get user and password verify result by RESTful, and made result to JSON for request
   get '/GetUserVerifyResult/:id/:password' do
     begin      
       #get parameter
       id=params[:id]
       password=params[:password]
       
       #setup logger
       @logger=Logger.new("log.txt","daily")
       
       #connect to database
       @db=DBHandle.new(SettingHandle::DBTYPE,SettingHandle::DBIP,SettingHandle::DBID,SettingHandle::DBPW,SettingHandle::DBSID)
       @logger.info("GetImageListByAccessionNO #{SettingHandle::DBIP},#{SettingHandle::DBSID} connect ok.")
       
       #make user function
       uh=UserHandle.new(@db)
       
       #get result
       uh.GetUserVerifyResult(id,password).to_s()
     rescue => e
       @logger.debug("GetUserVerifyResult has crashed.") if @logger!=nil
       @logger.debug(e) if @logger!=nil
       'error'
     ensure
       @db.dbh.disconnect() if @db!=nil
       @logger.info("GetUserVerifyResult closed database.") if @logger!=nil
     end   
   end
  
  #query from database with AccessionNO by RESTful, and convert result to JSON for request
  get '/QueryByAccessionNO/:accessionno' do
    begin      
      #get parameter
      AccessionNO=params[:accessionno]
      
      #setup logger
      @logger=Logger.new("log.txt","daily")
      
      #connect to database
      @db=DBHandle.new(SettingHandle::DBTYPE,SettingHandle::DBIP,SettingHandle::DBID,SettingHandle::DBPW,SettingHandle::DBSID)
      @logger.info("QueryByAccessionNO #{SettingHandle::DBIP},#{SettingHandle::DBSID} connect ok.")
      
      #make user function
      uh=UserHandle.new(@db)
      
      #get result
      uh.GetExamByAccessionNO(AccessionNO)
    rescue => e
      @logger.debug("QueryByAccessionNO has crashed.") if @logger!=nil
      @logger.debug(e) if @logger!=nil
      'error'
    ensure
      @db.dbh.disconnect() if @db!=nil
      @logger.info("QueryByAccessionNO closed database.") if @logger!=nil
    end
  end
  
  #query from database with ChartNO by RESTful, and convert result to JSON for request
  get '/QueryByChartNO/:chartno' do
    begin      
      #get parameter
      ChartNO=params[:chartno]
      
      #setup logger
      @logger=Logger.new("log.txt","daily")
      
      #connect to database
      @db=DBHandle.new(SettingHandle::DBTYPE,SettingHandle::DBIP,SettingHandle::DBID,SettingHandle::DBPW,SettingHandle::DBSID)
      @logger.info("QueryByChartNO #{SettingHandle::DBIP},#{SettingHandle::DBSID} connect ok.")
      
      #make user function
      uh=UserHandle.new(@db)
      
      #get result
      uh.GetExamByChartNO(ChartNO)
    rescue => e
      @logger.debug("QueryByChartNO has crashed.") if @logger!=nil
      @logger.debug(e) if @logger!=nil
      'error'
    ensure
      @db.dbh.disconnect() if @db!=nil
      @logger.info("QueryByChartNO closed database.") if @logger!=nil
    end
  end
  
  #query from database with Date by RESTful, and convert result to JSON for request
  get '/QueryByExamDate/:year/:month/:day' do
    begin      
      #get parameter
      year=params[:year]
      month=params[:month]
      day=params[:day]
      ExamDate="#{year}/#{month}/#{day}"
      
      #setup logger
      @logger=Logger.new("log.txt","daily")
      
      #connect to database
      @db=DBHandle.new(SettingHandle::DBTYPE,SettingHandle::DBIP,SettingHandle::DBID,SettingHandle::DBPW,SettingHandle::DBSID)
      @logger.info("QueryByDate #{SettingHandle::DBIP},#{SettingHandle::DBSID} connect ok.")
      
      #make user function
      uh=UserHandle.new(@db)
      
      #get result
      uh.GetExamByExamDate(ExamDate)
    rescue => e
      @logger.debug("QueryByDate has crashed.") if @logger!=nil
      @logger.debug(e) if @logger!=nil
      'error'
    ensure
      @db.dbh.disconnect() if @db!=nil
      @logger.info("QueryByDate closed database.") if @logger!=nil
    end
  end
  
  #open report from database with AccessionNO by RESTful, and convert result to JSON for request
  get '/OpenReportByAccessionNO/:accessionno' do
    begin      
      #get parameter
      AccessionNO=params[:accessionno]
      
      #setup logger
      @logger=Logger.new("log.txt","daily")
      
      #connect to database
      @db=DBHandle.new(SettingHandle::DBTYPE,SettingHandle::DBIP,SettingHandle::DBID,SettingHandle::DBPW,SettingHandle::DBSID)
      @logger.info("OpenReportByAccessionNO #{SettingHandle::DBIP},#{SettingHandle::DBSID} connect ok.")
      
      #make user function
      uh=UserHandle.new(@db)
      
      #get result
      uh.OpenReportByAccessionNO(AccessionNO)
    rescue => e
      @logger.debug("OpenReportByAccessionNO has crashed.") if @logger!=nil
      @logger.debug(e) if @logger!=nil
      'error'
    ensure
      @db.dbh.disconnect() if @db!=nil
      @logger.info("OpenReportByAccessionNO closed database.") if @logger!=nil
    end
  end
 
  #get image list from database with AccessionNO by RESTful, and made result to JSON for request
  get '/GetImageListByAccessionNO/:accessionno' do
    begin      
      #get parameter
      AccessionNO=params[:accessionno]
      
      #setup logger
      @logger=Logger.new("log.txt","daily")
      
      #connect to database
      @db=DBHandle.new(SettingHandle::DBTYPE,SettingHandle::DBIP,SettingHandle::DBID,SettingHandle::DBPW,SettingHandle::DBSID)
      @logger.info("GetImageListByAccessionNO #{SettingHandle::DBIP},#{SettingHandle::DBSID} connect ok.")
      
      #make user function
      uh=UserHandle.new(@db)
      
      #get result
      uh.GetImageListByAccessionNO(AccessionNO)
    rescue => e
      @logger.debug("GetImageListByAccessionNO has crashed.") if @logger!=nil
      @logger.debug(e) if @logger!=nil
      'error'
    ensure
      @db.dbh.disconnect() if @db!=nil
      @logger.info("GetImageListByAccessionNO closed database.") if @logger!=nil
    end   
  end
  
  
  #run sinatra server when this site is unstart
  run! if app_file == $0
end