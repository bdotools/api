require "rails_helper"

describe BestCombo do
  let(:category) { FactoryGirl.create(:category, daum_id: 1) }
  let(:constellation_order) {
    FactoryGirl.create(:constellation_order, daum_id: 1, slot_order: [1, 2, 3])
  }
  let(:target) {
    FactoryGirl.create(:target, category_id: category.daum_id, 
      constellation_id: constellation_order.daum_id,
      )
  }
  
  before do
    category.knowledges << FactoryGirl.create(:knowledge, interest: 7)
    category.knowledges << FactoryGirl.create(:knowledge, interest: 10)
    category.knowledges << FactoryGirl.create(:knowledge, interest: 10, favor_max: 15)
    category.knowledges << FactoryGirl.create(:knowledge, interest: 8)
    category.knowledges << FactoryGirl.create(:knowledge, interest: 9)
  end
  
  it "returns the most successful combination for a target" do
    best_combo = BestCombo.new(id: target.id, interest: 0)
    
    expect(best_combo.result.map(&:interest)).to eq [10, 10, 9]
    expect(best_combo.result.map(&:average_favor)).to eq [8, 3, 3]
  end
  
  it "returns the least success combination for a target" do
    best_combo = BestCombo.new(id: target.id, interest: 0, order: :asc)
    
    expect(best_combo.result.map(&:interest)).to eq [7, 8, 9]
  end
  
  it "returns the success chance" do
    best_combo = BestCombo.new(id: target.id, interest: 10)
    
    expect(best_combo.success_chance).to eq 0.9666666666666667
  end
end