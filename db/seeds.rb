if Rails.env.development?
  User.create(email: 'ola@ola.ru', password: '12345678', name: 'Odmen')
end
