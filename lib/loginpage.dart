import 'package:covid19/homepage.dart';
import 'package:flutter/material.dart';
import 'apiservice.dart';

class LoginPage extends StatefulWidget {
  // const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Apiservice api = Apiservice();
  String token = "";
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/images/covidimage.png'),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(hintText: 'Username'),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(hintText: 'Password'),
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () async {
                print("Username: " + emailController.text.toString());
                print("Password: " + passwordController.text.toString());
                var username = emailController.text.toString();
                var password = passwordController.text.toString();
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    });
                await loginAction(username, password);
                Navigator.pop(context);
                print("Login token : " + token);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Homepage(),
                    settings: RouteSettings(
                      arguments: token,
                    ),
                  ),
                );
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text('Login'),
                ),
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.code,
                  color: Colors.red,
                  size: 18,
                ),
                Text(
                  "Developed by Ali Husain Sorathiya",
                  style: TextStyle(fontSize: 10),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<bool> loginAction(String username, String password) async {
    await new Future.delayed(const Duration(seconds: 2));
    token = await api.getToken(username, password);
    return true;
  }
}
