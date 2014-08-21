// tests with tuneup
//#import "../../../../Pods/tuneup_js/tuneup.js"
#import "../../../tuneup_js/tuneup.js"

test("Sign in options Screen test", function(target, app) {
     UIATarget.localTarget().logElementTree();
     
     assertWindow({
                  buttons:[
                           { name: "Sign in" },
                           { name: "Sign up" },
                           { name: "Sign in as Guest" }
                           ]
                  });
     
     });



test("Sign in Screen test", function(target, app) {
     window = app.mainWindow();
     target.delay(1);
     window.buttons()['Sign in'].tap()
     
     assertWindow({
                  navigationBar: {
                  name: "Sign In",
                  leftButton: { name: "Stop" }
                  },
                  textFields:[
                              { name: "Email" }
                              ],
                  secureTextFields:[
                                    { name: "Password" }
                                    ],
                  buttons:[
                           { name: "Sign in" }
                           ],
                  onPass: function(window) {
                  window.navigationBar().leftButton().tap()
                  }
                  });
     });

test("Sign Up Screen test", function(target, app) {
     window = app.mainWindow();
     target.delay(1);
     window.buttons()['Sign up'].tap()
     
     assertWindow({
                  navigationBar: {
                  name: "Sign Up",
                  leftButton: { name: "Stop" }
                  },
                  textFields:[
                              { name: "Email" }
                              ],
                  secureTextFields:[
                                    { name: "Password" },
                                    { name: "Password Confirmation" }
                                    ],
                  buttons:[
                           { name: "Sign up" }
                           ],
                  onPass: function(window) {
                  window.navigationBar().leftButton().tap()
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
                  navigationBar: {
                  leftButton: { name: "Sign In" },
                  rightButton: {name: "Compose"}
                  },
//                  images:{
//                              textViews:[
//                                         {name: "Content Text"}
//                                         ]
//                  },
                  onPass: function(window) {
                  // move over some conent
                  for (i = 0; i < 100; i++) {
                  flip = Math.random() > 0.5
                  window.images()[0].textViews()[0].dragInsideWithOptions({startOffset:{x:flip?0.0:1.0, y:0.5}, endOffset:{x:flip?1.0:0.0, y:0.5}, duration:0.5})
                       target.delay(3);
                  }
                  
                  window.navigationBar().leftButton().tap()
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
     window.buttons()['Sign in'].tap()
     
     target.delay(1);
     assertWindow({
                  navigationBar: {
                  leftButton: { name: "Sign Out" },
                  rightButton: {name: "Compose"}
                  },
                  onPass: function(window) {
                  window.navigationBar().leftButton().tap()
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
     window.buttons()['Sign in'].tap()
     
     target.delay(1);
     assertWindow({
                  navigationBar: {
                  leftButton: { name: "Sign Out" },
                  rightButton: {name: "Compose"}
                  },
                  onPass: function(window) {
                  
                  // move over some conent
                  for (i = 0; i < 200; i++) {
                  flip = Math.random() > 0.5
                  window.images()[0].textViews()[0].dragInsideWithOptions({startOffset:{x:flip?0.0:1.0, y:0.5}, endOffset:{x:flip?1.0:0.0, y:0.5}, duration:0.5})
                  target.delay(3);
                  }

                  
                  window.navigationBar().leftButton().tap()
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
     window.buttons()['Sign in'].tap()
     
     target.delay(1);
     window.navigationBar().rightButton().tap()
     
     target.delay(1);
     
     assertWindow({
                  navigationBar: {
                  leftButton: { name: "Stop" },
                  buttons:[
                           { name: "Stop" },
                           { name: "UINavigationBarBackIndicatorDefault.png" },
                           {name: "Post"},
                           {name: "Add Picture"}
                           ],
                  },
                  textViews:[
                             {name: "Add Text"}
                             ],
                  onPass: function(window) {
                  // add text and post
                  text = "This is a random text for integration test: " + Math.random()
                  window.textViews()[0].setValue(text)
                  window.navigationBar().buttons()[2].tap()
                  
                  target.delay(5);
                  
                  // need to check successful post
                  
                  window.navigationBar().leftButton().tap()
                  target.delay(1);
                  window.navigationBar().leftButton().tap()
                  }
                  });
     });

