require 'rails_helper'

RSpec.describe "wikis/new", type: :view do
  before(:each) do
    assign(:wiki, Wiki.new(
      :title => "MyString",
      :body => "MyText",
      :private => false,
      :user => nil
    ))
  end

  it "renders new wiki form" do
    render

    assert_select "form[action=?][method=?]", wikis_path, "post" do

      assert_select "input[name=?]", "wiki[title]"

      assert_select "textarea[name=?]", "wiki[body]"

      assert_select "input[name=?]", "wiki[private]"

      assert_select "input[name=?]", "wiki[user_id]"
    end
  end
end
