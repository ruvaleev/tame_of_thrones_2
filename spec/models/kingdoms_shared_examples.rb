# frozen_string_literal: true

RSpec.shared_examples 'internationalized_method' do |method|
  it "returns :#{method}_en when current locale is :en" do
    expect(kingdom_sender.send(method)).to eq kingdom_sender.send("#{method}_en")
  end
  it "returns :#{method}_ru when current locale is :ru" do
    I18n.locale = :ru
    expect(kingdom_sender.send(method)).to eq kingdom_sender.send("#{method}_ru")
    I18n.locale = :en
  end
end
