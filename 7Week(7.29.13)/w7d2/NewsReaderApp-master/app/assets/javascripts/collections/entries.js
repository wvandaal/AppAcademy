NewReader.Collections.Entries = Backbone.Collection.extend({

  initialize: function(models, feedId) {
    this.url = '/feeds/' + feedId.feedId + '/entries';

    this.model = NewReader.Models.Entry;
  }

});