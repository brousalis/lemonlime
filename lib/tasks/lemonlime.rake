require 'lemonlime'

task :sprite => :environment do
  include Lemonlime
  sprite_images
end
