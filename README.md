# Status ANE for iOS Adobe AIR apps #
If you ever wished you had full control over the iOS Statusbar, well, this Adobe AIR Native extension has been built just to do that. You can hide/show the Statusbar at runtime while deciding on the animation type. Moreover, you can change the Style of the Statusbar to make it look good on dark and light backgrounds. And that's not all! The Statusbar ANE will tell you the height of the Statusbar at any given time so you can easily adjust your content according to the possible height changes.

**Main Features**
1. Hide/show the Statusbar and decide on the animation
1. Change the Statusbar Style to fit dark/light backgrounds
1. get the height of the Statusbar so you can adjust your AIR layout with it
1. Listen to size changes at runtime. For example when user is on a phone and using your app.

* [Click here for ASDOC](https://myflashlab.github.io/asdoc/index.html?com/myflashlab/air/extensions/statusbar/package-detail.html)
* [See the ANE setup requirements](https://github.com/myflashlab/Statusbar-ANE/blob/master/src/ANE/extension.xml)

**IMPORTANT:** Implementing ANEs in your AIR projects means you may be required to add some [dependencies](https://github.com/myflashlab/common-dependencies-ANE) or copy some frameworks or editing your app's manifest file. Our ANE setup instruction is designed in a human-readable format but you may still need to familiarize yourself with this format. [Read this post for more information](https://www.myflashlabs.com/understanding-ane-setup-instruction/)

If you think manually setting up ANEs in your projects is confusing or time-consuming, you better check the [ANELAB Software](https://github.com/myflashlab/ANE-LAB/).

[![The ANE-LAB Software](https://www.myflashlabs.com/wp-content/uploads/2017/12/myflashlabs-ANE-LAB_features.jpg)](https://github.com/myflashlab/ANE-LAB/)

# Tech Support #
If you need our professional support to help you with implementing and using the ANE in your project, you can join [MyFlashLabs Club](https://www.myflashlabs.com/product/myflashlabs-club-membership/) or buy a [premium support package](https://www.myflashlabs.com/product/myflashlabs-support/). Otherwise, you may create new issues at this repository and the community might help you.

# Air Usage
```actionscript
import com.myflashlab.air.extensions.statusbar.*;

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
Are you using this ANE in your project? Maybe you'd like to buy us a beer :beer:?

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=payments@myflashlabs.com&lc=US&item_name=Donation+to+Statusbar+ANE&no_note=0&cn=&currency_code=USD&bn=PP-DonationsBF:btn_donateCC_LG.gif:NonHosted)

Add your name to the below list? Donate anything more than $100 and it will be.

## Sponsored by... ##
<table align="left">
    <tr>
        <td align="left"><img src="https://via.placeholder.com/128?text=LOGO" width="60" height="60"></td>
        <td align="left"><a href="#">your_website.com</a><br>Your company motto can be here!</td>
    </tr>
</table>