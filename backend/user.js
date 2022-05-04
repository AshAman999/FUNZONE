var mongoose = require("mongoose");
var Schema = mongoose.Schema;
var ObjectId = Schema.ObjectId;

//create the user model
var UserSchema = new Schema({
  name: String,
  email: String,
  password: String,
  created_at: Date,
  updated_at: Date,
});

var User = mongoose.model("User", UserSchema);

//eport the user model
module.exports = User;
