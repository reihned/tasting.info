class MandrillMailer < Devise::Mailer
  default from: "no-reply@tasting.info", template_path: 'devise/mailer'
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`

  def confirmation_instructions(record, token, opts={})
    
  end

  def reset_password_instructions(record, token, opts={})
    options = {
      :subject => "Password Reset",
      :email => record.email,
      :global_merge_vars => [
        {
          name: "password_reset_link",
          content: "http://tasting.info/users/password/edit?reset_password_token=#{token}"
        }
      ],
      :template => "Forgot Password"
    }
    mandrill_send options
  end

  def mandrill_send(opts={})
    mandrill = Mandrill::API.new ENV['MANDRILL_API_KEY']
    message = {
      :subject => "#{opts[:subject]}",
      :to => [{
                "email"=>"#{opts[:email]}",
                "type"=>"to"
             }],
      :global_merge_vars => opts[:global_merge_vars]
      }
    sending = mandrill.messages.send_template opts[:template], [], message

    rescue Mandrill::Error => e
      # Mandrill errors are thrown as exceptions
      puts "A mandrill error occurred: #{e.class} - #{e.message}"
      # A mandrill error occurred: Mandrill::UnknownSubaccountError - No subaccount exists with the id 'customer-123'
      raise
  end

end
