require "selenium-webdriver"
require "rspec"
require "webdrivers"
require "base64"

email = "randallwward@gmail.com"
plain = Base64.decode64("eDItOXBOcjIzODQhcEEq")

def enter_email(email)
		email_field = @driver.find_element(id:"email")
		email_field.send_keys(email)
end	

def enter_password(password)
		password_field = @driver.find_element(id:"password")
		plain = Base64.decode64("eDItOXBOcjIzODQhcEEq")
		password_field.send_keys(plain)
		
end

def submit_form()
		login_button = @driver.find_element(id: "logIn")
				login_button.click
end

def confirm_logo()
		logo = @driver.find_element(:class, "hui-globalnav__home-logo")
				logo.displayed?	
		
end

def log_out()
		useritem = @driver.find_element(:class, "hui-globaluseritem__display-name")
				@driver.action.move_to(useritem).perform
				logout = @driver.find_element(:xpath, "//a[@href='/logout']")
				logout.click
end	

def org_button()
		org_login = @driver.find_element(:xpath, "/html/body/div/section/div[2]/div/form/div/a/button")
				org_login.click
		
end

def email_uni(email)
		uni_email = @driver.find_element(:id, "uniId_1")
				uni_email.send_keys(email)
end

def login_uni()
		uni_login = @driver.find_element(:xpath, "/html/body/div/section/div/div/form/div[1]/button")
				uni_login.click
end

def validate_error()
		uni_error = @driver.find_element(:class, "uni-text")
				uni_text = uni_error.text
				expect(uni_text).to eq("This account can't log in with an organization yet. Please log in using your email and password.")
end


#TEST: Sign into Hudl
describe "Hudl Application" do
	describe "Login to Hudl application" do
		it "confirm that a user can log in successfully" do
			@driver = Selenium::WebDriver.for :firefox
			
			# Go to Login Page
				@driver.navigate.to "https://www.hudl.com/login"
				
				#Fill out Email/Password field and submit
				enter_email(email)
				enter_password(plain)
				submit_form

				#confirm sign in
				confirm_logo
				
				#Log out
				log_out

				@driver.quit
		end		
	end
end

#TEST: Sign into Hudl via Org Link 
describe "Hudl Application" do
	describe "Login to Hudl application" do
		it "Attempt login via Organization Link " do
			@driver = Selenium::WebDriver.for :firefox

			# Go to Login Page
				@driver.navigate.to "https://www.hudl.com/login"
				
				#Click Org login link
				org_button

				#Enter email and click login
				email_uni(email)
				login_uni

				#Wait
				wait = Selenium::WebDriver::Wait.new(:timeout => 10)
				wait.until { @driver.find_element(:class, "uni-text").displayed? }

				#validate error message
				validate_error

				
				@driver.quit
		end		
	end
end