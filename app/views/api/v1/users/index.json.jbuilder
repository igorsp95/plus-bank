json.array! @users do |user|
  json.extract! user, :id, :email, :encrypted_password, :first_name, :last_name, :created_at, :updated_at
end