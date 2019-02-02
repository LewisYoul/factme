require 'rails_helper'

RSpec.fdescribe Api::TemperaturesController, type: :controller do
  let(:temperature_params) do
    { 
      temperature: {
        temp: 54.09,
        datetime: Time.now
      }
    }
  end

  describe '#POST record' do
    it 'returns a good response' do
      post :record, params: temperature_params

      expect(response).to have_http_status(:ok)
    end

    it 'creates a new Temperature record' do
      expect { post :record, params: temperature_params }
        .to change { Temperature.count }.by(1)
    end

    context 'when the temperature fails to save' do
      let(:temperature_double) do
        instance_double(Temperature, save: false)
      end

      before do
        allow(Temperature).to receive(:new).and_return(temperature_double)
      end

      it 'returns bad request' do
        post :record, params: temperature_params
        
        expect(response).to have_http_status(:bad_request)
      end
      
      it 'does not create a temperature record' do
        expect{ post :record, params: temperature_params }
          .not_to change { Temperature.count }
      end
    end
  end
end
