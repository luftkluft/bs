RSpec.describe AddressService do
  let(:current_subject) { described_class.new }

  it '#save with error' do
    current_subject.save(nil, nil)
    expect(current_subject.instance_variable_get(:@errors)).to eq([I18n.t('services.error_save_address')])
  end

  it '#billing_address_update with error' do
    current_subject.billing_address_update
    expect(current_subject.instance_variable_get(:@errors)).to eq([I18n.t('services.error_update_billing_address')])
  end

  it '#shipping_address_update with error' do
    current_subject.shipping_address_update
    expect(current_subject.instance_variable_get(:@errors)).to eq([I18n.t('services.error_update_shipping_address')])
  end

  it '#use_billing_address with error' do
    current_subject.use_billing_address(nil)
    expect(current_subject.instance_variable_get(:@errors)).to eq([I18n.t('services.error_copy_billing_address')])
  end
end
