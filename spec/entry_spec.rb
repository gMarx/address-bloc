require_relative '../models/entry'

RSpec.describe Entry do

  describe 'attributes' do
    let(:entry) { Entry.new('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com') }

    it 'should respond to name' do
      expect(entry).to respond_to(:name)
    end

    it 'should report its name' do
      expect(entry.name).to eq('Ada Lovelace')
    end

    it 'should respond to phone number' do
      expect(entry).to respond_to(:phone_number)
    end

    it 'should report its phone number' do
      expect(entry.phone_number).to eq('010.012.1815')
    end

    it 'should respond to email' do
      expect(entry).to respond_to(:email)
    end

    it 'should report its email' do
      expect(entry.email).to eq('augusta.king@lovelace.com')
    end

  end
end
