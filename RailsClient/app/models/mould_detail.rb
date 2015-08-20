class MouldDetail < ActiveRecord::Base
  validates :mould_id, presence: true, uniqueness: {message: '模具号不能重复!'}
end
