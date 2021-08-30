Payer.delete_all
Transaction.delete_all

puts "Creating Payers..."

5.times do
  Payer.create(name: Faker::Company.name, points: rand(1...20)*100)
end

puts "Creating Transactions..."

15.times do
  Transaction.create(payer: Payer.all.sample, points: rand(1...5)*100)
end

puts "Done!"