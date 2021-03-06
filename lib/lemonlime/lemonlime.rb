require 'paintbucket'
require 'fileutils'
require 'sprite_factory'

include Paintbucket

SpriteFactory.report      = true
SpriteFactory.nocomments  = true
SpriteFactory.pngcrush    = true
SpriteFactory.layout      = :packed
SpriteFactory.cssurl      = "image-url('$IMAGE')"

IMAGE_FOLDER  = 'app/assets/images'
SPRITE_FOLDER = 'app/assets/stylesheets/sprites'

module Lemonlime
  def sprite_images
    # make sprite folder if it doesn't exist
    FileUtils.mkdir_p(SPRITE_FOLDER) unless File.directory?(SPRITE_FOLDER)

    # check dependencies for imagemagick
    return unless dependency_check

    # sprite the images
    get_dirs.each do |dir|
      paint_warn("Spriting images in folder #{dir}")

      images  = IMAGE_FOLDER + dir
      options = {
        style: 'scss',
        output_style: "#{SPRITE_FOLDER}/#{dir}.scss"
      }

      begin
        SpriteFactory.run!(images, options) do |images|
          images.map do |name, data|
            prefix = dir.sub('/sprite-','')
            "@mixin sprite-#{prefix}-#{name} {#{data[:style].gsub(/[\n]+/, ';')}}"
          end
        end
      rescue LoadError
        paint_error('SpriteFactory.run! failed. Most likely because of RMagick')
        paint_hint('Install gem `rmagick` on your system ruby')
        raise
      end
    end
  end

  private

  def get_dirs
    Dir["#{IMAGE_FOLDER}/sprite-*"]
      .select { |f| File.directory? f }
      .map    { |d| d.sub(IMAGE_FOLDER,'') }
  end

  def command?(name)
    `which #{name}`
    $?.success?
  end

  def dependency_check
    unless command?('convert')
      paint_error('You are missing the `imagemagic` library required for spriting')
      paint_hint("We're going to try and install the dependencies for sprite-factory now..")

      if (/darwin/ =~ RUBY_PLATFORM) != nil
        system('brew uninstall imagemagick && brew install imagemagick')
      elsif (/linux/ =~ RUBY_PLATFORM) != nil
        system('sudo apt-get install imagemagick-dev')
      end

      paint_warn("Re-run the sprite rake task and cross your fingers")
      return false
    end
    return true
  end
end
