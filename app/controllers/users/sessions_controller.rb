class Users::SessionsController < ApplicationController
  protect_from_forgery except: :sso

  def lading

  end

  def new
    request = OneLogin::RubySaml::Authrequest.new
    redirect_to(request.create(saml_settings))
  end

  def sso
    response = OneLogin::RubySaml::Response.new(params[:SAMLResponse], settings: saml_settings)
    if response.is_valid?
      redirect_to users_url
    else
    end
  end

  private

  def saml_settings
    settings = OneLogin::RubySaml::Settings.new
    settings.soft = true
    settings.issuer                         = "#{ENV['HOST']}/metadata"
    settings.assertion_consumer_service_url = "#{ENV['HOST']}/sso"
    settings.assertion_consumer_logout_service_url = "#{ENV['HOST']}/saml/logout"

    settings.idp_sso_target_url              = ENV['SSO_TARGET_URL']
    settings.idp_cert_fingerprint            = ENV['CERTIFICATE_FINGERPRINT']
    settings.idp_cert_fingerprint_algorithm  = ENV['CERTIFICATE_FINGERPRINT_ALGORITHM']
    settings.name_identifier_format = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"

    settings
  end

end
