RSpec.describe CardService do
  let(:current_subject) { described_class.new }

  it '#save_card_cvv with error' do
    current_subject.save_card_cvv(nil)
    expect(current_subject.instance_variable_get(:@errors)).to eq([I18n.t('services.error_save_cvv')])
  end

  it '#save_card_name with error' do
    current_subject.save_card_name(nil)
    expect(current_subject.instance_variable_get(:@errors)).to eq([I18n.t('services.error_save_card_name')])
  end

  it '#save_card_number with error' do
    current_subject.save_card_number(nil)
    expect(current_subject.instance_variable_get(:@errors)).to eq([I18n.t('services.error_save_card_number')])
  end

  it '#save_card_exp_date with error' do
    current_subject.save_card_exp_date(nil)
    expect(current_subject.instance_variable_get(:@errors)).to eq([I18n.t('services.error_save_exp_date')])
  end
end
