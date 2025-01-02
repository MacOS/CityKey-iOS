// Generated by Apple Swift version 5.9 (swiftlang-5.9.0.128.108 clang-1500.0.40.1)
#ifndef TTGSNACKBAR_SWIFT_H
#define TTGSNACKBAR_SWIFT_H
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgcc-compat"

#if !defined(__has_include)
# define __has_include(x) 0
#endif
#if !defined(__has_attribute)
# define __has_attribute(x) 0
#endif
#if !defined(__has_feature)
# define __has_feature(x) 0
#endif
#if !defined(__has_warning)
# define __has_warning(x) 0
#endif

#if __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#if defined(__OBJC__)
#include <Foundation/Foundation.h>
#endif
#if defined(__cplusplus)
#include <cstdint>
#include <cstddef>
#include <cstdbool>
#include <cstring>
#include <stdlib.h>
#include <new>
#include <type_traits>
#else
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>
#include <string.h>
#endif
#if defined(__cplusplus)
#if defined(__arm64e__) && __has_include(<ptrauth.h>)
# include <ptrauth.h>
#else
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wreserved-macro-identifier"
# ifndef __ptrauth_swift_value_witness_function_pointer
#  define __ptrauth_swift_value_witness_function_pointer(x)
# endif
# ifndef __ptrauth_swift_class_method_pointer
#  define __ptrauth_swift_class_method_pointer(x)
# endif
#pragma clang diagnostic pop
#endif
#endif

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus)
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...) 
# endif
#endif
#if !defined(SWIFT_RUNTIME_NAME)
# if __has_attribute(objc_runtime_name)
#  define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
# else
#  define SWIFT_RUNTIME_NAME(X) 
# endif
#endif
#if !defined(SWIFT_COMPILE_NAME)
# if __has_attribute(swift_name)
#  define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
# else
#  define SWIFT_COMPILE_NAME(X) 
# endif
#endif
#if !defined(SWIFT_METHOD_FAMILY)
# if __has_attribute(objc_method_family)
#  define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
# else
#  define SWIFT_METHOD_FAMILY(X) 
# endif
#endif
#if !defined(SWIFT_NOESCAPE)
# if __has_attribute(noescape)
#  define SWIFT_NOESCAPE __attribute__((noescape))
# else
#  define SWIFT_NOESCAPE 
# endif
#endif
#if !defined(SWIFT_RELEASES_ARGUMENT)
# if __has_attribute(ns_consumed)
#  define SWIFT_RELEASES_ARGUMENT __attribute__((ns_consumed))
# else
#  define SWIFT_RELEASES_ARGUMENT 
# endif
#endif
#if !defined(SWIFT_WARN_UNUSED_RESULT)
# if __has_attribute(warn_unused_result)
#  define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
# else
#  define SWIFT_WARN_UNUSED_RESULT 
# endif
#endif
#if !defined(SWIFT_NORETURN)
# if __has_attribute(noreturn)
#  define SWIFT_NORETURN __attribute__((noreturn))
# else
#  define SWIFT_NORETURN 
# endif
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA 
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA 
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA 
#endif
#if !defined(SWIFT_CLASS)
# if __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif
#if !defined(SWIFT_RESILIENT_CLASS)
# if __has_attribute(objc_class_stub)
#  define SWIFT_RESILIENT_CLASS(SWIFT_NAME) SWIFT_CLASS(SWIFT_NAME) __attribute__((objc_class_stub))
#  define SWIFT_RESILIENT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_class_stub)) SWIFT_CLASS_NAMED(SWIFT_NAME)
# else
#  define SWIFT_RESILIENT_CLASS(SWIFT_NAME) SWIFT_CLASS(SWIFT_NAME)
#  define SWIFT_RESILIENT_CLASS_NAMED(SWIFT_NAME) SWIFT_CLASS_NAMED(SWIFT_NAME)
# endif
#endif
#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif
#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER 
# endif
#endif
#if !defined(SWIFT_ENUM_ATTR)
# if __has_attribute(enum_extensibility)
#  define SWIFT_ENUM_ATTR(_extensibility) __attribute__((enum_extensibility(_extensibility)))
# else
#  define SWIFT_ENUM_ATTR(_extensibility) 
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name, _extensibility) enum _name : _type _name; enum SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# if __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) SWIFT_ENUM(_type, _name, _extensibility)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_WEAK_IMPORT)
# define SWIFT_WEAK_IMPORT __attribute__((weak_import))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if !defined(SWIFT_DEPRECATED_OBJC)
# if __has_feature(attribute_diagnose_if_objc)
#  define SWIFT_DEPRECATED_OBJC(Msg) __attribute__((diagnose_if(1, Msg, "warning")))
# else
#  define SWIFT_DEPRECATED_OBJC(Msg) SWIFT_DEPRECATED_MSG(Msg)
# endif
#endif
#if defined(__OBJC__)
#if !defined(IBSegueAction)
# define IBSegueAction 
#endif
#endif
#if !defined(SWIFT_EXTERN)
# if defined(__cplusplus)
#  define SWIFT_EXTERN extern "C"
# else
#  define SWIFT_EXTERN extern
# endif
#endif
#if !defined(SWIFT_CALL)
# define SWIFT_CALL __attribute__((swiftcall))
#endif
#if !defined(SWIFT_INDIRECT_RESULT)
# define SWIFT_INDIRECT_RESULT __attribute__((swift_indirect_result))
#endif
#if !defined(SWIFT_CONTEXT)
# define SWIFT_CONTEXT __attribute__((swift_context))
#endif
#if !defined(SWIFT_ERROR_RESULT)
# define SWIFT_ERROR_RESULT __attribute__((swift_error_result))
#endif
#if defined(__cplusplus)
# define SWIFT_NOEXCEPT noexcept
#else
# define SWIFT_NOEXCEPT 
#endif
#if !defined(SWIFT_C_INLINE_THUNK)
# if __has_attribute(always_inline)
# if __has_attribute(nodebug)
#  define SWIFT_C_INLINE_THUNK inline __attribute__((always_inline)) __attribute__((nodebug))
# else
#  define SWIFT_C_INLINE_THUNK inline __attribute__((always_inline))
# endif
# else
#  define SWIFT_C_INLINE_THUNK inline
# endif
#endif
#if defined(_WIN32)
#if !defined(SWIFT_IMPORT_STDLIB_SYMBOL)
# define SWIFT_IMPORT_STDLIB_SYMBOL __declspec(dllimport)
#endif
#else
#if !defined(SWIFT_IMPORT_STDLIB_SYMBOL)
# define SWIFT_IMPORT_STDLIB_SYMBOL 
#endif
#endif
#if defined(__OBJC__)
#if __has_feature(objc_modules)
#if __has_warning("-Watimport-in-framework-header")
#pragma clang diagnostic ignored "-Watimport-in-framework-header"
#endif
@import CoreFoundation;
@import Foundation;
@import ObjectiveC;
@import UIKit;
#endif

