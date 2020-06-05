module WordsHelper
    def splice_word(word)
      words = []
      n = 0
      for i in 1..5 do
        words.push(word.slice(n, 18))
        n += 18
      end
      p words
    end
end
