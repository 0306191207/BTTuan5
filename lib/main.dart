import 'dart:async';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SignInRoute(),
        '/Error': (context) => ErrorRoute(),
        '/Wait': (context) => WaitRoute(),
      },
    );
  }
}

class SignInRoute extends StatelessWidget {
  const SignInRoute({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _controllerEmail = TextEditingController();
    final _controllerPassword = TextEditingController();

    Widget title = Container(
        margin: EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: Image.asset(
                'images/email.png',
                fit: BoxFit.cover,
              ),
              padding: const EdgeInsets.all(20),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20, bottom: 5),
              child: const Text(
                'SingIn',
                style: TextStyle(color: Colors.white, fontSize: 50),
              ),
            ),
            const Text(
              'Speak, friend, and enter',
              style: TextStyle(color: Colors.black),
            )
          ],
        ));

    Widget inputBox = Container(
        margin: EdgeInsets.only(top: 50),
        padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: TextField(
                  controller: _controllerEmail,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.email),
                      enabledBorder: InputBorder.none,
                      border: OutlineInputBorder(),
                      hintText: 'Email')),
            ),
            Container(
                margin: const EdgeInsets.only(top: 10),
                color: Colors.white,
                child: TextField(
                  obscureText: true,
                  controller: _controllerPassword,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.password),
                      enabledBorder: InputBorder.none,
                      hintText: 'Password'),
                )),
          ],
        ));

    Widget signInButton = Container(
      margin: EdgeInsets.only(bottom: 30, top: 50),
      padding: const EdgeInsets.only(left: 20, right: 20),
      height: 40,
      width: double.infinity,
      child: OutlinedButton(
          onPressed: () {
            if (_controllerPassword.text == _controllerEmail.text) {
              Navigator.pushNamed(context, '/Wait');
              return;
            }
            Navigator.pushNamed(context, '/Error');
          },
          child: const Text(
            'SIGN IN',
            style: TextStyle(color: Colors.white),
          ),
          style: OutlinedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero))),
    );

    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [title, inputBox, signInButton],
      ),
    );
  }
}

class ErrorRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget error = Container(
      margin: EdgeInsets.only(top: 50),
      child: Column(
        children: [
          Image.asset(
            'images/false.png',
            fit: BoxFit.cover,
          ),
          Container(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: const Text(
                "UPS... couldn't Sign In",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          const Text("Your email and password don't match"),
          const Text('Please, try again')
        ],
      ),
    );

    Widget tryAgainButton = Container(
      margin: EdgeInsets.only(bottom: 30),
      padding: EdgeInsets.only(left: 20, right: 20),
      height: 40,
      width: double.infinity,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: const RoundedRectangleBorder(side: BorderSide.none)),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Try again',
            style: TextStyle(color: Colors.white),
          )),
    );

    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [error, tryAgainButton],
      ),
    ));
  }
}

class WaitRoute extends StatefulWidget {
  @override
  State<WaitRoute> createState() => _WaitRouteState();
}

class _WaitRouteState extends State<WaitRoute> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => ShowEmailRoute()));
    });
  }

  @override
  Widget build(BuildContext contex) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: Image.asset(
                    'images/email.png',
                    fit: BoxFit.cover,
                  ),
                  padding: const EdgeInsets.all(20),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 5),
                  child: const Text(
                    'SingIn',
                    style: TextStyle(color: Colors.white, fontSize: 50),
                  ),
                ),
                const Text(
                  'Speak, friend, and enter',
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
            const CircularProgressIndicator(
              color: Colors.white,
            )
          ])),
    );
  }
}

class ShowEmailRoute extends StatefulWidget {
  @override
  State<ShowEmailRoute> createState() => _ShowEmailRouteState();
}

class _ShowEmailRouteState extends State<ShowEmailRoute> {
  List<String> listmailboxes = [
    'All inboxes',
    'Icloud',
    'Hotmail',
    'Gmail',
    'VIP'
  ];
  List<String> listSpecial = [
    'Secure',
    'Notification',
  ];
  int count = 1;
  var isCheckedMailboxes;
  var isCheckedSpecial;

  @override
  void initState() {
    super.initState();
    isCheckedMailboxes = List<bool>.filled(listmailboxes.length, false);
    isCheckedSpecial = List<bool>.filled(listSpecial.length, false);
  }

  @override
  Widget build(BuildContext context) {
    Widget title = Container(
      height: 50,
      color: Colors.blueGrey[100],
      child: Row(
        children: [
          const Expanded(
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Mailboxes',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ))),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Done',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );

    Widget mailboxes = Container(
      color: Colors.grey[200],
      height: 50,
      padding: const EdgeInsets.only(left: 10),
      child: const Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          'Mailboxes',
          style: TextStyle(color: Colors.black54),
        ),
      ),
    );

    Widget specialFolder = Container(
      color: Colors.grey[200],
      height: 50,
      padding: const EdgeInsets.only(left: 10),
      child: const Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          'Special folders',
          style: TextStyle(color: Colors.black54),
        ),
      ),
    );

    Widget listMailboxes = Expanded(
        child: ListView.builder(
            itemCount: listmailboxes.length,
            itemBuilder: (context, index) {
              return Card(
                child: Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: isCheckedMailboxes[index],
                      onChanged: (bool? value) {
                        setState(() {
                          isCheckedMailboxes[index] = value!;
                        });
                      },
                    ),
                    Expanded(
                        child: ListTile(
                      leading: const Icon(Icons.mail_outline),
                      title: Text(listmailboxes[index]),
                      trailing: Text(count.toString()),
                    ))
                  ],
                ),
              );
            }));

    Widget listSpecialFolders = Expanded(
        child: ListView.builder(
            itemCount: listSpecial.length,
            itemBuilder: (context, index) {
              return Card(
                child: Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: isCheckedSpecial[index],
                      onChanged: (bool? value) {
                        setState(() {
                          isCheckedSpecial[index] = value!;
                        });
                      },
                    ),
                    Expanded(
                        child: ListTile(
                      leading: const Icon(Icons.mail_outline),
                      title: Text(listSpecial[index]),
                      trailing: Text(count.toString()),
                    ))
                  ],
                ),
              );
            }));

    return Scaffold(
        body: Column(children: [
          title,
          mailboxes,
          listMailboxes,
          specialFolder,
          listSpecialFolders
        ]),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Delete'),
              IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  for (var item in isCheckedSpecial) {
                    if (item) {
                      setState(() {});
                    }
                  }
                },
              ),
            ],
          ),
        ));
  }
}
