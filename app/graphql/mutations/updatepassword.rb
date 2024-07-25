module Mutations
  class Updatepassword < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :password, String, required: true

    field :user, Types::UserType, null: false
    field :token, String, null: false
    field :errors, [String], null: false

    def resolve(id:, password:)
      user = User.find(id)
      if user
        user.update(password: password , password_set: true)
        token = JsonWebToken.encode(user_id: user.id)
        {
          token: token,
          user: user,
          errors: []
        }
      else
        raise GraphQL::ExecutionError.new("Failed to set Password")
      end
    rescue ActiveRecord::RecordNotFound
      {
        employee: nil,
        errors: ["Cant update password right now"]
      }
    end
  end
end