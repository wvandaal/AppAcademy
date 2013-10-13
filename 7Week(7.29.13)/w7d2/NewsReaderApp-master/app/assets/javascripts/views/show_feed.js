NewReader.Views.ShowFeed = Backbone.View.extend({

  events: {
    "click button.reload": "reload",
    "click button.delete": "delete"
  },

  initialize: function () {
    var that = this;

    var renderCallback = that.render.bind(that);

    _.each(["add", "change", "remove", "reset" ], function(action){
      that.listenTo(that.collection, action, renderCallback);
    });
  },

  render: function () {
    var that = this;

    var template = JST["feeds/show"]({
      feed: that.model,
      entries: that.collection
    });

    that.$el.html(template);
    return that;
  },

  reload: function (event) {
    var that = this;

    that.collection.fetch();
  },

  delete: function (event){
    var that = this;

    that.model.destroy({
      success: function(model, response, options){
        that.collection.remove(model);
        Backbone.history.navigate("#/");
      }
    });
  }
});