#endif
#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
#if __has_warning("-Wpragma-clang-attribute")
# pragma clang diagnostic ignored "-Wpragma-clang-attribute"
#endif
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnullability"
#pragma clang diagnostic ignored "-Wdollar-in-identifier-extension"

#if __has_attribute(external_source_symbol)
# pragma push_macro("any")
# undef any
# pragma clang attribute push(__attribute__((external_source_symbol(language="Swift", defined_in="TTGSnackbar",generated_declaration))), apply_to=any(function,enum,objc_interface,objc_category,objc_protocol))
# pragma pop_macro("any")
#endif

#if defined(__OBJC__)
enum TTGSnackbarDuration : NSInteger;
enum TTGSnackbarAnimationType : NSInteger;
@class UIColor;
@class TTGSnackbarLabel;
@class NSString;
@class UIFont;
@class UIButton;
@class UIImage;
@class UIImageView;
@class UIActivityIndicatorView;
@class NSCoder;

SWIFT_CLASS("_TtC11TTGSnackbar11TTGSnackbar")
@interface TTGSnackbar : UIView
/// Snackbar default frame
SWIFT_CLASS_PROPERTY(@property (nonatomic, class) CGRect snackbarDefaultFrame;)
+ (CGRect)snackbarDefaultFrame SWIFT_WARN_UNUSED_RESULT;
+ (void)setSnackbarDefaultFrame:(CGRect)value;
/// Snackbar min height
SWIFT_CLASS_PROPERTY(@property (nonatomic, class) CGFloat snackbarMinHeight;)
+ (CGFloat)snackbarMinHeight SWIFT_WARN_UNUSED_RESULT;
+ (void)setSnackbarMinHeight:(CGFloat)value;
/// Tap callback
@property (nonatomic, copy) void (^ _Nullable onTapBlock)(TTGSnackbar * _Nonnull);
/// Swipe callback
@property (nonatomic, copy) void (^ _Nullable onSwipeBlock)(TTGSnackbar * _Nonnull, UISwipeGestureRecognizerDirection);
/// A property to make the snackbar auto dismiss on Swipe Gesture
@property (nonatomic) BOOL shouldDismissOnSwipe;
/// A property to enable left and right margin when using customContentView
@property (nonatomic) BOOL shouldActivateLeftAndRightMarginOnCustomContentView;
/// A property to allow for disabling the use of “Safe Area Layout Guides” on newer OS devices.
/// The purpose of this is to allow the a snackbar to extend under the “Swipe Up for Home” area
/// on iPhone X and newer devices.
@property (nonatomic) BOOL shouldHonorSafeAreaLayoutGuides;
/// Action callback.
@property (nonatomic, copy) void (^ _Nullable actionBlock)(TTGSnackbar * _Nonnull);
/// Second action block
@property (nonatomic, copy) void (^ _Nullable secondActionBlock)(TTGSnackbar * _Nonnull);
/// Dismiss callback.
@property (nonatomic, copy) void (^ _Nullable dismissBlock)(TTGSnackbar * _Nonnull);
/// Snackbar display duration. Default is Short = 1 second.
@property (nonatomic) enum TTGSnackbarDuration duration;
/// Snackbar animation type. Default is SlideFromBottomBackToBottom.
@property (nonatomic) enum TTGSnackbarAnimationType animationType;
/// Show and hide animation duration. Default is 0.3
@property (nonatomic) NSTimeInterval animationDuration;
/// Corner radius: [0, height / 2]. Default is 4
@property (nonatomic) CGFloat cornerRadius;
/// Snackbar max width, default full width
@property (nonatomic) CGFloat snackbarMaxWidth;
/// Border color of snackbar. Default is clear.
@property (nonatomic, strong) UIColor * _Nullable borderColor;
/// Border width of snackbar. Default is 1.
@property (nonatomic) CGFloat borderWidth;
/// Top margin. Default is 4, only work when snackbar is at top
@property (nonatomic) CGFloat topMargin;
/// Bottom margin. Default is 4, only work when snackbar is at bottom
@property (nonatomic) CGFloat bottomMargin;
/// Left margin. Default is 4
@property (nonatomic) CGFloat leftMargin;
/// Right margin. Default is 4
@property (nonatomic) CGFloat rightMargin;
/// Content inset. Default is (0, 4, 0, 4)
@property (nonatomic) UIEdgeInsets contentInset;
/// Label content inset. Default is (0, 0, 0, 0)
@property (nonatomic) UIEdgeInsets messageContentInset;
/// Main text label
@property (nonatomic, readonly, strong) TTGSnackbarLabel * _Null_unspecified messageLabel;
/// Main text shown on the snackbar.
@property (nonatomic, copy) NSString * _Nonnull message;
/// Message text color. Default is white.
@property (nonatomic, strong) UIColor * _Nonnull messageTextColor;
/// Message text font. Default is Bold system font (14).
@property (nonatomic, strong) UIFont * _Nonnull messageTextFont;
/// Message text alignment. Default is left
@property (nonatomic) NSTextAlignment messageTextAlign;
/// Action button
@property (nonatomic, readonly, strong) UIButton * _Null_unspecified actionButton;
/// Action button title.
@property (nonatomic, copy) NSString * _Nonnull actionText;
/// Action button image.
@property (nonatomic, strong) UIImage * _Nullable actionIcon;
/// Second action button
@property (nonatomic, readonly, strong) UIButton * _Null_unspecified secondActionButton;
/// Second action button title.
@property (nonatomic, copy) NSString * _Nonnull secondActionText;
/// Second action button image.
@property (nonatomic, strong) UIImage * _Nullable secondActionIcon;
/// Action button title color. Default is white.
@property (nonatomic, strong) UIColor * _Nonnull actionTextColor;
/// Second action button title color. Default is white.
@property (nonatomic, strong) UIColor * _Nonnull secondActionTextColor;
/// Action text font. Default is Bold system font (14).
@property (nonatomic, strong) UIFont * _Nonnull actionTextFont;
/// Second action text font. Default is Bold system font (14).
@property (nonatomic, strong) UIFont * _Nonnull secondActionTextFont;
/// All action button max width, min = 44
@property (nonatomic) CGFloat actionMaxWidth;
/// All action button text number of lines. Default is 1
@property (nonatomic) NSInteger actionTextNumberOfLines;
/// Icon imageView
@property (nonatomic, readonly, strong) UIImageView * _Null_unspecified iconImageView;
/// Icon image
@property (nonatomic, strong) UIImage * _Nullable icon;
/// Icon image content
@property (nonatomic) UIViewContentMode iconContentMode;
/// Icon background color. Default is clear.
@property (nonatomic, strong) UIColor * _Nullable iconBackgroundColor;
/// Icon tint color
@property (nonatomic, strong) UIColor * _Null_unspecified iconTintColor;
/// Icon width
@property (nonatomic) CGFloat iconImageViewWidth;
/// Custom container view
@property (nonatomic, strong) UIView * _Nullable containerView;
/// Custom content view
@property (nonatomic, strong) UIView * _Nullable customContentView;
/// SeparateView background color
@property (nonatomic, strong) UIColor * _Nonnull separateViewBackgroundColor;
/// ActivityIndicatorView
@property (nonatomic, readonly, strong) UIActivityIndicatorView * _Null_unspecified activityIndicatorView;
/// ActivityIndicatorViewStyle
@property (nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;
/// ActivityIndicatorView color
@property (nonatomic, strong) UIColor * _Nonnull activityIndicatorViewColor;
/// Animation SpringWithDamping. Default is 0.7
@property (nonatomic) CGFloat animationSpringWithDamping;
/// Animation initialSpringVelocity. Default is 5
@property (nonatomic) CGFloat animationInitialSpringVelocity;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
/// Default init
///
/// returns:
/// TTGSnackbar instance
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
/// Show a single message like a Toast.
/// \param message Message text.
///
/// \param duration Duration type.
///
///
/// returns:
/// TTGSnackbar instance
- (nonnull instancetype)initWithMessage:(NSString * _Nonnull)message duration:(enum TTGSnackbarDuration)duration OBJC_DESIGNATED_INITIALIZER;
- (void)layoutSubviews;
@end





@interface TTGSnackbar (SWIFT_EXTENSION(TTGSnackbar))
/// Show the snackbar.
- (void)show;
@end


@interface TTGSnackbar (SWIFT_EXTENSION(TTGSnackbar))
/// Dismiss the snackbar manually.
- (void)dismiss;
@end


/// Snackbar animation types.
/// <ul>
///   <li>
///     fadeInFadeOut:               Fade in to show and fade out to dismiss.
///   </li>
///   <li>
///     slideFromBottomToTop:        Slide from the bottom of screen to show and slide up to dismiss.
///   </li>
///   <li>
///     slideFromBottomBackToBottom: Slide from the bottom of screen to show and slide back to bottom to dismiss.
///   </li>
///   <li>
///     slideFromLeftToRight:        Slide from the left to show and slide to rigth to dismiss.
///   </li>
///   <li>
///     slideFromRightToLeft:        Slide from the right to show and slide to left to dismiss.
///   </li>
///   <li>
///     slideFromTopToBottom:        Slide from the top of screen to show and slide down to dismiss.
///   </li>
///   <li>
///     slideFromTopBackToTop:       Slide from the top of screen to show and slide back to top to dismiss.
///   </li>
/// </ul>
typedef SWIFT_ENUM(NSInteger, TTGSnackbarAnimationType, closed) {
  TTGSnackbarAnimationTypeFadeInFadeOut = 0,
  TTGSnackbarAnimationTypeSlideFromBottomToTop = 1,
  TTGSnackbarAnimationTypeSlideFromBottomBackToBottom = 2,
  TTGSnackbarAnimationTypeSlideFromLeftToRight = 3,
  TTGSnackbarAnimationTypeSlideFromRightToLeft = 4,
  TTGSnackbarAnimationTypeSlideFromTopToBottom = 5,
  TTGSnackbarAnimationTypeSlideFromTopBackToTop = 6,
};

/// Snackbar display duration types.
/// <ul>
///   <li>
///     short:   1 second
///   </li>
///   <li>
///     middle:  3 seconds
///   </li>
///   <li>
///     long:    5 seconds
///   </li>
///   <li>
///     forever: Not dismiss automatically. Must be dismissed manually.
///   </li>
/// </ul>
typedef SWIFT_ENUM(NSInteger, TTGSnackbarDuration, closed) {
  TTGSnackbarDurationShort = 1,
  TTGSnackbarDurationMiddle = 3,
  TTGSnackbarDurationLong = 5,
  TTGSnackbarDurationForever = 2147483647,
};


SWIFT_CLASS("_TtC11TTGSnackbar16TTGSnackbarLabel")
@interface TTGSnackbarLabel : UILabel
@property (nonatomic) UIEdgeInsets contentInset;
- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines SWIFT_WARN_UNUSED_RESULT;
- (void)drawTextInRect:(CGRect)rect;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)coder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC11TTGSnackbar18TTGSnackbarManager")
@interface TTGSnackbarManager : NSObject
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) TTGSnackbarManager * _Nonnull shared;)
+ (TTGSnackbarManager * _Nonnull)shared SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
/// Shows and queues for showing (if necesarrry) passed snackbars
- (void)showSnackbar:(TTGSnackbar * _Nonnull)snackbar;
@end


@interface UIColor (SWIFT_EXTENSION(TTGSnackbar))
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) UIColor * _Nonnull ttgDefaultText;)
+ (UIColor * _Nonnull)ttgDefaultText SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) UIColor * _Nonnull ttgDefaultBackground;)
+ (UIColor * _Nonnull)ttgDefaultBackground SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) UIColor * _Nonnull ttgDefaultShadow;)
+ (UIColor * _Nonnull)ttgDefaultShadow SWIFT_WARN_UNUSED_RESULT;
@end

#endif
#if __has_attribute(external_source_symbol)
# pragma clang attribute pop
#endif
#if defined(__cplusplus)
#endif
#pragma clang diagnostic pop
#endif
