class InvitationWebToken

  SECRET_KEY = 'd6ecd8127dd1c5d8046a0331b4e446ca752d1f7504bb646b80da3391c53f551de63e0365ccd6dbf969c0bc945f0ba96d8187a3deff77df9fbe2159f992a75e70'

  def self.encode(payload, exp = 30.days.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

end