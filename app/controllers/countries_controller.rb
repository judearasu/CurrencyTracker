class CountriesController < ApplicationController
  # GET /countries
  # GET /countries.xml
  def index
    @q = Country.search(params[:q])
    @countries = @q.result(distinct: true)
    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end
 

  def visit
    @country = Country.find(params[:id])

    respond_to do |format|
      if current_user.visited?(@country)
        message = "Country was successfully marked as not visited"
        status = "Not Visited"
      else
        message = "Country was successfully marked as visited"
        status = "Visited"
      end

      current_user.toggle_visiting(@country)
      format.html { redirect_to(countries_path, :flash => { :notice => message }) }
      format.json { render :json => {
        :message => message,
        :status => status,
        :"Visited" => current_user.countries.count,
        :"Not Visited" => Country.count - current_user.countries.count
      }
    }
  end
end

  
end