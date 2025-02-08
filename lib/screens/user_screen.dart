import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shoes_app/components/skeleton.dart';
import 'package:shoes_app/providers/dark_theme_provider.dart';
import 'package:shoes_app/services/rest_api_service.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final apiService = RestApiService();

  @override
  void initState() {
    super.initState();
    // You might remove this call if you are using FutureBuilder's future.
    apiService.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context).getDarkTheme;

    return Scaffold(
      body: Container(
        color: themeState ? const Color(0xFF000000) : const Color(0xfffef9f3),
        child: FutureBuilder(
          future: apiService.getUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) => Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: themeState
                                ? const Color(0xFF121212)
                                : const Color(0xfffef9f3),
                            boxShadow: [
                              BoxShadow(
                                color: themeState
                                    ? Colors.grey.shade900
                                    : Colors.grey.shade300,
                                blurRadius: 5.0,
                                spreadRadius: 1.0,
                                offset: const Offset(0, 0),
                              )
                            ]),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Shimmer.fromColors(
                          baseColor: themeState
                              ? const Color(0xfffef9f3)
                              : const Color(0xFF121212),
                          highlightColor: themeState
                              ? const Color(0xFF121212)
                              : const Color(0xfffef9f3),
                          child: ListTile(
                            leading: Skeleton(
                              height: 60.0,
                              width: 60.0,
                            ),
                            title: Skeleton(
                              height: 10.0,
                            ),
                            //subtitle has default width that's why can''t use skeleton width.
                            subtitle: Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                width: 200.0,
                                child: Skeleton(
                                  height: 10.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No users found'),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  // Using null-aware operator to provide default empty strings.
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: themeState
                            ? const Color(0xFF121212)
                            : const Color(0xfffef9f3),
                        boxShadow: [
                          BoxShadow(
                            color: themeState
                                ? Colors.grey.shade900
                                : Colors.grey.shade300,
                            blurRadius: 5.0,
                            spreadRadius: 1.0,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      margin:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      child: ListTile(
                          title: Row(
                            children: [
                              Text(
                                snapshot.data?[index].firstName ?? '',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              const SizedBox(width: 5.0),
                              Text(
                                snapshot.data?[index].lastName ?? '',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(snapshot.data?[index].email ?? ''),
                              Text(snapshot.data?[index].address?.city ??
                                  'City not available'),
                            ],
                          ),
                          leading: ClipRRect(
                            child: Image.network(
                              snapshot.data?[index].imageUrl ?? '',
                              fit: BoxFit.cover,
                              width: 60,
                              height: 60,
                            ),
                          )),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}



//  CircularProgressIndicator(
//                   color: Colors.blue.shade900,
//                   backgroundColor: const Color(0xfffef9f3),
//                   strokeWidth: 5.0,
//                 ),