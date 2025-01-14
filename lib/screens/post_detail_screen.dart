import 'package:flutter/material.dart';

class PostDetailScreen extends StatelessWidget {
  final Map<String, dynamic> post;
  final Color themeColor;
  final VoidCallback onReply;

  const PostDetailScreen({
    required this.post,
    required this.themeColor,
    required this.onReply,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final replies = List<Map<String, dynamic>>.from(post['replies']);
    // Ordenamos respuestas de mayor precio a menor
    replies.sort((a, b) => b['price'].compareTo(a['price']));

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(post['author']),
            ElevatedButton(
              onPressed: onReply,
              style: ElevatedButton.styleFrom(
                backgroundColor: themeColor,
              ),
              child: Text(
                'Reply for \$${(post['peak'] + 0.01).toStringAsFixed(2)}',
              ),
            ),
          ],
        ),
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
            const SizedBox(height: 10),
            Text(
              post['content'],
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[300],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Replies:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: replies.length,
                itemBuilder: (context, index) {
                  final reply = replies[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    color: Colors.grey[850],
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reply['author'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            reply['content'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[300],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Reply Price: \$${reply['price'].toStringAsFixed(2)}',
                            style: TextStyle(
                              color: themeColor,
                              fontSize: 14,
                            ),
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
