import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_post_page.dart';
import 'profile_page.dart';
import 'twit_saya_page.dart'; // Import halaman Twit Saya

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Image.network(
              'https://th.bing.com/th/id/R.d7ad1c3b2f313ab366fa05ed37e4ca6f?rik=Pp5n9HkXwSN5Qg&riu=http%3a%2f%2fclipart-library.com%2fimages_k%2ffeather-transparent-background%2ffeather-transparent-background-6.png&ehk=cHagkdfnm%2fXqnZEs0LuEVgl8Ps23CpkTvtMmEwxJaio%3d&risl=&pid=ImgRaw&r=0',
              height: 24, width: 24,
            ),
            SizedBox(width: 8),
            Text(
              "Maltwit",
              style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Row untuk menyusun tombol bersebelahan dengan jarak lebih sedikit
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AddPostPage()),
                    );
                  },
                  icon: Icon(Icons.add, color: Colors.black),
                  label: Text("Buat Twit", style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(width: 12), // Mengurangi jarak antara tombol
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => TwitSayaPage()), // Navigate to Twit Saya page
                    );
                  },
                  icon: Icon(Icons.account_box, color: Colors.black),
                  label: Text("Twit Saya", style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(width: 12), // Mengurangi jarak antara tombol
                // Tombol Profil Saya menggunakan CircleAvatar
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ProfilePage()), // Navigate to Profile page
                    );
                  },
                  child: CircleAvatar(
                    radius: 20, // Mengatur ukuran avatar
                    backgroundImage: NetworkImage(
                        'https://static.vecteezy.com/system/resources/previews/026/219/403/original/settings-icon-symbol-design-illustration-vector.jpg'), // URL gambar profil yang baru
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                var posts = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    var post = posts[index];
                    return Card(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: ListTile(
                        title: Text(
                          post['title'],
                          style: TextStyle(color: Colors.black),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "@${post['username']} -> ${post['email']}",
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              post['content'],
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
