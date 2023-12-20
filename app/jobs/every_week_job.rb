class EveryWeekJob < ApplicationJob
  queue_as :default

  def perform
    PlannedTransaction.where(every: 'week').where('EXTRACT("dow" FROM start_date) = ?', Date.today.wday).in_batches do |elements|
      if elements.present?
        elements.each do |element|
          Transaction.create!(payee: element.payee, amount: element.amount, date: Date.today,
                              transaction_type: element.transaction_type, description: element.description,
                              account_id: element.account_id, category_id: element.category_id
                             )
        end
      end
    end
  end
end
