APP.views.LoginView = Backbone.View.extend({
  template: JST["app/templates/login"],

  events: {
    "click .sign-in-button": "handleSignIn",
    "blur input" : "prevalidateModel",
    "keypress input" : "prevalidateModel",
  },

  initialize: function(){
    _.bindAll(this, "render", "ready", "handleSignIn", "handleSignInSuccess", "handleSignInError");
    this.$el.ready(this.ready);
    this.render();
  },

  valid: function(){
    console.log("valid()");
    /*this.$el.find(".alert").hide();
    this.$el.find(".alert-success").fadeIn();*/
  },
  invalid: function(){
    console.log("invalid()");
    /*$(".alert", this.$el).hide();
    $(".alert-error", this.$el).fadeIn();*/
  },

  handleSignIn: function(e){
    e.preventDefault();

    this.updateModel();

    var errors = this.model.validate();
    
    if(errors === undefined){
      this.model.save({}, {
        success: this.handleSignInSuccess,
        error: this.handleSignInError
      });
      this.handleWaitingResponse();  

    }else{
      _(errors).each(function(errorMsg, attrName){
        var $el = $("[name="+attrName+"]", this.$el);
        this.prevalidate(attrName, $el);
      }, this);
    }
  },

  prevalidateWholeModel: function(){
    var inputs = $("input", this.$el);

    _(inputs).each(function(el, index){
      this.model.set( $(el).attr("name"), $(el).val() );
    }, this);
    
  },

  prevalidateModel: function(e){
    var $el = $(e.target);
    var attrName = $el.attr("name");
    this.prevalidate(attrName, $el);
  },

  prevalidate: function(attrName, el){
    var errorMsg = this.model.preValidate( attrName, $(el).val() );
    if(errorMsg){
      this.showInvalidInput(attrName, errorMsg);
    }else{
      this.showValidInput(attrName, errorMsg);
    }
  },

  showInvalidInput: function(attr, error){
    var $control = $("[name="+attr+"]", this.$el);
    var $group = $control.parents(".control-group");
    $group.addClass("error");
    if($group.find(".help-inline").length === 0){
      $group.find(".controls").append("<span class='help-inline error-message'></span>");
    }
    $group.find(".help-inline").text(error);    
  },

  showValidInput: function(attr, error){
    var $control = $("[name="+attr+"]", this.$el);
    var $group = $control.parents(".control-group");
    $group.removeClass("error");
    $group.addClass("success");
    $group.find(".help-inline.error-message").remove();
  },

  updateModel: function(e){
    var inputs = $("input", this.$el);

    _(inputs).each(function(el, index){
      this.model.set( $(el).attr("name"), $(el).val() );
    }, this);
  },

  handleWaitingResponse: function(){
    $("input", this.$el).attr("disabled", "disabled");
    $(".sign-in-button", this.$el).button("loading");
  },

  handleSignInSuccess: function(model, jqXHR){
    console.log("success model, response:", model, jqXHR); 
  },

  handleSignInError: function(a, b, c){
    console.log("error a, b, c: ", a, b, c);
  },

  ready:function(){
    $(".input-email", this.$el).focus();
  },

  render: function(){
    this.$el.html(this.template(this.model.toJSON()));
    return this;
  }

});

