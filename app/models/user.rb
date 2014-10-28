 class User < ActiveRecord::Base

    attr_accessor :password

    attr_accessible :username, :email, :password, :password_confirmation,:gender

    EMAIL_REGEX = /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/
    validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
    validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
    validates :password, :confirmation => true #password_confirmation attr
    validates_length_of :password,:in => 6..20, :on => :create
    
    before_save :encrypt_password

    def self.authenticate(username_or_email, login_password)
        if EMAIL_REGEX.match(username_or_email)
            user = User.find_by_email(username_or_email)
        else
            user = User.find_by_username(username_or_email)
        end

        if user && user.match_password(login_password)
            return user
        end
    end

    def match_password(login_password)
        encrypted_password == encrypt(login_password)
    end

    private

    def encrypt_password
        if password.present?
            self.salt = make_salt(password) if self.new_record?
            self.encrypted_password = encrypt(password)
        end
    end

    def encrypt(string)
        secure_hash("#{salt}#{string}")
    end

    def make_salt(string)
        secure_hash("#{Date.today}#{string}")
        
    end

    def secure_hash(string)
        Digest::SHA1.hexdigest(string)
    end
end