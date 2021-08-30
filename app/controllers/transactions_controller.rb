class TransactionsController < ApplicationController

  def index
    @transactions = Transaction.all
    render json: @transactions
  end

  def create
    points = Payer.find(transaction_params["payer_id"]).points
    @payer = Payer.update(transaction_params["payer_id"], :points => points + transaction_params["points"])
    @transaction = Transaction.create(transaction_params)
    render json: @transaction
  end

  private

  def transaction_params
    params.require(:transaction).permit(:payer_id, :points)
  end

end
