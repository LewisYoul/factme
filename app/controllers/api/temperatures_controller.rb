module Api
  class TemperaturesController < ApiController

    def record
      temperature = Temperature.new(temperature_params)
      if temperature.save
        head :ok
      else
        head :bad_request
      end   
    end

    private

    def temperature_params
      params.require(:temperature).permit(:temp, :datetime)
    end
  end
end