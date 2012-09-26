//Add validation to the models using the backbone.validation plugin
_.extend(Backbone.Model.prototype, Backbone.Validation.mixin);

APP.main = function(current_user){
  var appView = new APP.views.AppView(current_user);
};


