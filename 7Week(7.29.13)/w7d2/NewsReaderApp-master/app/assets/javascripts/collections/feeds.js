NewReader.Collections.Feeds = Backbone.Collection.extend({

  initialize: function() {
    this.url = '/feeds/';
    this.model = NewReader.Models.Feed;
  }

});