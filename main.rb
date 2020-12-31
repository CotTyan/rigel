require 'discordrb'
require 'dotenv'

Dotenv.load

info_channel = ENV['CHANNEL_ID']
transfer_to = ENV['TRANSFER']

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

bot.command :help do | event |
    event.send_embed do | embed |
        embed.title = "Command List"
        embed.url = "https://github.com/laminne/rigel"
        embed.colour = 0x00ccff
        embed.description = "```*r.help - このヘルプを表示\n*r.about - このボットの詳細を表示\n*r.LICENSE - ソースコードのライセンスを表示 ``` ***†新機能†*** \n メッセージに📧の絵文字をつけると自動的に学校からのお知らせチャンネルに転送します\n\n機能追加は言ってもらえば(僕の技術力の許す限り)しようと思いますのでよろしくお願いします"
        embed.footer = Discordrb::Webhooks::EmbedFooter.new(
            text: "このボットのソースコードはMITライセンスの元、オープンソースで公開されています",
        )
    end
end

#bot.voice_state_update do |event|
#    user = event.user.name

#    if event.channel == nil then
#        channel_name = event.old_channel.name
#        bot.send_message(info_channel, "```#{user} が #{channel_name}を出ました```")
#    else
#        channel_name = event.channel.name

#        bot.send_message(info_channel, " ```#{user} が #{channel_name}に入りました```")
#    end
#end

bot.reaction_add do | event |
    if event.emoji.name == "📧"
        message = event.message
        bot.send_message(transfer_to, "```#{message}```")        
    end
end

bot.run
