module Mutations
  class Signup < BaseMutation
    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :email, String, required: true
    argument :password, String, required: true

    field :user, Types::UserType, null: false
    field :token, String, null: false

    def resolve(first_name:, last_name:, email:, password:)
      user = User.create!(
        first_name: first_name,
        last_name: last_name,
        email: email,
        password: password,
        password_set: true
      )
      token = JsonWebToken.encode(user_id: user.id)
      { user: user , token: token}
    end
  end
end