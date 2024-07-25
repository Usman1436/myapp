# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :getmembers, [Types::UserType], null: false do
      argument :id, ID, required: true
    end

    def getmembers(id:)
      manager = User.find(id)
      manager.employees
    end
  end

end
