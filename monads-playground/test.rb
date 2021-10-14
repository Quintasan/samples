require 'pry-byebug'
require_relative './new_user_service'

def main
  service = NewUserService.new

  missing_params = service.call({
    email: "mzafki@smugi.pl",
  })

  wrong_email = service.call({
    email: "mzafkismugi.pl",
    password: "qweasdzxc",
    password_confirmation: "qweasdzxc",
    country: 'pl',
    age: 21
  })

  unsupported_country = service.call({
    email: "mzafki@smugi.pl",
    password: "qweasdzxc",
    password_confirmation: "qweasdzxc",
    country: 'cn',
    age: 21
  })

  invalid_age = service.call({
    email: "mzafki@smugi.pl",
    password: "qweasdzxc",
    password_confirmation: "qweasdzxc",
    country: 'cn',
    age: 'over 9000'
  })

  passwords_dont_match = service.call({
    email: "mzafki@smugi.pl",
    password: "qweas",
    password_confirmation: "qweasdzxc",
    country: 'pl',
    age: 21
  })

  all_good = service.call({
    email: "mzafki@smugi.pl",
    password: "qweasdzxc",
    password_confirmation: "qweasdzxc",
    country: 'pl',
    age: 21
  })

  puts missing_params.inspect
  puts wrong_email.inspect
  puts unsupported_country.inspect
  puts invalid_age.inspect
  puts passwords_dont_match.inspect

  binding.pry
end

main
