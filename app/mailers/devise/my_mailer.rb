# https://github.com/plataformatec/devise/blob/master/app/mailers/devise/mailer.rb

module Devise
  class MyMailer < Devise::Mailer
    def confirmation_instructions(record, token, opts={})
      @name = record.name
      super
    end
  end
end
