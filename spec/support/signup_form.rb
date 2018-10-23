class SignupForm
  include Capybara::DSL

  def visit_page
    visit "/"
    click_link "Sign Up"
    self
  end

  def fill_in_form params = {}
    fill_in "Name",     with: params.fetch(:name,     "User")
    fill_in "Username", with: params.fetch(:username, "username")
    fill_in "Email",    with: params.fetch(:email,    "user@local.com")
    fill_in "Password", with: params.fetch(:password, "123"), match: :first
    fill_in "Password confirmation",
            with: params.fetch(:password_confirmation, "123")
    self
  end

  def submit
    click_button "Sign Up"
    self
  end
end
