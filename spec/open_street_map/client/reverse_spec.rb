RSpec.describe OpenStreetMap::Client::Reverse do
  describe '.reverse' do
    let(:client) { OpenStreetMap::Client.new }

    context 'for bad request' do
      context 'for bad params' do
        it 'returns hash with error message' do
          expect(client.reverse).to eq('errors' => 'Bad request')
        end
      end
    end

    context 'for correct request' do
      it 'returns address data' do
        response = client.reverse(format: 'json', lat: '52.594417', lon: '39.493115')

        expect(response.is_a?(Hash)).to eq true
        expect(response['lat']).to_not eq nil
        expect(response['lon']).to_not eq nil
      end

      it 'for xml format returns address data' do
        response = client.reverse(format: 'xml', lat: '52.594417', lon: '39.493115')

        expect(response.is_a?(String)).to eq true
      end
    end
  end
end
