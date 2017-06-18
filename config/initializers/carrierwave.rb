CarrierWave.configure do |config|
  
  # Use local storage if in development or test
  if Rails.env.development? || Rails.env.test?
    CarrierWave.configure do |config|
      config.storage = :file
    end
  end
  
  # Use AWS storage if in production
 
  config.fog_credentials = {
    :provider               => 'AWS',                             # required
    :aws_access_key_id      => ENV['aws_access_key'],            # required
    :aws_secret_access_key  => ENV['aws_access_secret'],     # required
    :region                 => 'ap-southeast-1'                        # optional, defaults to 'us-east-1'
  }

 if Rails.env.production?
    CarrierWave.configure do |config|
      config.storage = :fog
    end
  end
  
  
  config.fog_directory  = 'lyfeapp'               # required
  #config.fog_host       = 'https://assets.example.com'           # optional, defaults to nil
  #config.fog_public     = false                                  # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}

    module CarrierWave
    module MiniMagick
      def quality(percentage)
        manipulate! do |img|
          img.quality(percentage.to_s)
          img = yield(img) if block_given?
          img
        end
      end
    end
  end
end