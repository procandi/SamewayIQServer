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

  get '/test' do
  begin
    #get parameter
    ChartNO='0000000666'
     
    #setup logger
    @logger=Logger.new("log.txt","daily")
     
    #connect to database
    @db=DBHandle.new(SettingHandle::DBTYPE,SettingHandle::DBIP,SettingHandle::DBID,SettingHandle::DBPW,SettingHandle::DBSID)
    @logger.info("QueryByChartNO #{SettingHandle::DBIP},#{SettingHandle::DBSID} connect ok.")
  
    #get result
    sql="select "
    sql+="chartno,examdate,type "
    sql+="from "
    sql+="cris_exam_online "
    sql+="where "
    sql+="chartno='#{ChartNO}' "
    @logger.info(sql)    
            
    #dump result#
    result=''
    @db.dbh.select_all(sql){|rec|
      result+=",#{rec}"
    }
    "[#{result[1..result.length].to_json}]"
     
    #result=@db.dbh.select_one(sql)
    #result[0]
    #.encode("UTF-8", :invalid => :replace, :undef => :replace, :replace => "[V]")
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