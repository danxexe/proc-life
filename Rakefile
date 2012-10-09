require 'rubygems'
require 'coffee-script'

namespace :coffee do
  task :compile, :filename do |t, args|
    File.open 'public/javascripts/application.js', 'w' do |f|
      [
        "public/javascripts/grid.js.coffee",
        "public/javascripts/creature_data.js.coffee",
        "public/javascripts/creature_frame.js.coffee",
        "public/javascripts/creature.js.coffee",
        "public/javascripts/main.js.coffee"
        ].each do |filename|
          f.puts CoffeeScript.compile(File.open(filename))
        end
    end
  end
end