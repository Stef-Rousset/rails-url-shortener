class HandleImportRow
  def initialize(account, file)
    @account = account
    @file = file
  end

  def get_attributes
    xlsx = Roo::Spreadsheet.open(@file, extension: :xlsx)
    count = xlsx.count
    hash = {}
    for i in 2..count # we don't want the first row which is header
      date = xlsx.row(i)[0]
      payee = xlsx.row(i)[1]
      if xlsx.row(i)[2].present? # data is in debit column
        transaction_type = 'debit'
        amount = xlsx.row(i)[2].to_s.gsub(/-/, '').gsub(/,/, '.').to_f.truncate(2)
      else # data is in credit column
        transaction_type = 'credit'
        amount = xlsx.row(i)[3].to_s.gsub(/,/, '.').to_f.truncate(2)
      end
      description = xlsx.row(i)[4] if xlsx.row(i)[4].present?
      category_id = Category.find_by(name: xlsx.row(i)[5].capitalize)&.id if xlsx.row(i)[5].present?
      if xlsx.row(i)[6].present? && (xlsx.row(i)[6].downcase == 'oui' || xlsx.row(i)[6].downcase == 'yes')
        checked = true
        # no need of else condition because default value is false
      end
      # ensure all mandatory fields are present and no transaction of same amount
      # in a close date already exists for the account
      if date.present? && Transaction.where(account_id: @account.id, amount: amount, transaction_type: transaction_type)
                                     .where('date >= ?', date - 7.days)
                                     .where('date <= ?', date).empty? && payee.present? && amount.present? && transaction_type.present?
        hash[i] = [date, payee, amount, transaction_type, description || nil, category_id || nil, checked || nil]
      else
        hash[i] = []
      end
    end
    hash
  end
end
