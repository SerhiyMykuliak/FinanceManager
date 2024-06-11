class Category < ApplicationRecord
    validates :name, presence: {message: "Поле не може бути пустим"}, length: {maximum: 20, message:"Довжинна повинна бути менше 20 симовлів"}
    validates :description, presence: {message: "Поле не може бути пустим"}, length: {minimum:10, maximum:50, message:"Довжина повинна бути між 10 та 50 символами"}

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "description", "id", "id_value", "name", "updated_at"]
    end
end