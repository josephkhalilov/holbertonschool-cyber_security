class CaesarCipher
  # Constructor initializing the shift value
  def initialize(shift)
    @shift = shift
  end

  # Public method to encrypt a plaintext message
  def encrypt(message)
    cipher(message, @shift)
  end

  # Public method to decrypt a ciphertext message
  def decrypt(message)
    cipher(message, -@shift)
  end

  # Everything below this line can only be called from within the same instance
  private

  def cipher(message, shift_value)
    # Map every character in the string through the cipher transformation
    message.chars.map do |char|
      if char.match?(/[a-z]/)
        # Shift lowercase characters within 'a'..'z' (97..122 ASCII)
        (((char.ord - 97) + shift_value) % 26 + 97).chr
      elsif char.match?(/[A-Z]/)
        # Shift uppercase characters within 'A'..'Z' (65..90 ASCII)
        (((char.ord - 65) + shift_value) % 26 + 65).chr
      else
        # Leave punctuation, spaces, and numbers completely untouched
        char
      end
    end.join
  end
end
