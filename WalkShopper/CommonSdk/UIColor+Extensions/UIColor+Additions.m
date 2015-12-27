//
//  UIColorAdditions.m
//  Weibo
//
//  Created by junmin liu on 10-9-30.
//  Copyright 2010 Openlab. All rights reserved.
//

#import "UIColor+Additions.h"



///////////////////////////////////////////////////////////////////////////////////////////////////
// Color algorithms from http://www.cs.rit.edu/~ncs/color/t_convert.html

#define MAX3(a,b,c) (a > b ? (a > c ? a : c) : (b > c ? b : c))
#define MIN3(a,b,c) (a < b ? (a < c ? a : c) : (b < c ? b : c))


///////////////////////////////////////////////////////////////////////////////////////////////////
static void RGBtoHSV(CGFloat r, CGFloat g, CGFloat b, CGFloat* h, CGFloat* s, CGFloat* v) {
	CGFloat min, max, delta;
	min = MIN3(r, g, b);
	max = MAX3(r, g, b);
	*v = max;        // v
	delta = max - min;
	if( max != 0 )
		*s = delta / max;    // s
	else {
		// r = g = b = 0    // s = 0, v is undefined
		*s = 0;
		*h = -1;
		return;
	}
	if( r == max )
		*h = ( g - b ) / delta;    // between yellow & magenta
	else if( g == max )
		*h = 2 + ( b - r ) / delta;  // between cyan & yellow
	else
		*h = 4 + ( r - g ) / delta;  // between magenta & cyan
	*h *= 60;        // degrees
	if( *h < 0 )
		*h += 360;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
static void HSVtoRGB( CGFloat *r, CGFloat *g, CGFloat *b, CGFloat h, CGFloat s, CGFloat v ) {
	int i;
	CGFloat f, p, q, t;
	if( s == 0 ) {
		// achromatic (grey)
		*r = *g = *b = v;
		return;
	}
	h /= 60;      // sector 0 to 5
	i = floor( h );
	f = h - i;      // factorial part of h
	p = v * ( 1 - s );
	q = v * ( 1 - s * f );
	t = v * ( 1 - s * ( 1 - f ) );
	switch( i ) {
		case 0:
			*r = v;
			*g = t;
			*b = p;
			break;
		case 1:
			*r = q;
			*g = v;
			*b = p;
			break;
		case 2:
			*r = p;
			*g = v;
			*b = t;
			break;
		case 3:
			*r = p;
			*g = q;
			*b = v;
			break;
		case 4:
			*r = t;
			*g = p;
			*b = v;
			break;
		default:    // case 5:
			*r = v;
			*g = p;
			*b = q;
			break;
	}
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Additions.
 */
@implementation UIColor (TTCategory)


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (UIColor*)colorWithHue:(CGFloat)h saturation:(CGFloat)s value:(CGFloat)v alpha:(CGFloat)a {
	CGFloat r, g, b;
	HSVtoRGB(&r, &g, &b, h, s, v);
	return [UIColor colorWithRed:r green:g blue:b alpha:a];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIColor*)multiplyHue:(CGFloat)hd saturation:(CGFloat)sd value:(CGFloat)vd {
	const CGFloat* rgba = CGColorGetComponents(self.CGColor);
	CGFloat r = rgba[0];
	CGFloat g = rgba[1];
	CGFloat b = rgba[2];
	CGFloat a = rgba[3];
	
	CGFloat h, s, v;
	RGBtoHSV(r, g, b, &h, &s, &v);
	
	h *= hd;
	v *= vd;
	s *= sd;
	
	HSVtoRGB(&r, &g, &b, h, s, v);
	
	return [UIColor colorWithRed:r green:g blue:b alpha:a];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIColor*)copyWithAlpha:(CGFloat)newAlpha {
	const CGFloat* rgba = CGColorGetComponents(self.CGColor);
	CGFloat r = rgba[0];
	CGFloat g = rgba[1];
	CGFloat b = rgba[2];
	
	return [UIColor colorWithRed:r green:g blue:b alpha:newAlpha];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIColor*)addHue:(CGFloat)hd saturation:(CGFloat)sd value:(CGFloat)vd {
	const CGFloat* rgba = CGColorGetComponents(self.CGColor);
	CGFloat r = rgba[0];
	CGFloat g = rgba[1];
	CGFloat b = rgba[2];
	CGFloat a = rgba[3];
	
	CGFloat h, s, v;
	RGBtoHSV(r, g, b, &h, &s, &v);
	
	h += hd;
	v += vd;
	s += sd;
	
	HSVtoRGB(&r, &g, &b, h, s, v);
	
	return [UIColor colorWithRed:r green:g blue:b alpha:a];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIColor*)highlight {
	return [self multiplyHue:1 saturation:0.4 value:1.2];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIColor*)shadow {
	return [self multiplyHue:1 saturation:0.6 value:0.6];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)hue {
	const CGFloat* rgba = CGColorGetComponents(self.CGColor);
	CGFloat h, s, v;
	RGBtoHSV(rgba[0], rgba[1], rgba[2], &h, &s, &v);
	return h;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)saturation {
	const CGFloat* rgba = CGColorGetComponents(self.CGColor);
	CGFloat h, s, v;
	RGBtoHSV(rgba[0], rgba[1], rgba[2], &h, &s, &v);
	return s;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)value {
	const CGFloat* rgba = CGColorGetComponents(self.CGColor);
	CGFloat h, s, v;
	RGBtoHSV(rgba[0], rgba[1], rgba[2], &h, &s, &v);
	return v;
}


+ (UIColor *)colorWithRGBA:(NSUInteger) rgba
{
    return [UIColor colorWithRed:(rgba >> 24) / 255.0f green:(0xff & ( rgba >> 16)) / 255.0f blue:(0xff & ( rgba >> 8)) / 255.0f alpha:(0xff & rgba) / 255.0f];
}

+ (UIColor *)colorWithRGB:(NSUInteger) rgb
{
    return [UIColor colorWithRed:(rgb >> 16) / 255.0f green:(0xff & ( rgb >> 8)) / 255.0f blue:(0xff & rgb) / 255.0f alpha:1.0];
}

- (CGFloat)red {
    const CGFloat* components = CGColorGetComponents(self.CGColor);
    return components[0];
}

- (CGFloat)green {
    const CGFloat* components = CGColorGetComponents(self.CGColor);
    return components[1];
}

- (CGFloat)blue {
    const CGFloat* components = CGColorGetComponents(self.CGColor);
    return components[2];
}

- (CGFloat)alpha {
    return CGColorGetAlpha(self.CGColor);
}

@end

