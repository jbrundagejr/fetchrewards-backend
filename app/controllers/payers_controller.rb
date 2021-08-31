class PayersController < ApplicationController

  def index
    @payers = Payer.all
    return_object = {}
    @payers.each{|payer| return_object[payer.name] = payer.points}
    render json: return_object
  end

  def spend
    # find all the transactions
    @transactions = Transaction.all
    # sort them by when they were created, oldest to newest
    sorted_transactions = @transactions.sort{|a, b| a.created_at <=> b.created_at}
    # variable for value being passed in
    spend_points = spend_params["points"]
    # empty array to push our return values into at end of method
    return_array = []
    # while the value being passed in is greater than zero,
    while spend_points > 0 do
      # loop through the sorted arrays and first see if the first transaction is less than the value passed in. If so,
      if sorted_transactions[0].points <= spend_points
        # find the payer associated with the transaction
        payer = Payer.find(sorted_transactions[0]["payer_id"])
        # check to see if the payer has a positive balance. if not, skip that transaction
        if(payer.points === 0) then sorted_transactions.shift() end
        # set temporary variable to the balance available from the first payer
        temp = sorted_transactions[0].points
        # subtract the balance available from the value passed in 
        spend_points = spend_points - temp
        # subtract the same points from the payer's available balance associated with that transaction
        Payer.update(payer.id, :points => payer.points = payer.points - temp)
        # push the name of the payer and the amount subtracted from their account into our return array
        return_array.push({"payer": sorted_transactions[0].payer.name, "points": -temp})
        # delete the transaction from the loop
        Transaction.delete(sorted_transactions.shift())
      else 
        # if the transaction is greater than the value passed in, first find the payer associated with the transaction
        payer = Payer.find(sorted_transactions[0]["payer_id"])
        # update that payer's point balance based on the value passed in
        Payer.update(payer.id, :points => payer.points = payer.points - spend_points)
        # push the name of the payer and the value passed in as a negative to reflect what was spent
        return_array.push({"payer": sorted_transactions[0].payer.name, "points": -spend_points})
        # end the loop by setting the spend points to zero
        spend_points = 0
      end
    end

    # NEEDS TO BE REWORKED

  # #  This is to eliminate duplicates in our return array if the same payer was used more than once.
  # # for the length of our return array,
  #   (0..return_array.length - 1).each do |i|
  #     # if there is a second element,
  #     if return_array[i+1]
  #       # loop through the array with two markers
  #       (0..return_array.length-1).each do |j|
  #         # if the two markers point to the same key of "payer",
  #         if return_array[i][:payer] === return_array[j][:payer] 
  #           # combine those two values under the key of points and set them to the first marker's value
  #           return_array[i][:points] = return_array[i][:points] + return_array[j][:points]
  #         end
  #       end
  #     end
  #   end

  #   # remove any elements from our return array that have the same name as they will have the same key/value pair of "points" to value
  #   # due to the loop above
  #   return_array.uniq!{|payer| payer[:payer]}
  #   # render our return array in JSON format
    render json: return_array
  end

  private

  def payer_params
    params.require(:payer).permit(:points, :created_at)
  end

  def spend_params
    params.require(:payer).permit(:points)
  end

end
