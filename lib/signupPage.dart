import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tasktwo/loginPage.dart';
import 'package:tasktwo/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'homePage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  // our form key
  final _formKey = GlobalKey<FormState>();

  // editing Controller
  final fullNameController = TextEditingController();

  // final secondNameEditingController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // var _selectedValue;
  // List<String> listOfValue = ['male', 'female'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('sign up'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://cdni.iconscout.com/illustration/premium/thumb/user-account-sign-up-4489360-3723267.png'),
                          fit: BoxFit.cover)),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: fullNameController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{3,}$');
                          if (value!.isEmpty) {
                            return ("First Name cannot be Empty");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter Valid name(Min. 3 Character)");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          fullNameController.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Full name',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.people),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please Enter Your Email");
                          }
                          // reg expression for email validation
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Please Enter a valid email");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          fullNameController.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{6,}$');
                          if (value!.isEmpty) {
                            return ("Password is required for login");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter Valid Password(Min. 6 Character)");
                          }
                        },
                        onSaved: (value) {
                          fullNameController.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      // DropdownButtonFormField(
                      //   decoration: const InputDecoration(
                      //     prefixIcon: Icon(Icons.man),
                      //     border: OutlineInputBorder(),
                      //   ),
                      //   value: _selectedValue,
                      //   hint: const Text(
                      //     'gender',
                      //   ),
                      //   onChanged: (value) {
                      //     setState(() {
                      //       _selectedValue = value;
                      //     });
                      //   },
                      //   onSaved: (value) {
                      //     setState(() {
                      //       _selectedValue = value;
                      //     });
                      //   },
                      //   items: listOfValue.map((String val) {
                      //     return DropdownMenuItem(
                      //       value: val,
                      //       child: Text(
                      //         val,
                      //       ),
                      //     );
                      //   }).toList(),
                      // ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: true,
                        validator: (value) {
                          if (confirmPasswordController.text !=
                              passwordController.text) {
                            return "Password don't match";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          confirmPasswordController.text = value!;
                        },
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: 350,
                        child: ElevatedButton(
                          onPressed: () {
                            signUp(
                                emailController.text, passwordController.text);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const HomePage(),
                            //   ),
                            // );
                          },
                          child: const Text('sign up'),
                        ),
                      ),
                      const SizedBox(height: 20),
                      RichText(
                        text: TextSpan(
                          text: 'have an account ? ',
                          style: const TextStyle(
                              color: Colors.black, fontSize: 15),
                          children: [
                            TextSpan(
                              text: ' login',
                              style: const TextStyle(
                                  color: Colors.blueAccent, fontSize: 15),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          // Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        // Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.fullName = fullNameController.text;
    // userModel.secondName = secondNameEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    // Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
  }
}
