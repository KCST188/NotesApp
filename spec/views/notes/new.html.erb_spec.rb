require 'rails_helper'

RSpec.describe 'notes/new', type: :view do
  before(:each) do
    assign(:note, Note.new(
      city: 'London',
      note: 'MyNote',
      user: nil
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
