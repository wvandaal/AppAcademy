
class Object
	def new_attr_accessor(*args)
		args.each do |arg|
			define_method(arg) { instance_variable_get("@#{arg}") }
			define_method("#{arg}=") {|val| instance_variable_set("@#{arg}", val) }
		end
	end
end
