ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "gmail.com",
  :user_name            => "burson.ve.dev@gmail.com",
  :password             => "bm654321",
  :authentication       => "plain",
  :enable_starttls_auto => true
}