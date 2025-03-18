import 'package:flutter/material.dart';




// import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: SafeArea(child: Scaffold(body: SignInPage2())),
      debugShowCheckedModeBanner: false,
    ),
  );
}



class SignInPage2 extends StatelessWidget {
  const SignInPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
        body: Center(
            child: isSmallScreen
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      _Logo(),
                      _FormContent(),
                    ],
                  )
                : Container(
                    padding: const EdgeInsets.all(32.0),
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Row(
                      children: const [
                        Expanded(child: _Logo()),
                        Expanded(
                          child: Center(child: _FormContent()),
                        ),
                      ],
                    ),
                  )));
  }
}

class _Logo extends StatelessWidget {
  const _Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset("Images/assets/icon.png"),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Welcome to Flutter!",
            textAlign: TextAlign.center,
            style: isSmallScreen
                ? Theme.of(context).textTheme.headlineLarge
                : Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(color: Colors.black),
          ),
        )
      ],
    );
  }
}

class _FormContent extends StatefulWidget {
  const _FormContent({Key? key}) : super(key: key);

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              validator: (value) {
                // add email validation
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }

                bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value);
                if (!emailValid) {
                  return 'Please enter a valid email';
                }

                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            _gap(),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }

                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  )),
            ),
            _gap(),
            CheckboxListTile(
              value: _rememberMe,
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _rememberMe = value;
                });
              },
              title: const Text('Remember me'),
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              contentPadding: const EdgeInsets.all(0),
            ),
            _gap(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Sign in',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    /// do something
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}



// class MyWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Container(
//       margin: const EdgeInsets.all(20),
//       child: TextButton(onPressed: (){print("hellowordf");}, style: TextButton.styleFrom(
//         foregroundColor: Colors.pink,

//       ), child: Text("text button")),
//     );
//   }
// }

// class MyWidget extends StatelessWidget 
// {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return const Card(
//         color: Colors.red,
//         child: Padding(padding: EdgeInsets.only(right: 10,top: 10,left: 10,bottom: 10), child: Text(
//           'NguyenXuanTienDung',
//           style: TextStyle(
//             fontSize: 20,
//             color: Colors.white
//           ),
//         )) 
//     );
//   }
// }

// class MyWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Text(
//         "nhưng bạn công ty vô cùng vui vẻ hòa đồng,"
//             "nhưng bạn công ty vô cùng vui vẻ hòa đồng,nhưng bạn công ty vô cùng vui vẻ hòa đồng,nhưng bạn công ty vô cùng vui vẻ hòa đồng,nhưng bạn công ty vô cùng vui vẻ hòa đồng,",
//         textDirection: TextDirection.ltr,
//         textAlign: TextAlign.justify,
//         maxLines: 2,
//         overflow: TextOverflow.ellipsis,
//        style: TextStyle(
//         color: Colors.red,
//         fontWeight: FontWeight.w100,
//         fontStyle: FontStyle.italic
//        )
        
//     );
//   }
// }

//
// class MyWidget extends StatefulWidget {
//   final bool loading;
//
//   MyWidget(this.loading);
//
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement build
//     return MyWight2State();
//   }
// }
//
// class MyWight2State extends State<MyWidget> {
//   late bool _localloading;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _localloading = widget.loading;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return _localloading
//         ? CircularProgressIndicator()
//         : FloatingActionButton(onPressed: onClickButton);
//   }
//
//   void onClickButton() {
//     setState(() {
//       _localloading = true;
//     });
//   }
// }
