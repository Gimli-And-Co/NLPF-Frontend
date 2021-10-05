// import 'package:flutter/material.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';
// import 'package:nlpf_web_app/ui/app.dart';
// import 'package:nlpf_web_app/ui/components/button.dart';
// import 'package:nlpf_web_app/ui/components/textfield.dart';
// import 'package:nlpf_web_app/utils/constants/color.consts.dart';
// import 'package:nlpf_web_app/utils/helpers/config.helper.dart';
// import 'package:nlpf_web_app/utils/helpers/toast.helper.dart';

// class MapScreen extends StatefulWidget {
//   @override
//   State createState() => MapState();
// }

// class MapState extends State<MapScreen> {
//   MapboxMapController mapController;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final FocusNode _nameControllerFocus = FocusNode();
//   final FocusNode _passwordControllerFocus = FocusNode();
//   final _results = [];
//   final symbols = [];

//   void _onMapCreated(MapboxMapController controller) {
//     mapController = controller;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Builder(
//         builder: (context) => SingleChildScrollView(
//           child: Container(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: <Widget>[
//                     FlutterLogo(
//                       size: 120,
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     _buildUsername(),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     _buildPassword(),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     _buildNextButton(),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//   }

//   Widget _buildUsername() {
//     return TextFormFieldWidget(
//       hintText: "Username",
//       textInputType: TextInputType.text,
//       actionKeyboard: TextInputAction.next,
//       functionValidate: commonValidation,
//       controller: _nameController,
//       focusNode: _nameControllerFocus,
//       onSubmitField: () {
//         // Use this method to change cursor focus
//         // First param - Current Controller
//         // Second param - The Controller you want to focus on the next button press
//         changeFocus(context, _nameControllerFocus, _passwordControllerFocus);
//       },
//       parametersValidate: "Please enter Username.",
//       prefixIcon: Icon(
//           Icons.insert_emoticon), // Don't pass image in case of no prefix Icon
//     );
//   }

//   Widget _buildPassword() {
//     return TextFormFieldWidget(
//       hintText: "Password",
//       obscureText: true,
//       textInputType: TextInputType.visiblePassword,
//       actionKeyboard: TextInputAction.done,
//       functionValidate: commonValidation,
//       controller: _passwordController,
//       focusNode: _passwordControllerFocus,
//       onSubmitField: () {},
//       parametersValidate: "Please enter password.",
//       prefixIcon: Icon(Icons.keyboard_hide),
//     );
//   }

//   Widget _buildNextButton() {
//     return raisedButton(
//         textColor: Colors.white,
//         minWidth: 300,
//         text: "Next",
//         leadingIcon: Icon(Icons.send),
//         height: 50.0,
//         borderRadius: 5,
//         color: COLOR_PRIMARY,
//         borderSideColor: Colors.white,
//         splashColor: Colors.blue[200],
//         style: TextStyle(
//           color: COLOR_PRIMARY,
//           fontSize: 14.0,
//           fontWeight: FontWeight.w500,
//           fontStyle: FontStyle.normal,
//           letterSpacing: 1.2,
//         ),
//         onClick: () {
//           var validate = _formKey.currentState.validate();
//           if (validate) {
//             hideKeyboard();
//             _formKey.currentState.save();
//             ToastsUtils.displayToast("Fields validated...");
//             // Perform operation
//           }
//         });
//   }

//   Widget _buildSnackbarButton(BuildContext context) {
//     return raisedButton(
//         textColor: Colors.white,
//         minWidth: 300,
//         text: "Show Snackbar",
//         height: 50.0,
//         borderRadius: 5,
//         color: COLOR_PRIMARY,
//         borderSideColor: Colors.white,
//         splashColor: Colors.blue[200],
//         style: TextStyle(
//           color: COLOR_PRIMARY,
//           fontSize: 14.0,
//           fontWeight: FontWeight.w500,
//           fontStyle: FontStyle.normal,
//           letterSpacing: 1.2,
//         ),
//         onClick: () {
//           hideKeyboard();
//           Scaffold.of(context)
//               .showSnackBar(ToastsUtils.displaySnackBar("This is Snackbar"));
//         });
//   }

//   void onStyleLoadedCallback() {}

//   hideKeyboard() {
//     FocusScope.of(context).requestFocus(FocusNode());
//   }
// }
