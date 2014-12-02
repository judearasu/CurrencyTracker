class CurrenciesController < ApplicationController
  # GET /currencies
  # GET /currencies.xml
  def index
    @currencies = Currency.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @currencies }
    end
  end

  def collect
    @currency = Currency.find(params[:id])

    respond_to do |format|
      current_user.update_collection(@currency)
      if current_user.collect?(@currency)
        message = "Currency was successfully as collected"
        status = "Collected"
      else
        message = "Currency was successfully as not collected"
        status = "Not Collected"
      end
      format.html{ redirect_to currencies_path, :flash => {:notice => message} }
      format.json{ render :json => {
        :message => message,
        :status => status,
        :"Collected" => current_user.currencies.count,
        :"Not Collected" => Currency.count - current_user.currencies.count
      }
    }
  end
end
  # GET /currencies/1
  # GET /currencies/1.xml
  def show
    @currency = Currency.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @currency }
    end
  end


end