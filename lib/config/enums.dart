enum AuthType {
  login,
  logOut,

  signup,
  socialMedia,
  completeProfile,
  forgotPassword,
  otpVerify,
  resetPassword,
  addPlatform,
  resendOtp,
  changePassword,
  editProfile
}

enum LocationType {
  loading,
  updated,
  error,
}

enum HomeType { home, coordinates }

enum OtherUserType {
  getProfile,
  report,
  getPlatform,
}

enum Setting { contactUs, deleteAccount, radius, getProfile }

enum SelfProfileDataType {
  hideAll,
  hidePlatform,

  updatePlatform,
  getProfile,
  getPlatform,
  deletePlatform
}
