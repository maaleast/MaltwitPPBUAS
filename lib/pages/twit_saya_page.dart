import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uasapp/services/auth_service.dart';
import 'package:uasapp/services/post_service.dart';
import 'update_twit_page.dart'; // Import halaman update twit

class TwitSayaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var currentUserEmail = AuthService.getCurrentUserEmail();

    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black, // Set background color to black
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .where('user.email', isEqualTo: currentUserEmail) // Filter posts by user email
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          var posts = snapshot.data!.docs;
          return ListView.builder(
            itemCount: posts.length + 1, // Add 1 for the "Ini Twit Anda" text
            itemBuilder: (context, index) {
              if (index == 0) {
                // Add "Ini Twit Anda" text at the top
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: Text(
                      "Twit Saya",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }

              var post = posts[index - 1]; // Adjust for the additional text

              return Card(
                color: Colors.white, // Set card background color to white
                margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ListTile(
                  title: Text(post['title'], style: TextStyle(color: Colors.black)), // Set text color to black
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Accessing the nested 'username' field
                      Text("@${post['user']['username']}", style: TextStyle(color: Colors.black)),
                      SizedBox(height: 8.0),
                      Text(post['content'], style: TextStyle(color: Colors.black)),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.black), // Set icon color to black
                            onPressed: () {
                              // Navigate to the update page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => UpdateTwitPage(
                                    postId: post.id,
                                    initialTitle: post['title'],
                                    initialContent: post['content'],
                                  ),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.black), // Set icon color to black
                            onPressed: () async {
                              // Delete the post
                              await PostService.deletePost(post.id);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
