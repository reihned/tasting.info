class IdentitiesController < ApplicationController
  # ensure logged in
  before_action :authenticate_user!

  def new
    # render a way to login with omniauth and then create a identity.
  end

  # https://github.com/intridea/omniauth/wiki/Auth-Hash-Schema
  def create
    # the omniauth hash should come here for processing.

    # define the local user
    local_user = current_user

    # Identity.new({
    #     user_id:      local_user.id,
    #     provider:     auth_hash["provider"],
    #     uid:          auth_hash["uid"],
    #     nickname:     auth_hash["info"]["nickcname"],
    #     # should creditials be another table? id ho cred?
    #     token:        auth_hash["credentials"]["token"],
    #     secret:       auth_hash["credentials"]["secret"],
    #     expires:      auth_hash["credentials"]["expires"],
    #     expires_at:   auth_hash["credentials"]["expires_at"]
    #   })

    new_id = Identity.where(
        :user_id  =>  local_user.id,
        :provider =>  auth_hash["provider"],
        :uid      =>  auth_hash["uid"],
        :nickname =>  auth_hash["info"]["nickcname"]
      ).first_or_create

    if new_id # basic if to do authorization, replace this later
      new_credential = Credential.create(auth_hash["credentials"])
      new_id.credential = new_credential
      new_id.save
    else
      # what is the best practice for raising an error? raise?
      return "Error"
    end

  end

  def show
    # how do i show the identities without revealing the private keys?
  end

protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
