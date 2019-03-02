require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:reviews).dependent(:destroy) }
  # it { should have_many(:addresses).as(:addressable) } # TODO ?
  it { should have_one(:card).dependent(:destroy) }
  it { should have_one(:cart).dependent(:destroy) }
end
