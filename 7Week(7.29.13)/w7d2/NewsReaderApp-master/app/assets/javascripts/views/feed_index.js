NewReader.Views.FeedIndex = Backbone.View.extend({

  initialize: function () {
    this.errors = [];

    var that = this;
    var renderCallback = that.render.bind(that);

    _.each(["add", "change", "remove", "reset" ], function(action){
      that.listenTo(that.collection, action, renderCallback);
    });
  },

  events: {
    "click button.new_feed" : "addNewFeed",
    "click a.link" : "clearErrors"
  },

  clearErrors: function(){
    var that = this;
    if(that.errors.length){
      that.errors = [];
      that.render();
    }
  },

  render: function () {
    var that = this;

    var template = JST["feeds/index"]({
      feeds: that.collection,
      errors: that.errors
    });

    that.$el.html(template);
    return that;
  },

  addNewFeed: function(event){
    var that = this;
    var attrs = { url: that.$('#feed_url').val() }

    var successCallback = function(collection, response, options){
      that.$('#feed_url').empty();
    }

    var errorCallback = function(collection, xhr, options){
      that.errors = xhr.responseJSON.errors;
      that.render();
    }

    var newModel = new NewReader.Models.Feed(attrs);

    that.errors = [];
    newModel.once("invalid", function(model, error){
      that.errors = error;
      that.render();
    });

    that.collection.create(newModel,{
      wait: true,
      success: successCallback,
      error: errorCallback
    });
  }



});