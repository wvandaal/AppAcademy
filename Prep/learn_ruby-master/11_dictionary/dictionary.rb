class Dictionary
	attr_accessor :entries

	def initialize
		@entries = Hash.new(nil)
	end

	def add(entry)
		entry.kind_of?(String) ? @entries.merge!({entry => nil}) : @entries.merge!(entry)
	end

	def keywords
		@entries.keys.sort
	end

	def include?(key)
		@entries.key?(key)
	end

	def find(key)
		results = {}
		@entries.each_key do |k|
			results.merge!(k=>@entries[k]) if k.start_with?(key)
		end
		results
	end

	def printable
		results = ""
		@entries.keys.sort.each do |k|
			v = @entries[k].nil? ? "" : @entries[k]
			results << "[#{k}] \"" + v + "\"\n"
		end
		results.chomp
	end
end

