module Types
  class MutationType < BaseObject
    field :signup, mutation: Mutations::Signup
    field :login, mutation: Mutations::Login
    field :createmember, mutation: Mutations::Createmember
    field :updatepassword, mutation: Mutations::Updatepassword
  end
end