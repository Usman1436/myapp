module Types
  class MemberType < Types::BaseObject
    field :employees, [Types::UserType], null: false
  end
end