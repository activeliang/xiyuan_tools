class Number < ApplicationRecord
  has_many :analyzes, :dependent => :destroy, :inverse_of  => :number
  accepts_nested_attributes_for :analyzes, :allow_destroy => true, :reject_if => :all_blank

end
