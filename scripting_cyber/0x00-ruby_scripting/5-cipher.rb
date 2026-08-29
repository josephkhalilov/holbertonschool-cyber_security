class CaesarCipher
  def initialize(shift)
    @shift = shift
  end

  def encrypt(message)
    cipher(message, @shift)
  end

  def decrypt(message)
    cipher(message, -@shift)
  end

  private

  def cipher(message, shift)
    message.chars.map do |char|
      if char =~ /[A-Z]/
        shift_char(char, shift, 'A')
      elsif char =~ /[a-z]/
        shift_char(char, shift, 'a')
      else
        char
      end
    end.join
  end

  def shift_char(char, shift, base)
    base_ord = base.ord
    offset = (char.ord - base_ord + shift) % 26
    offset += 26 if offset.negative?
    (base_ord + offset).chr
  end
end
