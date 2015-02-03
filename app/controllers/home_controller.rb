require 'uri'
require 'open-uri' 
require 'net/http'

class HomeController < ApplicationController
  
  def index
    @projects = Project.moderated.order(moderated_at: :desc).page(params[:page]).per(20)
    @sponsors = Sponsor.order(year_donations: :desc).where('year_donations > 0').page(params[:page]).per(12)
  end

  def project_sponsors
    @project = Project.find_by_url(params[:url]) || create_project(params[:url])

    if @project.nil?
      redirect_to root_path, :notice => "Project not found / creation failed"
    else
      @deposit_address = @project.deposit_address(current_sponsor)
      limit = (params[:limit] || 6).to_i
      limit =  20 if limit > 20
      @project_sponsors = @project.sponsors.public_only.order(year_donations: :desc).first(limit)
      @show_sponsors = params[:mode].nil? || (params[:mode]=="sponsors")
      @show_buttons  = params[:mode].nil? || (params[:mode]=="buttons")
      render :layout => "iframe"
    end

  end

  def create_project url
    Rails.logger.info "Creating project: #{url}"
    begin
      doc = Nokogiri::HTML(open(url))
      # iframe_tag = doc.search("iframe[src='http://coingiving.com/project_sponsors?url=#{url}']").first
      title = doc.search('[data-coingiving="title"]').first.text rescue nil
      description = doc.search('[data-coingiving="description"]').first.text rescue nil
      bitcoin_address = doc.search('[data-coingiving="bitcoin-address"]').first.text rescue nil

      # if (iframe_tag.count > 0) && title && description && bitcoin_address
      if title && description && bitcoin_address
        # Rails.logger.info "  iframe: #{iframe_tag.inspect} title: #{title} description: #{description} bitcoin_address: #{bitcoin_address}"
        Rails.logger.info "  title: #{title} description: #{description} bitcoin_address: #{bitcoin_address}"
        Project.create({url: url, name: title, about: description, bitcoin_address: bitcoin_address, donation_page_url: url})
      else
        # Rails.logger.info "  something is missing iframe: #{iframe_tag.inspect} title: #{title} description: #{description} bitcoin_address: #{bitcoin_address}"
        Rails.logger.info "  something is missing: title: #{title} description: #{description} bitcoin_address: #{bitcoin_address}"
        nil          
      end

    rescue StandardError => e
      Rails.logger.info e.inspect
      nil
    end
  end

  def blockchain_info_callback
  # todo: check if remote IP address belongs to blockchain.info

    if (params[:secret]!=CONFIG["blockchain_info"]["callback_secret"])
      Rails.logger.error "Invalid secret #{params.inspect}!"      
      render :text => "Invalid secret #{params.inspect}!" 
      return
    end

    test = params[:test]

    if params[:value].to_i < 0
      Rails.logger.info "*ok*"
      render :text => "*ok*";
      return
    end

    if deposit = Deposit.find_by_input_tx(params[:input_transaction_hash])
      deposit.update_attribute(:confirmations, confirmations = params[:confirmations] ) if !test
      if confirmations.to_i > 6 
        Rails.logger.info "*ok*"
        render :text => "*ok*"
      else
        Rails.logger.info "Deposit #{deposit.id} updated!"
        render :text => "Deposit #{deposit.id} updated!"
      end
      return
    end

    if deposit_address = DepositAddress.find_by_bitcoin_address(params[:input_address])
      (
        deposit = Deposit.create({
          deposit_address_id: deposit_address.id,
          input_tx: params[:input_transaction_hash],
          output_tx: params[:transaction_hash],
          confirmations: params[:confirmations],
          amount: params[:value].to_i
        })
      ) if !test     
      Rails.logger.info "Deposit created! #{deposit.inspect}"
      render :text => "Deposit #{deposit[:txid]} has been created!"
      deposit_address.update_donations_cache
    else
      Rails.logger.error "Error: Project with deposit address #{params[:input_address]} is not found!"
      render :text => "Project with deposit address #{params[:input_address]} is not found!"
    end    
  end
end
