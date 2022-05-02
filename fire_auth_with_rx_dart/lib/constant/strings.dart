class Strings {
  //common
  static String emailText = "Email";
  static String singUp = "Sign Up";
  static String logIn = "Log In";
  static String logOut = "Log Out";
  static String haveAnAccount = "Already have account ?";
  static String createAccount = "Create an account ?";
  static String create = "Create";
  static String homeString = "Welcome To Home";
  static String password = "password";
  static String camera = "    Camera    ";
  static String gallery = "    Gallery    ";
  static String loading = "loading";
  static String name = "Name : ";
  static String number = "Number : ";

  //pettern
  static String emailPettern = r"^[a-zA-Z0-9,]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static String passwordPettern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

  //email errors
  static String emailEmptyError = 'Please enter your email';
  static String emailInvalidError = 'Please enter valid email';

  //password errors
  static String passEmptyError = 'Please enter your password';
  static String passLengthError = 'Enter minimun 8 char';
  static String passWeekError = 'Enter Strong password';
}
