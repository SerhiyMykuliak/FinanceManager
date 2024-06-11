class Transaction < ApplicationRecord

    with_options presence: {message:"Поле не може бути пустим"} do
       validates :amount, numericality:{only_integer: true, message: "В дамому полі можуть бути тільки цифри"}
       validates :description, length: {minimum:5, maximum:50, message:"Довжина повинна бути між 5 та 50 символами"}
    end 
    validates :operation_type, inclusion: {in: %w(Витрата Прихід), message:"Виберіть тип операції"}
    validates :category, inclusion: { in: ->(record){ Category.select(:name).distinct.pluck(:name)}, message:"Виберіть категорію"}

    def self.ransackable_attributes(auth_object = nil)
        ["amount", "category", "created_at", "description", "id", "id_value", "operation_type", "updated_at"]
    end

end
