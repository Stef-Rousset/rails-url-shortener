class HandleImportRow
  def initialize(account,row)
    @account = account
    @row = row
  end

  def get_attributes
    date = @row[0]
    payee = @row[1]
    if @row[2].present? # data is in debit column
      transaction_type = 'debit'
      amount = @row[2].to_s.gsub(/-/, '').gsub(/,/, '.').to_f.truncate(2)
    else # data is in credit column
      transaction_type = 'credit'
      amount = @row[3].to_s.gsub(/,/, '.').to_f.truncate(2)
    end
    description = @row[4]
    if @row[5].present?
      category_id = Category.find_by(name: @row[5].capitalize)&.id
    end
    if @row[6].present? && (@row[6].downcase == 'oui' || @row[6].downcase == 'yes')
      checked = true
      # no need of else condition because default value is false
    end
    if Transaction.where(account_id: @account.id, amount: amount, transaction_type: transaction_type, date: date).empty? &&
      date.present? && payee.present? && amount.present? && transaction_type.present?
      # ensure all mandatory fields are present
      return [date, payee, amount, transaction_type, description || nil, category_id || nil, checked || nil]
    else
      return []
    end
  end
end
