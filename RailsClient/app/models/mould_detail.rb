class MouldDetail < ActiveRecord::Base
  validates :mould_id, presence: true, uniqueness: {message: 'mould id should be uniq'}
end
