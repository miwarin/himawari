#
# twitter bot
# @_himawari_h
#

require 'a3rt/talk'
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
#      puts "-------------- fliends -------------------"
#      pp @client.friends
#      puts "-------------- fliends -------------------"
      
#      puts "-------------- followers -------------------"
#      pp @client.followers
#      puts "-------------- followers -------------------"
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

    def reply()
      @client.followers.each {|follower|
        puts "follower.screen_name #{follower.screen_name}"
        @client.user_timeline(follower.screen_name, {count: 1}).each {|tweet|
          api_key = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
          resp = A3rt::Talk.talk(tweet.text, api_key)
          rep = resp.least_perplex.reply
          puts "    #{rep}"
          @client.update("@#{tweet.user.screen_name} #{rep}", in_reply_to_status_id: tweet.id)
        }
      }
    end


  end # class Himawari
end # module Himawari

def main(argv)
  himawari = Himawari::Himawari.new()
#  himawari.show_my_profile()
#  himawari.muscle_training?()
  himawari.reply()
end

main(ARGV)
