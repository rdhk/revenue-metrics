# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
base=600*5000
date=DateTime.now - 10.days
rents=[1500,4800,2000,6900]
random_packagenum=[7,8,9,10]

Pvmr.transaction do
	Pvmr.destroy_all
end

Pvmr.transaction do
	10.times do |i|
		numpkg= random_packagenum[rand(random_packagenum.length)]
		new_customer_value=0
		numpkg.times do |j|
			new_customer_value += rents[rand(rents.length)] 
		end
		cancelled_customer_value = i%5==0 ? rents[rand(rents.length)] : 0 
		daily_total =  new_customer_value - cancelled_customer_value
		Pvmr.create!(total_value: daily_total, date: date, num_packages: numpkg)
		date += 1.days
	end
end