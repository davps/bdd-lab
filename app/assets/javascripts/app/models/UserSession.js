APP.models.UserSession = Backbone.Model.extend({
   url: "/users/sign_in.json",

   paramRoot: "user",

/*   defaults: {
      "email" : "",
      "password": ""
   },
*/

   validation: {
     email: [{
       required : true,
       msg: "Your email is required"
     }, {
       pattern : "email",
       msg : "Your email should be valid!"
     }],

     password: [{
       required : true,
       msg : "Password is required"
     }, {
       minLength : 6,
       msg : "Your password must contains at least 6 characters"
     }]
   }

});

