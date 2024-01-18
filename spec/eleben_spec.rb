# spec/eleben_spec.rb
require_relative '../lib/eleben'

describe Eleben do
  let(:base_url) { "http://127.0.0.1:7860/" } 
  let(:eleben) { Eleben.new(base_url) }

  context "when interacting with the Eleben API" do
    before do
      # Stub API requests and responses here
      allow(eleben).to receive(:get_sd_models).and_return(["model1", "model2"])
      allow(eleben).to receive(:get_sd_vae).and_return({ "vae_key" => "vae_value" })
      allow(eleben).to receive(:get_samplers).and_return(["sampler1", "sampler2"])
      allow(eleben).to receive(:get_embeddings).and_return(["embedding1", "embedding2"])
      allow(eleben).to receive(:get_options).and_return({ "option_key" => "option_value" })
      allow(eleben).to receive(:update_options).and_return({ "updated_option_key" => "updated_option_value" })
      allow(eleben).to receive(:change_model).and_return(true)
      allow(eleben).to receive(:txt2img).and_return({ "images" => ["base64_image_data"] })
      allow(eleben).to receive(:save_image_to_disk).and_return(true)
    end

    it "retrieves Stable Diffusion models" do
      models = eleben.get_sd_models
      expect(models).to eq(["model1", "model2"])
    end

    it "retrieves the Stable Diffusion VAE" do
      vae = eleben.get_sd_vae
      expect(vae).to eq({ "vae_key" => "vae_value" })
    end

    it "retrieves samplers" do
      samplers = eleben.get_samplers
      expect(samplers).to eq(["sampler1", "sampler2"])
    end

    it "retrieves embeddings" do
      embeddings = eleben.get_embeddings
      expect(embeddings).to eq(["embedding1", "embedding2"])
    end

    it "retrieves options" do
      options = eleben.get_options
      expect(options).to eq({ "option_key" => "option_value" })
    end

    it "updates options" do
      new_options = { "new_option_key" => "new_option_value" }
      updated_options = eleben.update_options(new_options)
      expect(updated_options).to eq({ "updated_option_key" => "updated_option_value" })
    end

    it "changes the model" do
      model_name = "new_model"
      result = eleben.change_model(model_name)
      expect(result).to be(true)
    end

    it "converts text to image" do
      request_body = { "prompt" => "example", "steps" => 5 }
      response = eleben.txt2img(request_body)
      expect(response).to eq({ "images" => ["base64_image_data"] })
    end

    it "saves image to disk" do
      image_data = "base64_image_data"
      output_path = "output.png"
      result = eleben.save_image_to_disk(image_data, output_path)
      expect(result).to be(true)
    end
  end
end
