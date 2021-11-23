require 'rails_helper'

RSpec.describe 'notes/new', type: :view do
  current_user = User.first_or_create!(email: 'kacper@gmail.com', password: 'password', password_confirmation: 'password')
  before(:each) do
    assign(:note, Note.new(
      city: 'London',
      note: 'MyNote',
      user: current_user
    ))
  end

  it 'renders new note form' do
    render

    assert_select 'form[action=?][method=?]', notes_path, 'note' do
      assert_select 'input[name=?]', 'note[city]'

      assert_select 'textarea[name=?]', 'note[note]'
    end
  end
end
