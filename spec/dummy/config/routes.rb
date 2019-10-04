Rails.application.routes.draw do
  mount MailFlow::Engine => "/mail_flow"
end
