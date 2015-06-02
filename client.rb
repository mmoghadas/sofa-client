require 'rest_client'
require 'json'
require 'clamp'
require 'yaml'

class SofaClient < Clamp::Command

  option ["-d", "--driver"], "DRIVER", "required: driver"
  option ["-n", "--name"], "SERVICE NAME", "required: name"
  option ["-s", "--state"], "STATE", "required: state"

  def execute
    post(driver, name, state)
  end

  def post(driver, name, state)
    config = YAML.load_file(ENV['HOME']+'/sofa.yml')
    token = config["prod"]["access_token"]
    data = {'name' => name, 'state' => state}.to_json
    RestClient.post("http://127.0.0.1:3000/#{driver}/update_state", data, {:content_type => :json, :authorization => "Token token=#{token}"})
  end

end

SofaClient.run
