require 'discordrb'
require 'dotenv'

Dotenv.load

info_channel = ENV['CHANNEL_ID']

bot = Discordrb::Commands::CommandBot.new(
    token: ENV['TOKEN'],
    client_id: ENV['CLIENT_ID'],
    prefix:'*r.',
    )

bot.command :hello do | message |
    message.send_message("hello,world.#{message.user.name}")
end


bot.command :about do |event|
    event.send_embed do |embed|
        embed.title = "About Rigel"
        embed.url = "https://github.com/laminne/rigel"
        embed.colour = 0x00ccff
        embed.description = "**CotTyanをRuby(Discordrb)で書き直すプロジェクト**"
        embed.footer = Discordrb::Webhooks::EmbedFooter.new(
            text: "このボットのソースコードはMITライセンスの元、オープンソースで公開されています",
        )
        embed.author = Discordrb::Webhooks::EmbedAuthor.new(
          name: 'Laminne',
          url: 'https://github.com/laminne',
          icon_url: 'https://github.com/laminne.png'
        )
        end
  end

bot.command :LICENSE do |event|
    event.send_embed do |embed|
        embed.title = "LICENSE"
        embed.url = "https://github.com/laminne/rigel"
        embed.colour = 0x00ccff
        embed.description = "```MIT License

      Copyright (c) 2020 Tatsuto Laminne Yamamoto
      
      Permission is hereby granted, free of charge, to any person obtaining a copy
      of this software and associated documentation files (the \"Software\"), to deal
      in the Software without restriction, including without limitation the rights
      to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
      copies of the Software, and to permit persons to whom the Software is
      furnished to do so, subject to the following conditions:
      
      The above copyright notice and this permission notice shall be included in all
      copies or substantial portions of the Software.
      
      THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
      IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
      FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
      AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
      LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
      OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
      SOFTWARE.```"
        embed.footer = Discordrb::Webhooks::EmbedFooter.new(
            text: "詳しくはプロジェクトページをご覧ください。",
        )
        embed.author = Discordrb::Webhooks::EmbedAuthor.new(
            name: 'Laminne',
            url: 'https://github.com/laminne',
            icon_url: 'https://github.com/laminne.png'
      )
    end
  end

bot.voice_state_update do |event|
    user = event.user.name

    if event.channel == nil then
        channel_name = event.old_channel.name
        bot.send_message(info_channel, "```#{user} が #{channel_name}を出ました```")
    else
        channel_name = event.channel.name

        bot.send_message(info_channel, " ```#{user} が #{channel_name}に入りました```")
    end
end

bot.run
