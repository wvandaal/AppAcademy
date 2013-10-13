TD.Views.TasksListView = Backbone.View.extend({
	// Add events here to bind them to specific methods on CSS selectors
	// events: {
	// 	"click li.task": "showTask"
	// },


	initialize: function () {
		var that = this;

		var renderCallback = that.render.bind(that);
		that.listenTo(that.collection, "add", renderCallback);
		that.listenTo(that.collection, "change", renderCallback);
		that.listenTo(that.collection, "remove", renderCallback);
	},

	//renders the given model data (stored in the collection attr)
	//into the $el attribute
	render: function() {
		var that = this;

		var renderedContent = JST["tasks/list"]({
			tasks: that.collection
		});

		that.$el.html(renderedContent);
		return that;
	}

	// Sample event method bound to 'click' even on li.task
	// ,showTask: function (el) {
	// 	console.log(
	// 		"You clicked task #" + $(el.target).attr("data-id")
	// 	);
	// }
});