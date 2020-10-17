class UserSerializer < ActiveModel::Serializer
    attributes :id, :username, :first_name, :last_name, :address, :account_balance, :banks, :transaction_types, :credit_categories, :debit_categories, :transactions

    def account_balance
        self.object.transactions.select{|e|e.transaction_type_id == 1}.sum{|e|e.amount} - self.object.transactions.select{|e|e.transaction_type_id == 2}.sum{|e|e.amount}
    end

    def banks
        self.object.accounts.map{|e| e.banks}.flatten
    end

    def credit_categories
        self.object.transactions.select{|e|e.transaction_type.id == 1}.map{|e|e.category}.uniq
    end

    def debit_categories
        self.object.transactions.select{|e|e.transaction_type.id == 2}.map{|e|e.category}.uniq
    end

    # def credit_transactions
    #     self.object.transactions.select{|e|e.transaction_type.id == 1}
    # end

    # def debit_transactions
    #     self.object.transactions.select{|e|e.transaction_type.id == 2}
    # end

    def transactions
        self.object.transactions
    end

    def transaction_types
        TransactionType.all
    end

end