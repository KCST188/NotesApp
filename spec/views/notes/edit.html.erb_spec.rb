require 'rails_helper'

RSpec.describe 'notes/edit', type: :view do
  before(:each) do
    current_user = User.first_or_create!(email: 'kacper@gmail.com', password: 'password', password_confirmation: 'password')

    @note = assign(:note, Note.create!(
      city: 'London',
      note: 'MyNote',
      user: current_user
    ))
  end

  it 'renders the edit note form' do
    render

    assert_select 'form[action=?][method=?]', note_path(@note), 'note' do
      assert_select 'input[name=?]', 'note[city]'
      assert_select 'textarea[name=?]', 'note[note]'
    end
  end
end
