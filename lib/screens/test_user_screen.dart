import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shoes_app/components/skeleton.dart';
import 'package:shoes_app/model/User.dart';
import 'package:shoes_app/providers/dark_theme_provider.dart';
import 'package:shoes_app/services/rest_api_service.dart';

class TestUserScreen extends StatefulWidget {
  const TestUserScreen({Key? key}) : super(key: key);

  @override
  _TestUserScreenState createState() => _TestUserScreenState();
}

class _TestUserScreenState extends State<TestUserScreen> {
  final apiService = RestApiService();
  late Future<List<User>> futureUsers;
  List<bool> favouriteList = []; // Local favorite state

  @override
  void initState() {
    super.initState();
    //this is runs once at the beginning of the screen loads then hold the value in futureUsers
    futureUsers = fetchUsers();
  }

  Future<List<User>> fetchUsers() async {
    final users = await apiService.getUsers();
    favouriteList =
        List.generate(users.length, (index) => false); // Initialize favorites
    return users;
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context).getDarkTheme;

    return Scaffold(
      body: FutureBuilder<List<User>>(
        //this is only get the value of futureUsers
        //If you call fetchUsers() directly inside FutureBuilder, i
        //t will fetch data every time the UI rebuilds (e.g., when you press the favorite button).
        //But by using futureUsers, we fetch data only once when the screen loads.

        //need to update the method
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) => buildSkeletonItem(themeState),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading users'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No users found'));
          }

          List<User> users = snapshot.data!;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return buildUserItem(context, index, themeState, users);
            },
          );
        },
      ),
    );
  }

  Widget buildUserItem(
      BuildContext context, int index, bool themeState, List<User> users) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: themeState ? const Color(0xFF121212) : const Color(0xfffef9f3),
          boxShadow: [
            BoxShadow(
              color: themeState ? Colors.grey.shade900 : Colors.grey.shade300,
              blurRadius: 5.0,
              spreadRadius: 1.0,
              offset: const Offset(0, 0),
            )
          ]),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: ListTile(
        title: Text('${users[index].firstName} ${users[index].lastName}'),
        subtitle: Text(users[index].email ?? ''),
        leading: ClipRRect(
          child: Image.network(
            users[index].imageUrl ?? '',
            fit: BoxFit.cover,
            width: 60,
            height: 60,
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            setState(() {
              favouriteList[index] =
                  !favouriteList[index]; // Update favorite state locally
            });
          },
          icon: favouriteList[index]
              ? const Icon(Icons.favorite, color: Colors.red)
              : const Icon(Icons.favorite_border, color: Colors.red),
        ),
      ),
    );
  }

  Widget buildSkeletonItem(bool themeState) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: themeState ? const Color(0xFF121212) : const Color(0xfffef9f3),
        boxShadow: [
          BoxShadow(
            color: themeState ? Colors.grey.shade900 : Colors.grey.shade300,
            blurRadius: 5.0,
            spreadRadius: 1.0,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Shimmer.fromColors(
        baseColor:
            themeState ? const Color(0xfffef9f3) : const Color(0xFF121212),
        highlightColor:
            themeState ? const Color(0xFF121212) : const Color(0xfffef9f3),
        child: ListTile(
          leading: const Skeleton(height: 60.0, width: 60.0),
          title: const Skeleton(height: 10.0),
          subtitle: Align(
            alignment: Alignment.centerLeft,
            child: const SizedBox(width: 200.0, child: Skeleton(height: 10.0)),
          ),
        ),
      ),
    );
  }
}
