module Mutations
  class Createmember < Mutations::BaseMutation
    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :email, String, required: true
    argument :role, String, required: true
    argument :manager_id, ID, required: true

    field :employee, Types::UserType, null: true
    field :errors, [String], null: false

    def resolve(first_name:, last_name:, email:, role:, manager_id:)
      manager = User.find(manager_id)
      employee = manager.employees.build(
        first_name: first_name,
        last_name: last_name,
        email: email,
        role: role,
        password: 'password'
      )
      if employee.save
        UserMailer.send_invitation_email(employee).deliver_now
        {
          employee: employee,
          errors: []
        }
      else
        {
          employee: nil,
          errors: employee.errors.full_messages
        }
      end
    rescue ActiveRecord::RecordNotFound
      {
        employee: nil,
        errors: ["Manager not found"]
      }
    end
  end
end