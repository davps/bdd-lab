  APP.views.AppView = Backbone.View.extend({
    el: $("#content"),

    events: {
      "click .btn" : "handleClick"
    },

    initialize: function(){
      _.bindAll(this, "render", "handleClick");

      this.current_view;
      this.user_session_model = new APP.models.UserSession();

//      console.log("this.options: ", this.options, this.options.current_user, this.options.current_user.email);
      //$("#hello").html(JST["app/templates/hello"]({ name: "Sam" }));

      if(this.options.current_user){
	$(".btn").append(" || logueado");
      }else{
	$(".btn").append(" || NO logueado");
        this.current_view = new APP.views.LoginView({
          model: this.user_session_model
        });
        
      }

      this.render();
    },

    handleClick: function(){
/*      var user_session = new APP.models.UserSession();
      user_session.set("email", "david.py.1@gmail.com");
      user_session.set("password", "123456");
      user_session.save({}, {success: function(a, b, c){
        console.log("sucess save user_session with params: ", a, b, c);
      }});
*/      
    },

    render: function(){
      if(this.current_view){
        this.$el.html(this.current_view.render().el);
      }
      return this;
    }

  });
  

