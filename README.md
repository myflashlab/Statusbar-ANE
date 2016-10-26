# Status ANE V1.0.0 for iOS
If you ever wished you had full control over the iOS Statusbar, well, this Adobe AIR Native extension has been built just to do that. You can hide/show the Statusbar at runtime while deciding on the animation type. Moreover, you can change the Style of the Statusbar to make it look good on dark and light backgrounds. And that's not all! The Statusbar ANE will tell you the height of the Statusbar at any given time so you can easily adjust your content according to the possible height changes.

*Main Features*
1. Hide/show the Statusbar and decide on the animation
2. Change the Statusbar Style to fit dark/light backgrounds
3. get the height of the Statusbar so you can adjust your AIR layout with it
4. Listen to size changes at runtime. For example when user is on a phone and using your app.

# asdoc
[find the latest asdoc for this ANE here.](http://myflashlab.github.io/asdoc/index.html?com/myflashlab/air/extensions/statusbar/package-detail.html)  

**NOTICE**: the demo ANE works only after you hit the "OK" button in the dialog which opens. in your tests make sure that you are NOT calling other ANE methods prior to hitting the "OK" button.
[Download the ANE](https://github.com/myflashlab/Status-ANE/tree/master/FD/lib)

# Air Usage
```actionscript
import com.myflashlab.air.extensions.statusbar.Statusbar;
import com.myflashlab.air.extensions.statusbar.StatusbarEvents;

Statusbar.init();

// listen to Statusbar size changes so you can adjust your AIR content based on it.
Statusbar.listener.addEventListener(StatusbarEvents.FRAME_CHANGED, onStatusbarFrameChanged);

// read the current Statusbar height at any given time
trace(Statusbar.height);

// hide or show the Statusbar while selecting on the animation type
//Statusbar.hideStatusbar(Statusbar.ANIMATION_SLIDE);
//Statusbar.showStatusbar(Statusbar.ANIMATION_FADE);

// change the Statusbar style to make it readable at dark/light backgrounds
Statusbar.changeStatusbarStyle(Statusbar.BAR_STYLE_DEFAULT, true);
Statusbar.changeStatusbarStyle(Statusbar.BAR_STYLE_LIGHT, true);
```

# Air .xml manifest
```xml
<!--
FOR iOS:
-->
	<InfoAdditions>
		
		<!--
			iOS 7.0 or higher can support this ANE
		-->
		<key>MinimumOSVersion</key>
		<string>7.0</string>
		
		<!-- Required by the statusbar.ane -->
		<key>UIViewControllerBasedStatusBarAppearance</key>
		<false/>
		
	</InfoAdditions>
	
	
	
	
	
<!--
Embedding the ANE:
-->
  <extensions>
	
	<extensionID>com.myflashlab.air.extensions.statusbar</extensionID>
	
  </extensions>
-->
```

# Requirements 
1. iOS SDK 7.0 or higher
2. Air SDK 22 or higher

# Commercial Version
http://www.myflashlabs.com/product/statusbar-control-air-native-extension/

![Badge ANE](http://www.myflashlabs.com/wp-content/uploads/2016/10/product_adobe-air-ane-extension-statusbar-595x738.jpg)

# Changelog
*Oct 27, 2016 - V1.0.0*
* beginning of the journey!
