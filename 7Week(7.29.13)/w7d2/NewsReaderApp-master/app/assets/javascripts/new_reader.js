window.NewReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function($sidebar, $content, feedsData) {
    var that = this;
    var feeds = new NewReader.Collections.Feeds(feedsData);

    that.installSidebar($sidebar, feeds);

    new NewReader.Routers.FeedsRouter(feeds, $content);
    Backbone.history.start();
  },

  installSidebar: function($sidebar, feeds){
    var that = this;

    var indexView = new NewReader.Views.FeedIndex({
      collection: feeds
    });

    $sidebar.html(indexView.render().$el);
  }
};

$(document).ready(function(){
  var feedData = JSON.parse($('#bootstrapped_data').text());

  NewReader.initialize($('#sidebar'), $('#content'), feedData);
});
