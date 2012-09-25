  APP.views.AppView = Backbone.View.extend({
    el: $(".div-for-backbone"),

    events: {
      "click .btn" : "handleClick"
    },

    initialize: function(){
      _.bindAll(this, "render", "handleClick");
      if(this.options.current_user){
	alert("logueado");
      }else{
	alert("NO logueado");
      }
    },

    handleClick: function(){
      var user_session = new APP.models.UserSession();
      user_session.set("email", "david.py.1@gmail.com");
      user_session.set("password", "123456");
      user_session.save({}, {success: function(a, b, c){
        console.log("sucess save user_session with params: ", a, b, c);
      }});
      
    },

    render: function(){
      return this;
    }
  });
  

