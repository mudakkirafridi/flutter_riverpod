import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_course/riverpod/item_provider.dart';

class NotesAddScreen extends ConsumerWidget {
  const NotesAddScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(itemProvider);
    TextEditingController noteController = TextEditingController();

    // Show Update Dialog function
    void _showUpdateDialog(BuildContext context, String id) {
      TextEditingController controller = TextEditingController();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update Value'),
            content: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Enter new value',
                border: OutlineInputBorder(),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  // Close the dialog without saving
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Handle the value here and update the note
                  ref.read(itemProvider.notifier).updateNotes(id, controller.text);
                  Navigator.of(context).pop();
                },
                child: Text('Update'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes App '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // TextFormField for adding new notes
            SizedBox(
                height: 50,
                child: TextFormField(
                  controller: noteController,
                  decoration: InputDecoration(
                    labelText: 'Enter your text',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                )),

            const SizedBox(height: 30),

            // Showing Data List
            item.isEmpty
                ? Center(child: Text('No Data Found'))
                : Expanded(
                    child: ListView.builder(
                        itemCount: item.length,
                        itemBuilder: (context, index) {
                          final itemDetail = item[index];
                          return ListTile(
                            title: Text(itemDetail.name),
                            subtitle: Text(itemDetail.id),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Delete button
                                IconButton(
                                  onPressed: () {
                                    ref
                                        .read(itemProvider.notifier)
                                        .deleteNotes(itemDetail.id);
                                  },
                                  icon: Icon(Icons.delete),
                                ),

                                // Edit button for updating the note
                                IconButton(
                                  onPressed: () {
                                    // Show the update dialog
                                    _showUpdateDialog(context, itemDetail.id);
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (noteController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please Enter Some Text')));
          } else {
            ref.read(itemProvider.notifier).addItem(noteController.text);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
