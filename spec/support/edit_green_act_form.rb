class EditGreenActForm
  include Capybara::DSL

  def visit_page
    visit "/"
    click_link "Edit"
    self
  end

  def fill_in_form params = {}
    fill_in "Your Green Act", with: params.fetch(:content, "New Content")
    fill_in "More details", with: params[:details] unless params[:details].nil?
    self
  end

  def submit
    click_button "Submit"
    self
  end
end
