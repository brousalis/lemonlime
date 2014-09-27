task :sprite => :environment do
  require 'sprite_factory'
  require 'fileutils'

  SpriteFactory.report      = true
  SpriteFactory.nocomments  = true
  SpriteFactory.pngcrush    = true
  SpriteFactory.layout      = :packed
  SpriteFactory.cssurl      = "image-url('<%= asset_path '$IMAGE' %>')"

  stylesheets = 'app/assets/stylesheets/sprites'
  FileUtils.mkdir_p(stylesheets) unless File.directory?(stylesheets)

  Dir['app/assets/images/sprite-*'].select {|f| File.directory? f}
                                   .map {|d| d.sub('app/assets/images/','')}.each do |dir|

    SpriteFactory.run!("app/assets/images/#{dir}", 
                       style: 'scss', 
                       output_style: "#{stylesheets}/#{dir}.css.scss.erb") do |images|

      images.map do |name, data|
        "@mixin sprite-#{name} {#{data[:style].gsub(/[\n]+/, ";")}}"
      end
    end
  end
end
