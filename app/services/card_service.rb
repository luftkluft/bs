class CardService
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
    @errors.push('Card cvv not saved!')
  end

  def save_card_name(card_name)
    @card.name = card_name
    @card.save
  rescue StandardError
    @errors.push('Card name not saved!')
  end

  def save_card_number(card_number)
    @card.card_number = card_number
    @card.save
  rescue StandardError
    @errors.push('Card number not saved!')
  end

  def save_card_exp_date(card_exp_date)
    @card.expiration_month_year = card_exp_date
    @card.save
  rescue StandardError
    @errors.push('Card_exp_date not saved!')
  end
end