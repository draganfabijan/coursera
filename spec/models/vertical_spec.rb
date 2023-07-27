require 'rails_helper'

RSpec.describe Vertical, type: :model do
  describe "associations" do
    it { should have_many(:categories) }
  end
end
