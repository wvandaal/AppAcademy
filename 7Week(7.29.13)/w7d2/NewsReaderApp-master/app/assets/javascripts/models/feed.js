NewReader.Models.Feed = Backbone.Model.extend({
  validate: function(){
    var that = this;
    if(that.get('url').length === 0){
      return ["Url can't be blank"];
    }
  }
});