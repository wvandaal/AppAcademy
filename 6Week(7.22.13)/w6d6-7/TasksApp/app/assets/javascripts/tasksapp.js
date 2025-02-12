window.TD = {
  // we'll eventually store Backbone classes inside of these namespaces
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},

  initialize: function ($sidebar, $content, tasksData) {
  	var tasks = new TD.Collections.Tasks(tasksData);

  	this.installSidebar($sidebar, tasks);

  	// startup router
  	new TD.Routers.TasksRouter($content, tasks);
  	// begin listening for navigation events
  	Backbone.history.start();	
  },

  installSidebar: function ($sidebar, tasks) {
  	var that = this;

  	var tasksListView = new TD.Views.TasksListView({
  		collection: tasks
  	});

  	$sidebar.html(tasksListView.render().$el);
  }
};