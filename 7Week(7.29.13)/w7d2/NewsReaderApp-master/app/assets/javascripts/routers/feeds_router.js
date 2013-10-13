NewReader.Routers.FeedsRouter = Backbone.Router.extend({

  initialize: function (feeds, $rootEl) {
    this.feeds = feeds;
    this.$rootEl = $rootEl;
    this._currentView = null;
  },

  routes: {
    "" : "index",
    "feeds/:feed_id/entries" : "showFeed"
  },

  index: function () {
    var that = this;

    that._swapView("");
  },

  showFeed: function (feedId) {
    var that = this;

    var entries = new NewReader.Collections.Entries({},{
      feedId: parseInt(feedId)
    });

    var successCallback = function(collection, response, options){
      var showView = new NewReader.Views.ShowFeed({
        model: that.feeds.get(feedId),
        collection: collection
      });

      that._swapView(showView);
    };

    entries.fetch({
      success: successCallback
    });
  },

  // used to prevent memory leaks by unbinding listenTo event handlers
  _swapView: function (newView) {
    this._currentView && this._currentView.remove();

    if(newView){
      this._currenView = newView;
      this.$rootEl.html(newView.render().$el);
    }else{
      this._currentView = null;
      this.$rootEl.empty();
    }
  }
});