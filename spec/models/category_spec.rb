require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "associations" do
    it { should belong_to(:vertical) }
  end
end