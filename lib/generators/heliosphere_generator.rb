class HeliosphereGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  desc "This generator creates an initializer file at config/initializers"
  def create_initializer_file
    copy_file "heliosphere.rb", "config/initializers/heliosphere.rb"
  end

end
