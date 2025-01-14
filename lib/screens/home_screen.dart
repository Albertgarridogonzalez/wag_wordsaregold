import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:wag_wordsaregold/screens/post_detail_screen.dart';
import 'package:wag_wordsaregold/screens/posts_data.dart';
import 'package:wag_wordsaregold/widgets/reply_popup.dart';
import 'wag_screen.dart';


class HomeScreen extends StatefulWidget {
  final Color themeColor;

  const HomeScreen(this.themeColor, {super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeContentScreen(),
    Center(child: Text("My Wallet Screen")),
    WagScreen(),
    Center(child: Text("Notifications Screen")),
    Center(child: Text("Profile Screen")),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      //  title: const Text('WAG'),
      //),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: 'My Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'WAG',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 188, 148, 36),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeContentScreen extends StatelessWidget {
  const HomeContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostDetailScreen(
                  post: post,
                  themeColor: const Color.fromARGB(255, 188, 148, 36),
                  onReply: () {}, // Aquí tu lógica, si es necesario
                ),
              ),
            );
          },
          child: Card(
            margin: const EdgeInsets.all(10),
            color: Colors.grey[900],
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    post['image'],
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        post['author'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Seed: \$${post['seed']}',
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Peak: \$${post['peak']}',
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    post['content'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[300],
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Llamas a la función que muestra el Popup
                      showReplyPopup(context, post,themeColor: const Color.fromARGB(255, 188, 148, 36), );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  const Color.fromARGB(255, 188, 148, 36),
                    ),
                    child: Text(
                      'Reply for \$${(post['peak'] + 0.01).toStringAsFixed(2)}',
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
