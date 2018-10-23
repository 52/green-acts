class SigninForm
  include Capybara::DSL

  def visit_page
    visit "/"
    click_link "Sign In"
    self
  end

  def fill_in_form params
    fill_in "Email", with: params.fetch(:email)
    fill_in "Password", with: params.fetch(:password)
    self
  end

  def submit
    click_button "Sign In"
    self
  end
end
