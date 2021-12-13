# frozen_string_literal: true

RSpec.describe OpenStreetMap do
  it 'has a version number' do
    expect(OpenStreetMap::VERSION).not_to be nil
  end
end
