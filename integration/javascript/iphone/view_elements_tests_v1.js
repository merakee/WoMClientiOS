// tests with tuneup
//#import "../../../../Pods/tuneup_js/tuneup.js"
#import "../../../tuneup_js/tuneup.js"

test("Sign in options Screen test", function(target, app) {
     //UIATarget.localTarget().logElementTree();

     assertWindow({
                  buttons:[
                           { name: "Sign up" },
                           { name: "Sign in" },
                           { name: "Sign in as Guest" }


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
                           { name: "Cancel" },
                           { name: "Login" }
                           ],
                  onPass: function(window) {
                  window.buttons()['Cancel'].tap()
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
                           { name: "Cancel" },
                           { name: "complete signup" },
                           ],
                  onPass: function(window) {
                  window.buttons()['Cancel'].tap()
                  }
                  });
     });

test("Guest Content Screen test", function(target, app) {
     window = app.mainWindow();
     target.delay(1);
     window.buttons()['Sign in as Guest'].tap()

     target.delay(1);

     checkOutContentView(window,3)

     });


test("Sign in to Content Screen test", function(target, app) {
     window = app.mainWindow();
     target.delay(1);
     window.buttons()['Sign in'].tap()

     target.delay(1);
     // sign in
     signInUser(window,"me@me.com","password")

     target.delay(1);

     checkOutContentView(window,0)

     });

test("User Content Screen test", function(target, app) {
     window = app.mainWindow();
     target.delay(1);
     window.buttons()['Sign in'].tap()

     target.delay(1);
     // sign in
     signInUser(window,"me@me.com","password")

     target.delay(3);

     checkOutContentView(window,3)

     });


test("Sign in and Compose Screen test", function(target, app) {
     window = app.mainWindow();
     target.delay(1);
     window.buttons()['Sign in'].tap()
     
     target.delay(1);
     // sign in
     signInUser(window,"me@me.com","password")
     
     target.delay(3);
     window.buttons()['Compose'].tap()
     
     target.delay(1);
     
     //UIALogger.logMessage("Compose view....")
     
     assertWindow({
                  buttons:[
                           { name: "Camera Options" },
                           { name: "Cancel" },
                           { name: "Post" },
                           ],
                  textViews:[
                             {name: "Add Text"}
                             ],
                  onPass: function(window) {
                  // add text and post
                  postText(app,window,"This is a random text for integration test: ",3);
                  
                  // check out camera options
                  window.buttons()['Camera Options'].tap()
                  target.delay(1);
                  checkoutCameraOption(app);
                  
                  // need to check successful post
                  window.buttons()['Cancel'].tap()
                  signOutUser(window);
                  }
                  });
     });



//=====================================
// Common Functions
function signInUser(wondow,email,password){
    // sign in
    window.textFields()["Email"].setValue(email)
    window.secureTextFields()["Password"].setValue(password)
    //app.keyboard().typeString("\n");
    window.buttons()['Login'].tap()
}
function signUpUser(wondow,email,password){
    // sign in
    window.textFields()["Email"].setValue(email)
    window.secureTextFields()["Password"].setValue(password)
    window.secureTextFields()["Password Confirmation"].setValue(password)
    app.keyboard().typeString("\n");
    //window.buttons()['Login'].tap()
}
function signOutUser(wondow){
    target.delay(1);
    window.buttons()['PageLogoButton'].tap()
    target.delay(1);
    window.buttons()['SignInAndOutButton'].tap()
}

function checkSignInOutView(window){
    assertWindow({
                 buttons:[
                          { name: "PageLogoButton" },
                          { name: "Kill" },
                          { name: "Spread" },
                          { name: "Compose" },
                          { name: "DismissButton" },
                          { name: "SignInAndOutButton" }
                          ],
                 //                  images:{
                 //                              textViews:[
                 //                                         {name: "Content Text"}
                 //                                         ]
                 //                  },
                 onPass: function(window) {
                 window.buttons()['DismissButton'].tap()
                 signOutUser(window)
                 }
                 });
}
function checkOutContentView(window,count){
    assertWindow({
                 buttons:[
                          { name: "PageLogoButton" },
                          { name: "Kill" },
                          { name: "Spread" },
                          { name: "Compose" }
                          ],
                 onPass: function(window) {
                 // move over some conent
                 respondToContent(window,count)
                 
                 window.buttons()['PageLogoButton'].tap()
                 
                 // login signout window tests
                 target.delay(1);
                 checkSignInOutView(window);
                 
                 }
                 });
    
}

function checkoutCameraOption(app){
    target.delay(1);
    app.actionSheet().elements()[0].tap();
    target.delay(1);
}
function respondToContent(window,count){
    // move over some conent
    for (i = 0; i < count; i++) {
        flip = Math.random() > 0.5
        window.images()[2].textViews()[0].dragInsideWithOptions({startOffset:{x:flip?0.0:1.0, y:0.5}, endOffset:{x:flip?1.0:0.0, y:0.5}, duration:0.5})
        target.delay(3);
    }
    for (i = 0; i < count; i++) {
        flip = Math.random() > 0.5
        if(flip){
            window.buttons()['Spread'].tap()
        }
        else{
            window.buttons()['Kill'].tap()
        }
        target.delay(3);
    }
    
}

function postText(app,window,text,delay){
    // add text and post
    text = text + Math.random()
    window.textViews()[0].setValue(text)
    target.delay(1);
    //window.buttons()['Post'].tap()
    app.keyboard().typeString("\n");
    
    target.delay(delay);
}

