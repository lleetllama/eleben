require 'net/http'
require 'json'
require 'base64'
require 'tempfile'
require 'fileutils'

class Eleben
    DEFAULT_TIMEOUT = 300 # Default timeout in seconds

    # Initializes a new instance of the StableDiffusion class.
    #
    # @param base_url [String] The base URL for the API.
    # @param timeout [Integer] The timeout value in seconds (optional, default is 30).
    def initialize(base_url, timeout: DEFAULT_TIMEOUT)
        @base_url = base_url
        @timeout = timeout
    end

    # Retrieves the available Stable Diffusion models.
    #
    # @return [Array] An array of Stable Diffusion models.
    def get_sd_models
        uri = URI("#{@base_url}/sdapi/v1/sd-models")
        response = Net::HTTP.get(uri)
        JSON.parse(response)
    end

    # Retrieves the Stable Diffusion Variational Autoencoder (VAE).
    #something 
    # @return [Hash] The Stable Diffusion VAE.
    def get_sd_vae
        uri = URI("#{@base_url}/sdapi/v1/sd-vae")
        response = Net::HTTP.get(uri)
        JSON.parse(response)
    end

    # Retrieves the available samplers.
    #
    # @return [Array] An array of samplers.
    def get_samplers
        uri = URI("#{@base_url}/sdapi/v1/samplers")
        response = Net::HTTP.get(uri)
        JSON.parse(response)
    end

    # Retrieves the available embeddings.
    #
    # @return [Array] An array of embeddings.
    def get_embeddings
        uri = URI("#{@base_url}/sdapi/v1/embeddings")
        response = Net::HTTP.get(uri)
        JSON.parse(response)
    end

    # Retrieves the available options.
    #
    # @return [Hash] The available options.
    def get_options
        uri = URI("#{@base_url}/sdapi/v1/options")
        response = Net::HTTP.get(uri)
        JSON.parse(response)
    end

    # Updates the options with new values.
    #
    # @param new_options [Hash] The new options to be updated.
    # @return [Hash] The updated options.
    def update_options(new_options)
        uri = URI("#{@base_url}/sdapi/v1/options")
        http = Net::HTTP.new(uri.host, uri.port)

        http.read_timeout = @timeout
        http.open_timeout = @timeout

        request = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
        request.body = new_options.to_json

        response = http.request(request)

        if response.code.to_i == 200
            JSON.parse(response.body)
        else
            raise "Error #{response.code}: #{response.message}"
        end
    end

    # Changes the model used for stable diffusion.
    #
    # @param model_name [String] The name of the model to be used.
    # @return [void]
    def change_model(model_name)
        options = get_options
        options['sd_model_checkpoint'] = model_name
        update_options(options)
    end

    # Converts text to image using Stable Diffusion.
    #
    # @param request_body [Hash] The request body containing the text.
    # @return [Hash] The generated image.
    def txt2img(request_body = {})
        uri = URI("#{@base_url}/sdapi/v1/txt2img")
        http = Net::HTTP.new(uri.host, uri.port)

        http.read_timeout = @timeout
        http.open_timeout = @timeout

        request = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
        request.body = request_body.to_json

        response = http.request(request)

        if response.code.to_i == 200
            JSON.parse(response.body)
        else
            raise "Error #{response.code}: #{response.message}"
        end
    end

    # Saves the image data to disk at the specified output path.
    #
    # @param image_data [String] The base64-encoded image data.
    # @param output_path [String] The path where the image will be saved.
    # @return [void]
    def save_image_to_disk(image_data, output_path)
        image_binary_data = Base64.decode64(image_data)

        # Use Tempfile to generate a unique temporary file path
        temp_file = Tempfile.new(['sd_image', '.png'])
        temp_file.binmode
        temp_file.write(image_binary_data)
        temp_file.close

        # Move the temporary file to the specified output path
        FileUtils.mv(temp_file.path, output_path)

        puts "Image saved to #{output_path}"
    end

    # Converts text to image using the txt2img API and saves the resulting image to disk.
    #
    # @param params [Hash] The parameters for the txt2img request.
    # @param output_path [String] The path where the image will be saved.
    # @return [void]
    def txt2img_and_save(params, output_path)
        # Make txt2img request
        txt2img_response = txt2img(params)
        puts "txt2img Response:"
        puts txt2img_response

        # Save the image to disk
        image_data = txt2img_response['images'][0]
        save_image_to_disk(image_data, output_path)
    end
end