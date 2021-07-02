import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template_app/screens/Designs/designs_screen.dart';
import 'package:template_app/screens/Designs/user_details_in_design_screen.dart';
import 'package:template_app/screens/add_user_details_screen.dart';
import 'package:template_app/screens/user_details.dart';
import 'package:template_app/screens/welcome_screen.dart';
import 'package:template_app/screens/login_screen.dart';
import 'package:template_app/screens/registration_screen.dart';
import 'package:template_app/screens/chat_screen.dart';
import 'package:template_app/screens/ToDoApp/tasks_screen.dart';
import 'package:template_app/screens/add_user_details_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return TaskData();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: ThemeData.dark().copyWith(
        //   textTheme: TextTheme(
        //     bodyText2: TextStyle(color: Colors.black54),
        //   ),
        // ),
        // initialRoute: "welcome_screen", // using "Strings" as a key can cause error or typo
        initialRoute: WelcomeScreen
            .id, // instead of using Strings as id, you can use methods so that you won't have any error
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          ChatScreen.id: (context) => ChatScreen(),
          TasksScreen.id: (context) => TasksScreen(),
          DesignsScreen.id: (context) => DesignsScreen(),
          AddUserDetailsScreen.id : (context) => AddUserDetailsScreen(),
          UserDetails.id : (context) => UserDetails(),
          // UserDetailsInDesignScreen.id : (context) => UserDetailsInDesignScreen(),
        },
        // home: WelcomeScreen(), //you cannot use home property when you have initialRoute property
      ),
    );
  }
}
