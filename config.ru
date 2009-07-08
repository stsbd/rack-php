require 'json'

class RubyBridge
  def call(env)
    response = []
    data = JSON.dump(env)
    IO.popen("./rackup.php", 'r+') do |io|
      io.write data
      io.close_write
      response = io.read
    end
    JSON.load(response)
  end
end

use Reloader
run Cascade.new([
  File.new('public'),
  RubyBridge.new
])
