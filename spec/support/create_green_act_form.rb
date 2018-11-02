class CreateGreenActForm
  include Capybara::DSL

  def visit_page
    visit "/"
    click_link "Share your Green Act"
    self
  end

  def fill_in_form params = {}
    fill_in "Your Green Act", with: params.fetch(:content, "I did this")
    self
  end

  def submit
    click_button "Submit"
    self
  end
end
