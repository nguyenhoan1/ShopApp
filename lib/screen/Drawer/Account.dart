import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shopp/Service/Auth_service.dart';
import 'package:shopp/config/ingredient.dart';
import 'package:shopp/screen/Home/EmptyCart.dart';
import 'package:shopp/screen/Login/login_screen.dart';
import 'package:shopp/screen/Signup/signup_screen.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> with SingleTickerProviderStateMixin {
  final AuthService authService = GetIt.instance<AuthService>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _controller;
  late Animation<Offset> _drawerSlideAnimation;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!authService.isLoggedIn()) {
        _showLoginOrSignUpDialog();
      }
    });

    if (authService.isLoggedIn()) {
      _emailController.text = authService.getUserEmail() ?? '';
      _passwordController.text = authService.getUserPassword() ?? '';
    }

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _drawerSlideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(1.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _handleDrawerClose() {
    _controller.forward().then((_) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      _controller.reverse();
    });
  }

  Future<void> _showLoginOrSignUpDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login or Sign Up'),
          content: Text('Please log in or sign up to access your account.'),
          actions: <Widget>[
            TextButton(
              child: Text('Login'),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
            TextButton(
              child: Text('Sign Up'),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateUserInfo() async {
    if (_formKey.currentState!.validate()) {
      await authService.updateUserEmail(_emailController.text);
      await authService.updateUserPassword(_passwordController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Information updated successfully')),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        titleText: 'Account',
        onMenuPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        onCartPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EmptyCart()),
          );
        },
        showStoreButton: true,
        showShoppingBasketButton: false,
      ),
      drawer: CustomDrawer(
        drawerSlideAnimation: _drawerSlideAnimation,
        onClose: _handleDrawerClose,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                cursorColor: Colors.pinkAccent,
                decoration: const InputDecoration(
                  hintText: "Your email",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(Icons.person, color: Colors.pinkAccent),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: TextFormField(
                  controller: _passwordController,
                  textInputAction: TextInputAction.done,
                  obscureText: _obscurePassword,
                  cursorColor: Colors.pinkAccent,
                  decoration: InputDecoration(
                    hintText: "Your password",
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(Icons.lock, color: Colors.pinkAccent),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    final passwordRegex = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).+$');
                    if (!passwordRegex.hasMatch(value)) {
                      return 'Password must contain both letters and numbers';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateUserInfo,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                ),
                child: Text('Update Information'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
