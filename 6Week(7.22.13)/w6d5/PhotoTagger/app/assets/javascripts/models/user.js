var UserModel = (function () {

	var baseURL = "/users"

	function User(user) {
		this.id = user.id;
		this.username = user.username;
		this.passwordDigest = user.password_digest;
		this.sessionToken = user.session_token;
		this.createdAt = user.created_at;
		this.password = user.password
	}

	User.fetch = function(id) {
		$.ajax({
			url: baseURL + id,
			type: "GET",
			dataType: "JSON",
			success: function(user) {
				console.log(user);
			}
		})
	}

	User.all = function () {
		$.ajax({
			url: baseURL,
			type: "GET",
			dataType: "JSON",
			success: function(users) {
				$('.results').html(JSON.stringify(users));
			}
		});
	}
	
	User.prototype.fetch = function(id) {
		var that = this;
		$.get(baseURL + id, function(data) {
			that.username = data.username;
			that.passwordDigest = data.password_digest;
			that.sessionToken = data.session_token;
			that.createdAt = data.createdAt;
		})
	};

	User.prototype.save = function(method) {
		if (method.toLowerCase() == "put") 
			this.update()
	};

	return {
		User: User
	};

})();