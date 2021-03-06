/*
 * MyFonts Webfont Build ID 364314, 2011-01-29T11:56:23-0500
 * 
 * The fonts listed in this notice are subject to the End User License
 * Agreement(s) entered into by the website owner. All other parties are 
 * explicitly restricted from using the Licensed Webfonts(s).
 * 
 * You may obtain a valid license at the urls below.
 * 
 * Webfont: Ethnocentric
 * Url: http://new.myfonts.com/fonts/larabie/ethnocentric/ethnocentric/
 * Foundry: Larabie
 * Copyright: (c) 1999-2010 Ray Larabie.This font is not freely distributable. See attached license agreement for more information.
 * License: http://www.myfonts.com/viewlicense?1056
 * Licensed pageviews: unlimited/month
 * CSS font-family: EthnocentricRg-Regular
 * CSS font-weight: normal
 * 
 * Webfont: Nasalization
 * Url: http://new.myfonts.com/fonts/typodermic/nasalization/regular/
 * Foundry: Typodermic
 * Copyright: (c) 1999-2010 Typodermic Fonts. This font is not freely distributable. Visit typodermic.com for more info.
 * License: http://www.myfonts.com/viewlicense?1056
 * Licensed pageviews: unlimited/month
 * CSS font-family: NasalizationRg-Regular
 * CSS font-weight: normal
 * 
 * Webfont: New Brilliant
 * Url: http://new.myfonts.com/fonts/larabie/new-brilliant/new-brilliant/
 * Foundry: Larabie
 * Copyright: (c) 1998 Ray Larabie. See attached license agreement for more information. If EULA is missing, visit www.larabiefonts.com for an updated version of this font.
 * License: http://www.myfonts.com/viewlicense?1056
 * Licensed pageviews: unlimited/month
 * CSS font-family: NewBrilliant-Regular
 * CSS font-weight: normal
 * 
 * (c) 2011 Bitstream, Inc
*/



// safari 3.1: data-css
// firefox 3.6+: woff
// firefox 3.5+: data-css
// chrome 4+: data-css
// chrome 6+: woff
// IE 5+: eot
// IE 9: woff
// opera 10.1+: data-css
// mobile safari: svg/data-css
// android: data-css

var browserName, browserVersion, webfontType,  webfontTypeOverride;
 
if (typeof(customPath) == 'undefined')
	var customPath = false;


if (typeof(woffEnabled) == 'undefined')
	var woffEnabled = true;


if (/myfonts_test=on/.test(window.location.search))
	var myfonts_webfont_test = true;

else if (typeof(myfonts_webfont_test) == 'undefined')
	var myfonts_webfont_test = false;


if (customPath)
	var path = customPath;

else {
	var scripts = document.getElementsByTagName("SCRIPT");
	var script = scripts[scripts.length-1].src;

	if (!script.match("://") && script.charAt(0) != '/')
		script = "./"+script;
		
	var path = script.replace(/\\/g,'/').replace(/\/[^\/]*\/?$/, '');
}


if (myfonts_webfont_test)
	document.write('<script type="text/javascript" src="' +path+ '/MyFonts Webfonts Order M2695064_test.js"></script>');


if (/webfont=(woff|ttf|eot)/.test(window.location.search))
{
	webfontTypeOverride = RegExp.$1;

	if (webfontTypeOverride == 'ttf')
		webfontTypeOverride = 'data-css';
}


