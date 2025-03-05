part of 'helper.dart';

class AppImagesInitialize {
  AppImagesInitialize._();

/*  static assetsImagesInitialize(BuildContext context) {
    precacheImage(const AssetImage(Assets.forgotPassImage), context);
    precacheImage(AssetImage(Assets.setPassImage), context);
    precacheImage(AssetImage(Assets.loginImage), context);
  }*/
}

abstract final class AppString {
  static const String fontFamily = "Rubik";
  static const String fontFamilyUrbanist = "Urbanist";
  static const String appName = "App Name";
  static const String addReason = "App reason";

  static const String localDirectory = "appname";
  static const String addYourPersonalInfo = "Add Your Personal Information";
  static const String createYourUniqueProfile =
      "Create your unique profile to connect with people nearby. Add a profile picture, your name, and a short bio that represents you.";
  static const String continu = "Continue";
  static const String addSocialMedia = "Add Social Media Accounts";
  static const String linkYourSocialMedia =
      "Link your social media accounts to give others a deeper look at who you are. You can control what you share, and make connections on your favorite platforms.";
  static const String refreshAndExplore = "Refresh and Explore People Near You";
  static const String fromRealityToReach = "From Reality to Reach";
  static const String youAreAllSet =
      "You're all set! Hit refresh to discover people around you. Browse profiles, check out their social links, and start connecting!";
  static const String getStarted = "Get Started";
  static const String signUp = "Sign up";

  static const String signIn = "Sign in";
  static const String networkSlow = "Network is slow";

  static const String iHaveAnAccount = "I have an account";
  static const String or = "or";
  static const String signInWithGoogle = "Sign in with Google";
  static const String singInWithFb = "Sign in with Facebook";
  static const String singInWithApple = "Sign in with Apple";
  static const String signInToYourAccount = "Sign in to your\naccount";
  static const String didYouForgotYourPswd = "Did you forgot\nyour password?";
  static const String letSignInToYourAccount = "Let’s sign in to your account";

  static const String letSignUpToYourAccount = "Let’s signup to your account";

  static const String login = "Login";
  static const String forgotPswd = "Forgot Password?";
  static const String orContinueWiths = "or continue with";
  static const String enterYourEmailBelow =
      "Enter your email below to recover your password";
  static const String emailAddress = "Email Address";
  static const String send = "Send";
  static const String enterOneTimePswd = "Enter One Time Password ";
  static const String didntReceicedOtp = "Didn't received the OTP?";
  static const String resendOtp = "Resend OTP";
  static const String submit = "Submit";
  static const String createNewPswd = "Create New Password";
  static const String enterY =
      "Enter your email below to recover your password";
  static const String newPswd = "New password";
  static const String confirmPswd = "Confirm password";
  static const String signUpToYourAccount = "Sign up to your account";
  static const String completeProfile = "Complete Profile";
  static const String uploadImage = "Upload Image ";
  static const String fullName = "Full Name";
  static const String designation = "Designation";
  static const String phoneNumber = "Phone number";
  static const String gender = "Gender";
  static const String dob = "Date of birth";
  static const String next = "Next";
  static const String loginSuccess = "You are logged in successfully";

  static const String formSubmittedSuccess = "Form submitted successfully";

  static const String completeYourProfile = "Please Complete your profile";

  static const String resetPswdSuccessfully = "Password reset successfully";

  static const String platformUpdateSuccess = "Platform added";

  static const String otpVerified = "OTP verified successfully";

  static const String addSocialProfiles = "Add Social Profiles";
  static const String searchHere = "Search here";
  static const String socialMedia = "Social Media";
  static const String welcomeBack = "Welcome Back,";
  static const String unlockNow = "Unlock Now";
  static const String meterAway = "meters away";
  static const String listView = "List View";
  static const String report = "Report";
  static const String theyArePretending =
      "They are pretending to be  someone else";
  static const String noLongerNeed = "I no longer need the account.";
  static const String others = "others";

  static const String fieldCantEmpty = "Field can't be empty";

  static const String notUsingAppAnymore = "I am not using the app anymore.";
  static const String multipleAccountsSoNeedToRemove =
      "I have multiple accounts and want to remove this one";
  static const String createNewAccount =
      "I want to create a new account with a different email/phone number";
  static const String theyAreUnderTheAge = "They are under the age of 10";
  static const String violenceAndDangerous = "Violence & dangerous ";
  static const String hateSpeech = "Hate speech or symbol ";
  static const String nudity = "Nudity or bad content ";
  static const String somethingElse = "Something Else";
  static const String radius = "Radius";
  static const String buyNow = "Buy Now";
  static const String delete = "Delete";

  static const String show = "Show";
  static const String hide = "Hide";

