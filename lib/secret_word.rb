class SecretWord
  def initialize
    @file = File.readlines('dictionary.txt')
  end

  def word_count
    @file.map(&:strip).to_h { |word| [word, word.length] }
  end

  def secret_word
    word_hash = word_count
    word_hash.select { |word, length| length.between?(5,12) }
            .keys
            .sample
  end
end