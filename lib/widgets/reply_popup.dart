// reply_popup.dart
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:wag_wordsaregold/screens/post_detail_screen.dart';
// Importa tu PostDetailScreen para poder navegar a él


void showReplyPopup(
  BuildContext context,
  Map<String, dynamic> post, {
  required Color themeColor,
}) {
  int minUnit = post['peak'].toInt();
  int minDecimal =
      ((post['peak'] - post['peak'].toInt()) * 100).toInt() + 1;

  int selectedUnit = minUnit;
  int selectedDecimal = minDecimal;

  TextEditingController replyController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Write a Reply'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: replyController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'Write your reply...',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        const Text('Unit'),
                        NumberPicker(
                          minValue: minUnit,
                          maxValue: 999,
                          value: selectedUnit,
                          onChanged: (value) {
                            setState(() {
                              selectedUnit = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text('Decimal'),
                        NumberPicker(
                          minValue: selectedUnit == minUnit
                              ? minDecimal
                              : 0,
                          maxValue: 99,
                          value: selectedDecimal,
                          onChanged: (value) {
                            setState(() {
                              selectedDecimal = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (replyController.text.isNotEmpty) {
                    double finalPrice =
                        selectedUnit + (selectedDecimal / 100);

                    // Evita error de lista inmutable:
                    setState(() {
                      final currentReplies = List.from(post['replies']);
                      currentReplies.insert(0, {
                        'author': 'You',
                        'content': replyController.text,
                        'price': finalPrice,
                      });
                      post['replies'] = currentReplies;

                      post['peak'] = finalPrice;
                    });

                    // Cerramos el diálogo
                    Navigator.of(context).pop();

                    // Navegamos a la pantalla de detalle del post
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetailScreen(
                          post: post,
                          themeColor: themeColor,
                          onReply: () {
                            // Si quieres que desde PostDetailScreen
                            // se pueda volver a lanzar este popup:
                            showReplyPopup(
                              context,
                              post,
                              themeColor: themeColor,
                            );
                          },
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeColor,
                ),
                child: Text(
                  'Reply for \$${(selectedUnit + (selectedDecimal / 100)).toStringAsFixed(2)}',
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
