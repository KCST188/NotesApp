require 'rails_helper'

RSpec.describe 'notes/index', type: :view do
  current_user = User.first_or_create!(email: 'kacper@gmail.com', password: 'password', password_confirmation: 'password')
  before(:each) do
    assign(:notes, [
      Note.create!(
        city: 'London',
        note: 'MyNote',
        user: current_user,
        temperature: '12℃'
      ),
      Note.create!(
        city: 'New York',
        note: 'MyNote',
        user: current_user,
        temperature: '8℃'
      )
    ])
  end

  it 'renders a list of posts' do
    render
    assert_select 'tr>td', text: 'London'.to_s, count: 1
    assert_select 'tr>td', text: 'New York'.to_s, count: 1
    assert_select 'tr>td', text: 'MyNote'.to_s, count: 2
    assert_select 'tr>td', text: current_user.id.to_s, count: 2
    assert_select 'tr>td', text: '12℃'.to_s, count: 1
    assert_select 'tr>td', text: '8℃'.to_s, count: 1
  end
end
