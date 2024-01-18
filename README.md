# Eleben

[![Gem Version](https://badge.fury.io/rb/eleben.svg)](https://badge.fury.io/rb/eleben)

Eleben is a Ruby gem for interacting with the AUTOMATIC1111 API, specifically designed for running stable diffusion models. It provides a convenient interface to perform various actions such as changing models, converting text to images, and saving the generated images to disk.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'eleben'
``` 

And then execute:
```
$ bundle install
```

Or install it yourself as:
```
$ gem install eleben
```

## Usage
```
require 'eleben'

# Initialize Eleben instance
eleben = Eleben.new(base_url: 'YOUR_API_BASE_URL', timeout: 300) 
# http://127.0.0.1:7860/ for local with default port

# Retrieve Stable Diffusion models
eleben.get_sd_models

# Retrieve Stable Diffusion VAE
eleben.get_sd_vae

# Retrieve available samplers
eleben.get_samplers

# Retrieve available embeddings
eleben.get_embeddings

# Retrieve available options
eleben.get_options

# Update options with new values
eleben.update_options(new_options: { /* your options here */ })

# Change the model used for stable diffusion
eleben.change_model(model_name: 'YOUR_MODEL_NAME')

# Convert text to image using Stable Diffusion
eleben.txt2img(request_body: { /* your request body here */ })

# Save image data to disk
eleben.save_image_to_disk(image_data: 'BASE64_ENCODED_IMAGE_DATA', output_path: 'OUTPUT_PATH')

# Convert text to image using txt2img API and save to disk
eleben.txt2img_and_save(params: { /* your params here */ }, output_path: 'OUTPUT_PATH')

```

## License

Eleben is available as open source under the terms of the [GNU General Public License v3.0](https://opensource.org/licenses/GPL-3.0).

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/lleetllama/eleben](https://github.com/lleetllama/eleben).

