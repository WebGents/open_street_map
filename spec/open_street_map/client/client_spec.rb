# frozen_string_literal: true

RSpec.describe OpenStreetMap::Client do
  describe '.search' do
    let(:client) { OpenStreetMap::Client.new }

    context 'for bad request' do
      context 'for bad params' do
        it 'returns hash with error message' do
          expect(client.search).to_not eq('errors' => 'Bad request')
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
      end

      it 'for xml format returns object data' do
        response = client.search(q: '135 pilkington avenue, birmingham', format: 'xml', addressdetails: '1', accept_language: 'fr')

        expect(response.is_a?(Hash)).to eq true
        expect(response['searchresults']).to_not eq nil
      end
    end
  end

  describe '.reverse' do
    let(:client) { OpenStreetMap::Client.new }

    context 'for bad request' do
      context 'for bad params' do
        it 'returns hash with error message' do
          expect(client.reverse).to eq('error' => { 'code' => '400', 'message' => 'Parameter \'lon\' missing.' })
        end
      end
    end

    context 'for correct request' do
      it 'returns address data' do
        response = client.reverse(format: 'json', lat: rand(47.0..53.0).round(6).to_s, lon: rand(6.0..14.0).round(6).to_s)

        expect(response.is_a?(Hash)).to eq true
        expect(response['lat']).to_not eq nil
        expect(response['lon']).to_not eq nil
      end

      it 'for xml format returns address data' do
        response = client.reverse(format: 'xml', lat: rand(47.0..53.0).round(6).to_s, lon: rand(6.0..14.0).round(6).to_s)

        expect(response.is_a?(Hash)).to eq true
        expect(response['reversegeocode']).to_not eq nil
      end
    end
  end
end
