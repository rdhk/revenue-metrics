class Pvmr < ActiveRecord::Base
	validates :date, uniqueness: {message: ":Date has already been taken.Delete the corresponding date's record to add new record."}
end
