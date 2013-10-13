def caesar_cipher(str, shift)
	alpha = ('a'..'z').to_a.join('')
	cipher = ('a'..'z').to_a.rotate(shift).join('')

	str.tr(alpha, cipher)
end
