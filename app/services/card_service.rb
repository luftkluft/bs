class CardService
  # require 'date'
  def initialize
    @errors = []
  end

  def load(card)
    @card = card
  end

  def save_card(param)
    save_card_number(param[:card_number])
    save_card_exp_date(param[:exp_date])
    save_card_name(param[:card_name])
    save_card_cvv(param[:cvv])
    return nil unless @errors.size.positive?

    @errors
  end

  def save_card_cvv(card_cvv)
    @card.cvv = card_cvv
    @card.save
  rescue StandardError
    @errors.push(I18n.t('services.error_save_cvv'))
  end

  def save_card_name(card_name)
    @card.name = card_name
    @card.save
  rescue StandardError
    @errors.push(I18n.t('services.error_save_card_name'))
  end

  def save_card_number(card_number)
    @card.card_number = card_number
    @card.save
  rescue StandardError
    @errors.push(I18n.t('services.error_save_card_number'))
  end

  def save_card_exp_date(card_exp_date)
    return @errors.push(I18n.t('services.error_validation_card_exp_date')) unless card_exp_date_valid?(card_exp_date)

    @card.expiration_month_year = card_exp_date
    @card.save
  rescue StandardError
    @errors.push(I18n.t('services.error_save_exp_date'))
  end

  def card_exp_date_valid?(card_exp_date)
    time = Time.now
    return @errors.push(I18n.t('services.error_validation_card_year')) if card_exp_date[3..4].to_i < time.year.to_s[2..3].to_i
    return @errors.push(I18n.t('services.error_validation_card_mounth')) if card_exp_date[0..1].to_i < time.month

    true
  end
end
