var testName = "Sign in Screen test"


var target = UIATarget.localTarget();
var app = target.frontMostApp();
var window = app.mainWindow();

UIALogger.logStart( testName );
var buttonName  = 'Sign in'
if(window.buttons()[0].name()=== buttonName){
	UIALogger.logPass('Found ' + buttonName +  ' button');
}
else{
	UIALogger.logFail( buttonName +  ' missing');
}

buttonName  = 'Sign up'
if(window.buttons()[1].name()=== buttonName){
	UIALogger.logPass('Found ' + buttonName +  ' button');
}
else{
	UIALogger.logFail( buttonName +  ' missing');
}


buttonName  = 'Sign in as Guest'
if(window.buttons()[2].name()=== buttonName){
	UIALogger.logPass('Found ' + buttonName +  ' button');
}
else{
	UIALogger.logFail( buttonName +  ' missing');
}

// click sign in button
UIALogger.logMessage( 'Sign in view' );
window.buttons()['Sign in'].tap()

//target.logElementTree();

buttonName  = 'Sign in'
if(window.buttons()[0].name()=== buttonName){
	UIALogger.logPass('Found ' + buttonName +  ' button');
}
else{
	UIALogger.logFail( buttonName +  ' missing');
}

buttonName  = 'Stop'
if(window.navigationBar().leftButton().name()=== buttonName){
	UIALogger.logPass('Found ' + buttonName +  ' button');
}
else{
	UIALogger.logFail( buttonName +  ' missing');
}

// go back 
window.navigationBar().leftButton().tap()
target.delay(1);

// click sign up button
UIALogger.logMessage( 'Sign up view' );
window.buttons()['Sign up'].tap()


//target.logElementTree();

buttonName  = 'Sign up'
if(window.buttons()[0].name()=== buttonName){
	UIALogger.logPass('Found ' + buttonName +  ' button');
}
else{
	UIALogger.logFail( buttonName +  ' missing');
}

buttonName  = 'Stop'
if(window.navigationBar().leftButton().name()=== buttonName){
	UIALogger.logPass('Found ' + buttonName +  ' button');
}
else{
	UIALogger.logFail( buttonName +  ' missing');
}

// go back
window.navigationBar().leftButton().tap()

