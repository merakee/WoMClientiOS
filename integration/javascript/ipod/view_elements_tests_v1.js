// tests with tuneup
//#import "../../../../Pods/tuneup_js/tuneup.js"
#import "../../../tuneup_js/tuneup.js"

test("Sign in options Screen test", function(target, app) {
     //UIATarget.localTarget().logElementTree();
     
     assertWindow({
                  buttons:[
                           { name: "Sign in as Guest" },
                           { name: "Sign up" },
                           { name: "Sign in" }
                           
                           
                           ]
                  });
     
     });



test("Sign in Screen test", function(target, app) {
     window = app.mainWindow();
     target.delay(1);
     window.buttons()['Sign in'].tap()
     
     //UIATarget.localTarget().logElementTree();
     
     assertWindow({
                  textFields:[
                              { name: "Email" }
                              ],
                  secureTextFields:[
                                    { name: "Password" }
                                    ],
                  buttons:[
                           { name: "cancel" },
                           { name: "Login" }
                           ],
                  onPass: function(window) {
                  window.buttons()['cancel'].tap()
                  }
                  });
     });

test("Sign Up Screen test", function(target, app) {
     window = app.mainWindow();
     target.delay(1);
     window.buttons()['Sign up'].tap()
     
     assertWindow({
                  textFields:[
                              { name: "Email" }
                              ],
                  secureTextFields:[
                                    { name: "Password" },
                                    { name: "Password Confirmation" }
                                    ],
                  buttons:[
                           { name: "cancel" },
                           { name: "complete signup" },
                           ],
                  onPass: function(window) {
                  window.buttons()['cancel'].tap()
                  }
                  });
     });

test("Guest Content Screen test", function(target, app) {
     window = app.mainWindow();
     target.delay(1);
     window.buttons()['Sign in as Guest'].tap()

     target.delay(1);

     //UIATarget.localTarget().logElementTree();

     assertWindow({
                  buttons:[
                           { name: "wom content signInButton" },
                           { name: "kill" },
                           { name: "spread" },
                           { name: "newtopic btn" }
                           ],
//                  images:{
//                              textViews:[
//                                         {name: "Content Text"}
//                                         ]
//                  },
                  onPass: function(window) {
                  // move over some conent
                  for (i = 0; i < 3; i++) {
                  flip = Math.random() > 0.5
                  window.images()[0].textViews()[0].dragInsideWithOptions({startOffset:{x:flip?0.0:1.0, y:0.5}, endOffset:{x:flip?1.0:0.0, y:0.5}, duration:0.5})
                       target.delay(3);
                  }

                  window.buttons()['wom content signInButton'].tap()
                  }
                  });
     });


test("Sign in to Content Screen test", function(target, app) {
     window = app.mainWindow();
     target.delay(1);
     window.buttons()['Sign in'].tap()

     target.delay(1);
     // sign in
     window.textFields()["Email"].setValue("me@me.com")
     window.secureTextFields()["Password"].setValue("password")
     app.keyboard().typeString("\n");
     window.buttons()['Login'].tap()

     target.delay(1);
     assertWindow({
                  buttons:[
                           { name: "wom content signOutButton" },
                           { name: "kill" },
                           { name: "spread" },
                           { name: "newtopic btn" }
                           ],
                  onPass: function(window) {
                    window.buttons()['wom content signOutButton'].tap()
                  }
                  });
     });

test("User Content Screen test", function(target, app) {
     window = app.mainWindow();
     target.delay(1);
     window.buttons()['Sign in'].tap()

     target.delay(1);
     // sign in
     window.textFields()["Email"].setValue("me@me.com")
     window.secureTextFields()["Password"].setValue("password")
     app.keyboard().typeString("\n");
     window.buttons()['Login'].tap()

     target.delay(3);
     
     assertWindow({
                  buttons:[
                           { name: "wom content signOutButton" },
                           { name: "kill" },
                           { name: "spread" },
                           { name: "newtopic btn" }
                           ],
                  onPass: function(window) {

                  // move over some conent
                  for (i = 0; i < 3; i++) {
                  flip = Math.random() > 0.5
                  window.images()[0].textViews()[0].dragInsideWithOptions({startOffset:{x:flip?0.0:1.0, y:0.5}, endOffset:{x:flip?1.0:0.0, y:0.5}, duration:0.5})
                  target.delay(3);
                  }

                    window.buttons()['wom content signOutButton'].tap()
                  }
                  });
     });


test("Sign in and Compose Screen test", function(target, app) {
     window = app.mainWindow();
     target.delay(1);
     window.buttons()['Sign in'].tap()

     target.delay(1);
     // sign in
     window.textFields()["Email"].setValue("me@me.com")
     window.secureTextFields()["Password"].setValue("password")
     app.keyboard().typeString("\n");
     window.buttons()['Login'].tap()

     target.delay(3);
     window.buttons()['newtopic btn'].tap()

     target.delay(1);

     UIALogger.logMessage("Compose view....")
     
     assertWindow({
//                  buttons:[
//                           { name: "wom compose cameraOptionsButto" },
//                           { name: "cancel" },
//                           { name: "wom compose postButton" },
//                           { name: "Camera" },
//                           { name: "Album" }
//                           ],
                  textViews:[
                             {name: "Add Text"}
                             ],
                  onPass: function(window) {
                  // add text and post
                  text = "This is a random text for integration test: " + Math.random()
                  window.textViews()[0].setValue(text)
                  window.buttons()['wom compose postButton'].tap()

                  target.delay(5);

                  // need to check successful post

                  window.buttons()['cancel'].tap()
                  target.delay(1);
                  window.buttons()['wom content signOutButton'].tap()
                  }
                  });
     });

