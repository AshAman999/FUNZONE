//create a simple express server
var express = require("express");
var app = express();
var server = require("http").createServer(app);
// var io = require("socket.io").listen(server);
var port = process.env.PORT || 3000;
//import user model from user.js
var User = require("./user.js");

//create and connect to mongodb uri
var mongoose = require("mongoose");
var mongoUri = process.env.MONGOLAB_URI || "mongodb://localhost/test";
mongoose.connect(mongoUri);

app.listen(port, function () {
  console.log("Listening on port " + port);
});

app.get("/", function (req, res) {
  res.json({ message: "Welcome to the API" });
});
//listen for post request to process signup
app.post("/signup", function (req, res) {
  //get the data from the request
  var data = req.body;
  //create a new user
  var user = new User(data);
  //save the user
  user.save(function (err) {
    if (err) {
      res.send(err);
    } else {
      //send user token

      res.send(user);
    }
  });
});
