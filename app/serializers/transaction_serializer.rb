class TransactionSerializer < ActiveModel::Serializer
  attributes :points, :created_at
  has_one :payer
end
