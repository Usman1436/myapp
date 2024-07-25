module Mutations
  class Login < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :user, Types::UserType, null: false
    field :token, String, null: false

    def resolve(email:, password:)
      user = User.find_by(email: email)
      if user && user.authenticate(password) && user.password_set
        token = JsonWebToken.encode(user_id: user.id)
        {
          token: token,
          user: user
        }
      else
        raise GraphQL::ExecutionError.new("Invalid credentials")
      end
    end
  end
end
