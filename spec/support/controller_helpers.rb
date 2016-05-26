module ControllerHelpers
  def client_sign_in(client = double('client'))
    if client.nil?
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :client})
      allow(controller).to receive(:current_client).and_return(nil)
    else
      allow(request.env['warden']).to receive(:authenticate!).and_return(client)
      allow(controller).to receive(:current_client).and_return(client)
    end
  end
end