  static const String fetchingLocation = "Fetching your location";
  static const String fetchingData = "Fetching data successfully";
  static const String logoutSuccess = "You are Logged Out";
  static const String editProfile = "Edit Profile Details";
  static const String inviteFriends = "Invite Friends";
  static const String termsAndConditions = "Terms & Conditions";
  static const String contactUs = "Contact Us";
  static const String howItWorks = "How it works";
  static const String updateProfile = "Update your profile info";
  static const String get15points = "Get 5 Credits";
  static const String viewOurPolicies = "View our Policies  ";
  static const String resetYourPswd = "Reset your password";
  static const String reachOutToSupport = "Reach out to our support team";
  static const String checkHowOur = "Check how our organization works";
  static const String deleteAccount = "Delete Account";
  // static const String deleteReason = "Delete Reason";

  static const String deleteYourAccount = "Delete your account";
  static const String logOut = "Logout";
  static const String enterYourCurrentPswd =
      "Enter your current password to delete the account";
  static const String hideProfile = "Hide Profile";
  static const String showProfile = "Show Profile";

  static const String someoneViewed = "Someone viewed your profile";
  static const String checkOutTheirProfile = "Check out their profile.";
  static const String recent = "Recent";
  static const String lastWeek = "Last Week";
  static const String lastMonth = "Last Month";
  static const String vipMembership = "VIP Membership";
  static const String reason = "Reason";
  static const String selectDeleteReason =
      "Why you want to delete your account";

  static const String skip = "Skip >";
  static const String pswd = "Password";
  static const String dontHaveAnAccount = "Don’t have an account?";
  static const String alreadyHaveAnAccount = "Already have an account?";
  static const String and = " and ";
  static const String iAgreeTo = "I agreed to";
  static const String privacyPolicy = "Privacy Policies";
  static const String enterOtp = "Enter otp shared on your email";
  static const String selectCountry = "Select Country";
  static const String enterReferralCode = "Enter referral code";
  static const String mapView = "Map View";
  static const String history = "History";
  static const String notification = "Notifications";
  static const String cancel = "Cancel";
  static const String save = "Save";
  static const String done = "Done";
  static const String copyReferralCode = "Share referral code";
  static const String pleaseEnterOtp = "Enter otp";

  static const String pleaseEnterLink = "Enter link";

  static const String invalidOtp = "Invalid otp please check your opt";
  static const String saveText = "Save";
  static const String subscription = "Subscription ";
  static const String pricePerMonth = "\$19.99/mo";
  static const String settings = "Settings";
  static const String logout = "Logout";
  static const String changePassword = "Change Password";
  static const String currentPassword = "Current Password";
  static const String update = "Update";
  static const String subject = "Subject";
  static const String message = "Message";
  static const String editProfileSetting = "Edit Profile";
  //  static const String socialMedia="Social Media";
  static const String contactInformation = "Contact information";
  static const String portfolio = "Portfolio";
  static const String setRadius = "Set Radius";
  static const String meter = "50 M";
  static const String inviteFriend = "Invite Friend & Earn Points";
  static const String bio = "Bio";
  static const String profileUpdateSuccess = "Profile Updated Successfully ";
  static const String updatePasswordSuccess = " Update Password Successfully ";
  //  static const String localDirectory="Lorem ipsum dolor sit amet consectetur. Semper vel interdum et posuere venenatis.";
  // static const String report = "Report";
  //  static const String localDirectory="appname";
  static const String name = "Name";
  static const String email = "Email";
  static const String noInternetConnection = "No internet connection";
  static const String areYouSureLogOut = "Are you sure you want to \nLogout?";
  static const String areYouSureDelete =
      "Are you sure you want to delete your Account?";

  static const String areYouSurePlatformDelete =
      "Are you sure you want to delete this social profile?";

  static const String areYouSureProfileHide =
      "Are you sure you want to Hide your profile? ";

  static const String areYouSureProfileShow =
      "Are you sure you want to Show your profile? ";

  static const String otpVerifySuccess = "Otp sent successfully";
  static const String acceptTermsAndConditions = "Accept Terms & Conditions";
  static const String signupSuccess = "Signup Success";
  static const String chooseImage = "Change profile image ";
  static const String camera = "Camera";
  static const String radiusUpdateSuccess = "Radius update successfully";

  static const String gallery = "Gallery";
  static const String accountDeleted = "Account deleted";
  static const String uploadfromGallery = "Upload from gallery";
  static const String takeAPhoto = "Take a photo";
  static const String giveReason = "Give reason for deleting the account";
  static const String tellReason =
      "Tell us the reason before deleting the account.";
  //  static const String localDirectory="appname";
  //  static const String localDirectory="appname";
  //  static const String localDirectory="appname";
  //  static const String localDirectory="appname";
  //  static const String localDirectory="appname";
  //  static const String localDirectory="appname";
  //  static const String localDirectory="appname";
  //  static const String localDirectory="appname";
  //  static const String localDirectory="appname";
  //  static const String localDirectory="appname";
  //  static const String localDirectory="appname";
  //  static const String localDirectory="appname";
  //  static const String localDirectory="appname";
  //  static const String localDirectory="appname";
  //  static const String localDirectory="appname";
  //  static const String localDirectory="appname";
  //  static const String localDirectory="appname";
  //  static const String localDirectory="appname";
  //  static const String localDirectory="appname";
  //  static const String localDirectory="appname";

