require 'rails_helper'

RSpec.describe Note, type: :model do
  current_user = User.first_or_create!(email: 'kacper@gmail.com', password: 'password', password_confirmation: 'password')

  it 'has a city' do
    note = Note.new(
      city: '',
      note: 'A Valid Body',
      user: current_user
    )
    expect(note).to_not be_valid

    note.city = 'London'
    expect(note).to be_valid
  end
  it 'has a note' do
    note = Note.new(
      city: 'New York',
      note: '',
      user: current_user
    )
    expect(note).to_not be_valid

    note.note = 'Has a note'
    expect(note).to be_valid
  end

  it 'has a city at least 2 characters long' do
    note = Note.new(
      city: '1',
      note: 'A Valid Note',
      user: current_user
    )
    expect(note).to_not be_valid

    note.city = '12'
    expect(note).to be_valid
  end

  it 'has a note between 5 and 300 characters' do
    note = Note.new(
      city: 'Warsaw',
      note: '1234',
      user: current_user
    )
    expect(note).to_not be_valid

    note.note = '12345'
    expect(note).to be_valid

    three_hundred_char_string = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas tincidunt, lacus quis dapibus efficitur, sapien massa fermentum nibh, sed tempor nisi magna non nisi. Etiam vehicula venenatis nulla, sit amet dapibus leo viverra eu. Sed ligula lacus, semper in leo varius, placerat viverra nisl eget.'
    note.note = three_hundred_char_string
    expect(note).to be_valid

    note.note = three_hundred_char_string + '1'
    expect(note).to_not be_valid
  end

end