if (/MSIE (\d+\.\d+)/.test(navigator.userAgent))
{
	browserName = 'MSIE';
	browserVersion = new Number(RegExp.$1);
	if (browserVersion >= 9.0 && woffEnabled)
		webfontType = 'woff';
	else if (browserVersion >= 5.0)
		webfontType = 'eot';
}
else if (/Firefox[\/\s](\d+\.\d+)/.test(navigator.userAgent))
{
	browserName = 'Firefox';
	browserVersion = new Number(RegExp.$1);
	if (browserVersion >= 3.6 && woffEnabled)
		webfontType = 'woff';
	else if (browserVersion >= 3.5)
		webfontType = 'data-css';
}
else if (/Chrome\/(\d+\.\d+)/.test(navigator.userAgent)) // must check before safari
{
	browserName = 'Chrome';
	browserVersion = new Number(RegExp.$1);

	if (browserVersion >= 6.0 && woffEnabled)
		webfontType = 'woff';

	else if (browserVersion >= 4.0)
		webfontType = 'data-css';
}
else if (/Mozilla.*(iPhone|iPad).* OS (\d+)_(\d+).* AppleWebKit.*Safari/.test(navigator.userAgent))
{
		browserName = 'MobileSafari';
		browserVersion = new Number(RegExp.$2) + (new Number(RegExp.$3) / 10)

	if(browserVersion >= 4.2)
		webfontType = 'data-css';

	else
		webfontType = 'svg';
}
else if (/Mozilla.*(iPhone|iPad).*AppleWebKit.*Safari/.test(navigator.userAgent))
{
	browserName = 'MobileSafari';
	webfontType = 'svg';
}
else if (/Safari\/(\d+\.\d+)/.test(navigator.userAgent))
{
	browserName = 'Safari';
	if (/Version\/(\d+\.\d+)/.test(navigator.userAgent))
	{
		browserVersion = new Number(RegExp.$1);
		if (browserVersion >= 3.1)
			webfontType = 'data-css';
	}
}
else if (/Opera\/(\d+\.\d+)/.test(navigator.userAgent))
{
	browserName = 'Opera';
	if (/Version\/(\d+\.\d+)/.test(navigator.userAgent))
	{
		browserVersion = new Number(RegExp.$1);
		if (browserVersion >= 10.1)
			webfontType = 'data-css';
	}
}


if (webfontTypeOverride)
	webfontType = webfontTypeOverride;

switch (webfontType)
{
		case 'eot':
		document.write("<style>\n");
				document.write("@font-face {font-family:\"EthnocentricRg-Regular\";src:url(\"" + path + "/webfonts/eot/style_123205.eot\");}\n");
				document.write("@font-face {font-family:\"NasalizationRg-Regular\";src:url(\"" + path + "/webfonts/eot/style_114780.eot\");}\n");
				document.write("@font-face {font-family:\"NewBrilliant-Regular\";src:url(\"" + path + "/webfonts/eot/style_123295.eot\");}\n");
				document.write("</style>");
		break;
		
		case 'woff':
		document.write("<style>\n");
				document.write("@font-face {font-family:\"EthnocentricRg-Regular\";src:url(\"" + path + "/webfonts/woff/style_123205.woff\") format(\"woff\");}\n");
				document.write("@font-face {font-family:\"NasalizationRg-Regular\";src:url(\"" + path + "/webfonts/woff/style_114780.woff\") format(\"woff\");}\n");
				document.write("@font-face {font-family:\"NewBrilliant-Regular\";src:url(\"" + path + "/webfonts/woff/style_123295.woff\") format(\"woff\");}\n");
				document.write("</style>");
		break;
	
		case 'data-css':
		document.write("<link rel='stylesheet' type='text/css' href='" + path + "/webfonts/datacss/MyFonts Webfonts Order M2695064.css'>");
		break;
	
		case 'svg':
		document.write("<style>\n");
				document.write("@font-face {font-family:\"EthnocentricRg-Regular\";src:url(\"" + path + "/webfonts/svg/style_123205.svg#EthnocentricRg-Regular\") format(\"svg\");}\n");
				document.write("@font-face {font-family:\"NasalizationRg-Regular\";src:url(\"" + path + "/webfonts/svg/style_114780.svg#NasalizationRg-Regular\") format(\"svg\");}\n");
				document.write("@font-face {font-family:\"NewBrilliant-Regular\";src:url(\"" + path + "/webfonts/svg/style_123295.svg#NewBrilliant-Regular\") format(\"svg\");}\n");
				document.write("</style>");
		break;
		
	default:
		break;
}