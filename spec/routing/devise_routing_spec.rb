require "rails_helper"

RSpec.describe "devise routing" do
  it "routes /signup" do
    expect(get: "/signup").to route_to(
      controller: "devise/registrations",
      action:     "new"
    )
  end

  it "routes /signin" do
    expect(get: "/signin").to route_to(
      controller: "devise/sessions",
      action:     "new"
    )
  end

  it "routes /signout" do
    expect(delete: "/signout").to route_to(
      controller: "devise/sessions",
      action:     "destroy"
    )
  end
end
