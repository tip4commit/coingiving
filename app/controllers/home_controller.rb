class HomeController < ApplicationController
  def index
    @projects = Project.order(name: :asc).page(params[:page]).per(30)
    @sponsors = Sponsor.page(params[:page]).per(60)
  end

  def blockchain_info_callback
  # todo: check if remote IP address belongs to blockchain.info

    if (params[:secret]!=CONFIG["blockchain_info"]["callback_secret"])
      AaLogger.error "Invalid secret #{params.inspect}!"      
      render :text => "Invalid secret #{params.inspect}!" 
      return
    end

    test = params[:test]

    if params[:value].to_i < 0
      AaLogger.info "*ok*"
      render :text => "*ok*";
      return
    end

    if deposit = Deposit.find_by_input_tx(params[:input_transaction_hash])
      deposit.update_attribute(:confirmations, confirmations = params[:confirmations]) if !test
      if confirmations > 6 
        AaLogger.info "*ok*"
        render :text => "*ok*"
      else
        AaLogger.info "Deposit #{deposit.id} updated!"
        render :text => "Deposit #{deposit.id} updated!"
      end
      return
    end

    if deposit_address = DepositAddress.find_by_bitcoin_address(params[:input_address])
      (
        deposit = Deposit.create({
          deposit_address_id: deposit_address.id,
          input_tx: params[:input_transaction_hash]
          output_tx: params[:transaction_hash],
          confirmations: params[:confirmations],
          amount: params[:value].to_i
        })
      ) if !test
      AaLogger.info "Deposit created! #{deposit.inspect}"
      render :text => "Deposit #{deposit[:txid]} has been created!"
    else
      AaLogger.error "Error: Project with deposit address #{params[:input_address]} is not found!"
      render :text => "Project with deposit address #{params[:input_address]} is not found!"
    end    
  end
end
