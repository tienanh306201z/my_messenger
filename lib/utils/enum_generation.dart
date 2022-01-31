enum EmailSignUpResults {
  SignUpCompleted,
  EmailAlreadyExists,
  SignUpNotCompleted,
}

enum EmailSignInResults {
  SignInCompleted,
  EmailOrPasswordInvalid,
  EmailNotVerified,
  UnexpectedError,
}

enum GoogleSignInResults {
  SignInCompleted,
  SignInNotCompleted,
  UnexpectedError,
  AlreadySignedIn,
}

enum FBSignInResults {
  SignInCompleted,
  SignInNotCompleted,
  AlreadySignedIn,
  UnExpectedError,
}
