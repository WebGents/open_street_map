RSpec.describe OpenStreetMap::Client::Search do
  describe '.search' do
    let(:client) { OpenStreetMap::Client.new }

    context 'for bad request' do
      context 'for bad params' do
        it 'returns hash with error message' do
          expect(client.search).to eq('errors' => 'Bad request')
        end
      end
    end

    context 'for correct request' do
      it 'returns object data' do
        response = client.search(q: '135 pilkington avenue, birmingham', format: 'json', addressdetails: '1')

        expect(response.is_a?(Array)).to eq true
        expect(response[0]['address']).to_not eq nil
        expect(response[0]['lat']).to_not eq nil
        expect(response[0]['lon']).to_not eq nil
        sleep(1)
      end

      it 'for xml format returns object data' do
        response = client.search(q: '135 pilkington avenue, birmingham', format: 'xml', addressdetails: '1')

        expect(response.is_a?(String)).to eq true
        sleep(1)
      end
    end
  end
end
