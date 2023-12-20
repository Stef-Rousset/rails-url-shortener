class EveryMonthJob < ApplicationJob
  queue_as :default

  def perform
    PlannedTransaction.where(every: 'month').where('EXTRACT("day" FROM start_date) = ?', Date.today.day).in_batches do |elements|
      if elements.present?
        #array = []
        elements.each do |element|
          Transaction.create!(payee: element.payee, amount: element.amount, date: Date.today,
                              transaction_type: element.transaction_type, description: element.description,
                              account_id: element.account_id, category_id: element.category_id
                             )
        end
        # Transaction.insert_all(array) does not trigger callbacks, or we need the after_create callback to update balance of account
      end
    end
  end
end
