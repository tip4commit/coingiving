class HomeController < ApplicationController
  def index
  end

  def blockchain_info_callback
  # todo: check if remote IP address belongs to blockchain.info

    if (params[:secret]!=CONFIG["blockchain_info"]["callback_secret"])
      render :text => "Invalid secret #{params}!" 
      return
    end

    test = params[:test]

    if params[:value].to_i < 0
      render :text => "ok";
      return
    end

    if deposit = Deposit.find_by_txid(params[:transaction_hash])
      deposit.update_attribute(:confirmations, confirmations = params[:confirmations]) if !test
      if confirmations > 6 
        render :text => "ok"
      else
        render :text => "Deposit #{deposit.id} updated!"
      end
      return
    end

    if deposit_address = DepositAddress.find_by_bitcoin_address(params[:input_address])
      (
        deposit = Deposit.create({
          deposit_address_id: deposit_address.id,
          txid: params[:transaction_hash],
          confirmations: params[:confirmations],
          amount: params[:value].to_i
        })
      ) if !test
      render :text => "Deposit #{deposit[:txid]} has been created!"
    else
      render :text => "Project with deposit address #{params[:input_address]} is not found!"
    end    
  end
end
