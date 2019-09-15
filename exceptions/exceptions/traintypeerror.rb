# :nodoc:
class TrainTypeError < ArgumentError
  def message
    "Existing types of trains: #{Train.train_types.join(' ')}" 
  end
end