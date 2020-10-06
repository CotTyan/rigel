require 'discordrb'
require 'dotenv'

Dotenv.load

bot = Discordrb::Commands::CommandBot.new(
    token: ENV['TOKEN'],
    client_id: ENV['CLIENT_ID'],
    prefix:'*r.',
    )

bot.command :hello do | message |
    message.send_message("hello,world.#{message.user.name}")
end


bot.run
