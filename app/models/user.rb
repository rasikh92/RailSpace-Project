class User < ApplicationRecord
    validates_uniqueness_of :screen_name, :email
    validates_length_of :screen_name, within: 4..20
    validates_length_of :password, within: 4..20

    validates_length_of :email, maximum: 50
    validates_format_of :screen_name, 
                        with: /^[A-Z0-9_]*$/i,
                        multiline: true,
                        message: "must contain only letters, " +
                        "numbers, and underscores"
    validates_format_of :email, 
                        with: /^[A-Z0-9._%-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i,
                        multiline: true,
                        message: "must be a valid email address"
end
