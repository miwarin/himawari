#
# twitter bot
# @_himawari_h
#

require 'twitter'
require 'pp'

module Himawari
  class Himawari
    def initialize()
      # ログイン
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key = 'CONSUMER_KEY'
        config.consumer_secret = 'CONSUMER_SECRET'
        config.access_token = 'ACCESS_TOKEN'
        config.access_token_secret = 'ACCESS_TOKEN_SECRET'
      end 
    end

    def show_my_profile
      puts @client.user.screen_name   # アカウントID
      puts @client.user.name          # アカウント名
      puts @client.user.description   # プロフィール
      puts @client.user.tweets_count  # ツイート数
    end

    def muscle_training?()
      @client.home_timeline.each {|tweet|
#        puts tweet.text
#        puts tweet.user.screen_name
#        puts tweet.id
        if tweet.text =~ /筋トレ(した|終わった|終わり|完了)/
          @client.update("@#{tweet.user.screen_name} お疲れさまです", in_reply_to_status_id: tweet.id)
        end
        
      }
    end
  end # class Himawari
end # module Himawari

def main(argv)
  himawari = Himawari::Himawari.new()
  himawari.muscle_training?()
end

main(ARGV)
