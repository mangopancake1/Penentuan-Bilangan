part of 'pages.dart';

class WellcomePage extends StatefulWidget {
  const WellcomePage({super.key});

  @override
  State<WellcomePage> createState() => _WellcomePageState();
}

class _WellcomePageState extends State<WellcomePage> {
  bool _isHidden = true;
  bool _isHiddenPassword = true;
  bool _isHiddenConfirmPassword = true;

  final String correctUsername = "mobileoke";
  final String correctPassword = "password123";

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  // Cek status login saat aplikasi dimulai
  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn');
    if (isLoggedIn == true) {
      // Jika sudah login, navigasi ke halaman utama
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          children: [
            Image.asset(
              'assets/images/gambar_login.png',
              height: 333,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 15),
            Text(
              "Welcome",
              style: dangerTextStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            Text(
              "Silahkan masukkan \nusername dan password Anda \nuntuk melanjutkan aplikasi",
              style: whiteTextStyle.copyWith(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 51),
            // Button Create Account
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width - 2 * defaultMargin,
              child: ElevatedButton(
                onPressed: () {
                  _showModal(context, isRegister: true);
                },
                child: Text(
                  'Create Account',
                  style: whiteTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            // Button Login
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width - 2 * defaultMargin,
              child: ElevatedButton(
                onPressed: () {
                  _showModal(context, isRegister: false);
                },
                child: Text(
                  'Login',
                  style: whiteTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: secondaryColor,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: secondaryColor, width: 3),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            SizedBox(height: 36),
            Text(
              'Copyright 141-160-165-174 @2025',
              style: whiteTextStyle.copyWith(color: whiteColor, fontSize: 11),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: defaultMargin),
          ],
        ),
      ),
    );
  }

  // Function for login/register
  void _showModal(BuildContext context, {required bool isRegister}) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Wrap(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 25),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Hello it's me...",
                                    style: whiteTextStyle.copyWith(
                                        fontSize: 20, color: blackColor)),
                                Text(isRegister ? "Register" : "Login",
                                    style: whiteTextStyle.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        color: blackColor)),
                              ],
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset(
                                'assets/images/close.png',
                                height: 30,
                                width: 30,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        // Username TextField
                        TextField(
                          controller: usernameController,
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            hintText: "contoh@gmail.com",
                            labelText: "username/email",
                            suffixIcon: InkWell(
                              onTap: _toggleUsernameView,
                              child: Icon(
                                _isHidden
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20),
                        // Password TextField
                        TextField(
                          controller: passwordController,
                          obscureText: _isHiddenPassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            hintText: "password",
                            labelText: "password",
                            suffixIcon: InkWell(
                              onTap: _togglePasswordView,
                              child: Icon(
                                _isHiddenPassword
                                    ? Icons.lock_outline
                                    : Icons.lock_open_outlined,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        // Confirm Password TextField
                        if (isRegister)
                          TextField(
                            obscureText: _isHiddenConfirmPassword,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: "confirm password",
                              labelText: "confirm password",
                              suffixIcon: InkWell(
                                onTap: _toggleConfirmPasswordView,
                                child: Icon(
                                  _isHiddenConfirmPassword
                                      ? Icons.lock_outline
                                      : Icons.lock_open_outlined,
                                ),
                              ),
                            ),
                          ),
                        SizedBox(height: 20),
                        // Button untuk Register/Login
                        Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width -
                              2 * defaultMargin,
                          child: ElevatedButton(
                            onPressed: () {
                              if (isRegister) {
                                // Registration Logic
                                Navigator.pop(context);
                                _showHomePage(context);
                              } else {
                                // Validasi Login
                                if (usernameController.text ==
                                        correctUsername &&
                                    passwordController.text ==
                                        correctPassword) {
                                  // Login berhasil, simpan status login
                                  _saveLoginStatus();
                                  Navigator.pop(context); // Menutup modal
                                  _showHomePage(context);
                                } else {
                                  // Login gagal
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Login Failed'),
                                        content: Text(
                                            'Username atau password salah!'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Menutup dialog
                                            },
                                            child: Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              }
                            },
                            child: Text(
                              isRegister ? 'Register' : 'Login',
                              style: whiteTextStyle.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: secondaryColor,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        // Switch antara Register and Login
                        if (!isRegister)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account? ",
                                  style: whiteTextStyle.copyWith(
                                      color: primaryColor)),
                              Text("Register",
                                  style: whiteTextStyle.copyWith(
                                      color: dangerColor)),
                            ],
                          ),
                        if (isRegister)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account? ",
                                  style: whiteTextStyle.copyWith(
                                      color: primaryColor)),
                              Text("Login",
                                  style: whiteTextStyle.copyWith(
                                      color: dangerColor)),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          });
        });
  }

  // Menyimpan status login ke SharedPreferences
  Future<void> _saveLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
  }

  // Navigation untuk login/register sukses
  void _showHomePage(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/home'); // Ganti ke halaman home
  }

  // Toggle visibility untuk username
  void _toggleUsernameView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  // Toggle visibility untuk password
  void _togglePasswordView() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }

  // Toggle visibility untuk confirm password field
  void _toggleConfirmPasswordView() {
    setState(() {
      _isHiddenConfirmPassword = !_isHiddenConfirmPassword;
    });
  }
}
