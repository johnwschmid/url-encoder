class Base62
  ALPHABET = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".freeze
  BASE = ALPHABET.length
  # number = 1024
  def self.encode(number)
    return '0' if number == 0 || number.nil?
    result = ''
    while number > 0
      number, index = number.divmod BASE
      char = ALPHABET[index]
      result.prepend char
    end
    result
  end
  def self.decode(string)
  end
  p encode(nil)
end
