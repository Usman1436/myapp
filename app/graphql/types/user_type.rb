module Types
  class UserType < BaseObject
    field :id, ID, null: false
    field :first_name, String, null: false
    field :last_name, String, null: false
    field :email, String, null: false
    field :role, String, null: true
    field :password_set, Boolean, null: true
    field :manager, Types::UserType, null: true
    field :employees, [Types::UserType], null: true
    

    def employees
      object.employees
    end
  end
end