import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:wag_wordsaregold/widgets/reply_popup.dart';
import 'posts_data.dart';
import 'post_detail_screen.dart';

class WagScreen extends StatefulWidget {
  @override
  _WagScreenState createState() => _WagScreenState();
}

class _WagScreenState extends State<WagScreen> {
  int _expandedIndex = -1;

  List<Map<String, dynamic>> getSortedPosts() {
    return List<Map<String, dynamic>>.from(posts)
      ..sort((a, b) {
        final totalA = a['seed'] + a['replies'].fold(0.0, (sum, reply) => sum + reply['price']);
        final totalB = b['seed'] + b['replies'].fold(0.0, (sum, reply) => sum + reply['price']);
        return totalB.compareTo(totalA);
      });
  }

  

  @override
  Widget build(BuildContext context) {
    final sortedPosts = getSortedPosts();

    return Scaffold(
      //appBar: AppBar(
      //  title: const Text('WAG Hall of Fame'),
      //),
      body: ListView.builder(
        itemCount: sortedPosts.length,
        itemBuilder: (context, index) {
          final post = sortedPosts[index];
          final isExpanded = _expandedIndex == index;

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              children: [
                ListTile(
                  leading: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (index == 0)
                        const Icon(Icons.emoji_events, color: Colors.amber, size: 30)
                      else if (index == 1)
                        const Icon(Icons.military_tech, color: Colors.grey, size: 30)
                      else if (index == 2)
                        const Icon(Icons.military_tech, color: Colors.brown, size:30)
                      else
                        Text(
                          '${index + 1}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                    ],
                  ),
                  title: Text(post['author'],
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Seed: \$${post['seed']}',
                        style: const TextStyle(color: Colors.green),
                      ),
                      Text(
                        'Peak: \$${post['peak']}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(isExpanded
                        ? Icons.expand_less
                        : Icons.expand_more),
                    onPressed: () {
                      setState(() {
                        _expandedIndex = isExpanded ? -1 : index;
                      });
                    },
                  ),
                ),
                if (isExpanded)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(post['content'],
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        if (post['replies'] != null && post['replies'].isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Last Reply:',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${post['replies'].last['author']}: ${post['replies'].last['content']} (\$${post['replies'].last['price']})',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PostDetailScreen(
                                      post: post,
                                      themeColor: const Color.fromARGB(255, 188, 148, 36),
                                      onReply: () =>  showReplyPopup(context, post,themeColor: const Color.fromARGB(255, 188, 148, 36)), // o el color que quieras)
                                    ),
                                  ),
                                );
                              },
                              child: const Text('Go to Post'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                 showReplyPopup(context, post,themeColor: const Color.fromARGB(255, 188, 148, 36), );
                              },
                              child: Text('Reply for \$${(post['peak'] + 1).toStringAsFixed(2)}'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
