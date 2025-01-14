import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 91, 42, 134),
          ),
        ),
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _currentLogo = 'assets/logo2.png';
  Color _currentColor = Color.fromARGB(255, 188, 148, 36);

  void _toggleTheme() {
    setState(() {
      if (_currentLogo == 'assets/logo2.png') {
        _currentLogo = 'assets/logo.png';
        _currentColor = const Color.fromARGB(255, 91, 42, 134);
      } else {
        _currentLogo = 'assets/logo2.png';
        _currentColor = Color.fromARGB(255, 188, 148, 36);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    _currentLogo,
                    height: 100,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'WAG',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                      color: _currentColor,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Words Are Gold',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[400],
                    ),
                  ),
                  SizedBox(height: 40),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'User',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen(_currentColor)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _currentColor,
                    ),
                    child: Text('Login'),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/google_logo.png',
                            height: 20.0,
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            'Sign in with Google',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.autorenew, size: 30, color: _currentColor),
              onPressed: _toggleTheme,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final Color themeColor;

  HomeScreen(this.themeColor);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> posts = [
    {
      'author': 'John Doe',
      'content': 'Exploring the wonders of AI! #ArtificialIntelligence #Tech',
      'seed': 50.80,
      'peak': 85.99,
      'image': 'assets/imagen1.png',
      'replies': [
        {'author': 'Alice', 'content': 'Absolutely fascinating! The future is bright!', 'price': 85.99},
        {'author': 'Bob', 'content': 'I still have my doubts about AI, but it’s promising.', 'price': 80.50},
        {'author': 'Charlie', 'content': 'Can AI really surpass human creativity?', 'price': 56.00}
      ]
    },
    {
      'author': 'Emma Watson',
      'content': 'Just finished reading "The Great Gatsby". A timeless classic!',
      'seed': 0.75,
      'peak': 1.20,
      'image': 'assets/imagen2.png',
      'replies': []
    },
    {
      'author': 'Mark Zuckerberg',
      'content': 'The future of social media is here. #Innovation #Tech',
      'seed': 1.00,
      'peak': 1.50,
      'image': 'assets/imagen3.png',
      'replies': []
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showReplyPopup(BuildContext context, double replyPrice) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Write a Reply'),
          content: Container(
            height: 150,
            child: Column(
              children: [
                TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Write your reply...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(backgroundColor: widget.themeColor),
              child: Text('Reply for \$${replyPrice.toStringAsFixed(2)}'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          final double replyPrice = post['peak'] + 0.01;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PostDetailScreen(post: post, themeColor: widget.themeColor)),
              );
            },
            child: Card(
              margin: EdgeInsets.all(10),
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
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          post['author'],
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Row(
                          children: [
                            Text(
                              'Seed: \$${post['seed']}',
                              style: TextStyle(color: Colors.green, fontSize: 14),
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Peak: \$${post['peak']}',
                              style: TextStyle(color: Colors.red, fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      post['content'],
                      style: TextStyle(fontSize: 16, color: Colors.grey[300]),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        _showReplyPopup(context, replyPrice);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.themeColor,
                      ),
                      child: Text('Reply for \$${replyPrice.toStringAsFixed(2)}'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: 'My Wallet',
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
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class PostDetailScreen extends StatelessWidget {
  final Map<String, dynamic> post;
  final Color themeColor;

  const PostDetailScreen({required this.post, required this.themeColor});

  @override
  Widget build(BuildContext context) {
    final replies = List<Map<String, dynamic>>.from(post['replies']);
    replies.sort((a, b) => b['price'].compareTo(a['price']));

    return Scaffold(
      appBar: AppBar(
        title: Text(post['author']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              post['image'],
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              post['content'],
              style: TextStyle(fontSize: 18, color: Colors.grey[300]),
            ),
            SizedBox(height: 20),
            Text('Replies:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: replies.length,
                itemBuilder: (context, index) {
                  final reply = replies[index];
                  return Card(
                    margin: EdgeInsets.only(bottom: 10),
                    color: Colors.grey[850],
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reply['author'],
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 5),
                          Text(
                            reply['content'],
                            style: TextStyle(fontSize: 14, color: Colors.grey[300]),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Reply Price: \$${reply['price'].toStringAsFixed(2)}',
                            style: TextStyle(color: themeColor, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