  static const pleaseEnterEmailAddress = 'Enter email address';
  static const pleaseEnterValidEmailAddress = 'Enter valid email address';

  static const pleaseEnterPassword = 'Enter password';
  static const pleaseEnterNewPassword = 'Enter new password';

  static const newPasswordShouldBeDifferent =
      'New password must be different from current password';

  static const pleaseEnterCurrentPassword = 'Enter your current password';
  static const selectReason = 'Select reason';

  static const passwordShouldBe =
      'Password must be at least 8 characters long and include letters, numbers, and special characters.';
  static const newPasswordShouldBe =
      'Password must be at least 8 characters long and include letters, numbers, and special characters.';
  static const passwordMismatch = 'Passwords do not match. Re-enter passwords';
  static const pleaseEnterConfirmPassword = 'Enter confirm password';

  static const String pleaseEnterName = "Enter full name";
  static const String pleaseEnterDob = "Enter your date of birth";
  static const String pleaseEnterDesignation = "Enter your designation";
  static const String pleaseEnterGender = "Enter your gender";
  static const String validNumber = "Enter phone number";
  static const String validPhoneNumber = "Enter a valid phone number";
  static const String pleaseEnterEmail = "Enter your email";
  static const String pleaseEnterSubject = "Enter subject";
  static const String pleaseEnterMessage = "Enter message";

  static List<String> subscriptionDataList = [
    "Ad-free experience",
    "Unlimited profile views",
    "Full-time profile view history",
    "See who viewed your Profile",
  ];

  static List<String> profileUrls = [
    // "1. **Directly from the Profile Page**:",
    // "   - **Facebook**: Go to the profile and check the address bar. It should look like:\n`https://www.facebook.com/username`",
    // "   - **Twitter**: Visit the Twitter profile, and the URL will look like:\n`https://twitter.com/username`",
    // "   - **Instagram**: Check the profile page, and the URL will be:\n`https://www.instagram.com/username/`",
    // "   - **LinkedIn**: Go to the profile, and the URL will look like:\n`https://www.linkedin.com/in/username`\nOr for companies:\n`https://www.linkedin.com/company/companyname`",
    // "   - **TikTok**: Visit the profile, and the URL will be:\n `https://www.tiktok.com/@username`",
    // "   - **YouTube**: On the channel page, the URL will look like: \n`https://www.youtube.com/c/username` \nOr for custom URLs: \n `https://www.youtube.com/user/username`",
    // "2. **For Mobile Apps**:",
    // "   - Open the app (Facebook, Twitter, Instagram, LinkedIn, etc.).",
    // "   - Go to the profile page.",
    // "   - Look for the option to 'Copy Link' or 'Share Profile.'",
    // "3. **Search for the Username**:",
    // "   - **Google Search**: Search using the platform and username, e.g., `username site:twitter.com`.",
    // "   - **Third-Party Tools**: Use sites like [Social Search](https://www.social-search.com/) or [Hunter.io](https://hunter.io/) to find profiles based on name or email.",
    // "4. **Check Profile Settings (If You Have Access)**:",
    // "   - If you have admin or authorized access to a profile, check the profile settings or account settings for the profile URL.",
    // "5. **Use Profile Links Provided by Others**:",
    // "   - Look for social profile links in email signatures, websites, or business cards.",
  ];

  static const List<Map<String, String>> stepsList = [
    {
      "step": "Step 1",
      "msg": "Launch the app or visit the website where your profile is."
    },
    {
      "step": "Step 2",
      "msg":
          "Tap on your profile picture or username to open your profile page."
    },
    {
      "step": "Step 3",
      "msg": "Look for a menu (three dots or share icon) on your profile page."
    },
    {"step": "Step 4", "msg": "Select 'Copy Link' or 'Copy Profile URL.'"},
    {
      "step": "Step 5",
      "msg": "Open NearMii app and go to 'Add Social Profile' screen."
    },
    {
      "step": "Step 6",
      "msg":
          "Click on any social app icon for which you want to add your profile for."
    },
    {
      "step": "Step 7",
      "msg":
          "Tap on the input field, long press, and select 'Paste' to insert your copied profile link."
    },
    {
      "step": "Step 8",
      "msg":
          "Tap the save or confirm button to add the link to your NearMii profile."
    },
  ];
}

abstract final class AuthStrings {
  static const String welcomeTo = "WELCOME TO";
}
