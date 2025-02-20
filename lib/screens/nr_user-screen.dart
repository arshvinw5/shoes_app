import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shoes_app/components/skeleton.dart';
import 'package:shoes_app/model/User.dart';
import 'package:shoes_app/providers/dark_theme_provider.dart';
import 'package:shoes_app/screens/user_profile_screen.dart';
import 'package:shoes_app/services/rest_api_service.dart';

class NrUserScreen extends StatefulWidget {
  const NrUserScreen({Key? key}) : super(key: key);

  @override
  _NrUserScreenState createState() => _NrUserScreenState();
}

class _NrUserScreenState extends State<NrUserScreen> {
  final apiService = RestApiService();
  List<User> users = []; // Store users fetched from API
  List<bool> favouriteList = []; // Store favorite states
  List<User> favouriteUserList = [];
  bool isLoading = true; // To manage loading state

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final fetchedUsers = await apiService.getUsers();
    if (mounted) {
      setState(() {
        users = fetchedUsers;
        favouriteList = List.generate(users.length, (index) => false);
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context).getDarkTheme;

    return Scaffold(
      body: RefreshIndicator(
        //this method you need to refress the screen to get the user update
        onRefresh: fetchUsers,
        child: Container(
          color: themeState ? const Color(0xFF000000) : const Color(0xfffef9f3),
          child: isLoading
              ? ListView.builder(
                  itemCount: 20, // Show placeholders while loading
                  itemBuilder: (context, index) =>
                      buildSkeletonItem(themeState),
                )
              : users.isEmpty
                  ? const Center(child: Text('No users found'))
                  : ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return buildUserItem(context, index, themeState);
                      },
                    ),
        ),
      ),
    );
  }

  Widget buildUserItem(BuildContext context, int index, bool themeState) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserProfileScreen(user: users[index]),
          ),
        );
      },
      child: Container(
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
        child: ListTile(
          title: Text(
            '${users[index].firstName} ${users[index].lastName}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(users[index].email ?? ''),
              Text(users[index].address?.city ?? 'City not available'),
            ],
          ),
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
                favouriteList[index] = !favouriteList[index];
                if (favouriteList[index]) {
                  favouriteUserList.add(users[index]);
                } else {
                  favouriteUserList.remove(users[index]);
                }
              });
            },
            icon: favouriteList[index]
                ? const Icon(Icons.favorite, color: Colors.red)
                : const Icon(Icons.favorite_border, color: Colors.red),
          ),
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

//Issues what we have in previous code in screen


///Your issue is likely caused by the fact that you're 
///fetching users inside the FutureBuilder, which runs every time the widget rebuilds. W
///hen you press the favorite button, setState is called, causing a rebuild, which re-triggers t
///he FutureBuilder and fetches the user list again. This results in the UI resetting, 
///and the favorite state getting lost.