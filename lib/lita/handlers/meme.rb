require "json"

module Lita
  module Handlers
    class Meme < Handler
      route /^meme list$/, :list, command: true, help: { "lita meme list" => "Returns a list of memes" }
      route /^(.*)$/i, :detect_meme, command: true

      MEMES = [
        { regex: /(one does not simply) (.*)/i, id: 61579, description: "One does not simply X" },
        { regex: /(i don'?t always .*) (but when i do,? .*)/i, id: 61532, description: "I don't always X but when I do Y" },
        { regex: /aliens ()(.*)/i, id: 101470, description: "X [Aliens]" },
        { regex: /(not sure if .*) (or .*)/i, id: 61520, description: "Not sure if X or Y" },
        { regex: /(.*),? (\1 everywhere)/i, id: 347390, description: "X X everywhere" },
        { regex: /(y u no) (.+)/i, id: 61527, description: "Y u no X" },
        { regex: /(brace yoursel[^\s]+) (.*)/i, id: 61546, description: "brace yourself X" },
        { regex: /(.*) (all the .*)/i, id: 61533, description: "X all the Y" },
        { regex: /(.*) (that would be great|that'?d be great)/i, id: 563423, description: "X that'd be great" },
        { regex: /(.*) (\w+\stoo damn .*)/i, id: 61580, description: "X too damn Y" },
        { regex: /(yo dawg .*) (so .*)/i, id: 101716, description: "Yo dawg X so Y" },
        { regex: /(.*) (.* gonna have a bad time)/i, id: 100951, description: "X you're gonna have a bad time" },
        { regex: /(am i the only one around here) (.*)/i, id: 259680, description: "Am I the only one around here X" },
        { regex: /(what if i told you) (.*)/i, id: 100947, description: "What if I told you X" },
        { regex: /(.*) (ain'?t nobody got time for? that)/i, id: 442575, description: "X ain't nobody got time for that" },
        { regex: /(.*) (a+n+d+ it'?s gone)/i, id: 766986, description: "X and it's gone" },
        { regex: /(.* bats an eye) (.* loses their minds?)/i, id: 1790995, description: "X bats an eye Y loses their mind" },
        { regex: /(back in my day) (.*)/i, id: 718432, description: "Back in my day X" },
        { regex: /(.*) (this is .*)/i, id: 14457516, description: "X this is Y [Sparta kick]" },
        { regex: /(shut up) (and take .*)/i, id: 176908, description: "Shut up and take X" },
        { regex: /(.* bad) (.* should feel bad)/i, id: 35747, description: "X is/are bad and Y should feel bad" }
      ]

      config :username
      config :password

      def list(response)
        [].tap do |list|
          MEMES.each do |meme|
            list << "#{meme[:description]}"
          end
          response.reply(list)
        end
      end

      def detect_meme(response)
        input = response.matches[0][0]
        MEMES.each do |meme|
          match = meme[:regex].match(input)
          return reply(meme[:id], match, response) if match
        end
      end

      def reply(meme_id, match, response)
        endpoint = "https://api.imgflip.com/caption_image"
        data = { template_id: meme_id, text0: match[1], text1: match[2], username: config.username, password: config.password }
        json = JSON.parse(http.post(endpoint, data).body)
        response.reply(json["data"]["url"]) if json["success"]
      end
    end

    Lita.register_handler(Meme)
  end
end
