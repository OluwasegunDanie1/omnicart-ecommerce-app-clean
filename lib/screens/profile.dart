import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:omnicart/constant/app_colors.dart';
import 'package:omnicart/constant/text_style.dart';
import 'package:omnicart/widget/custom_buttons.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    Future<DocumentSnapshot?> getUserByEmail() async {
      final email = FirebaseAuth.instance.currentUser?.email;

      if (email == null) return null;

      final query = await FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: email)
          .limit(1)
          .get();

      if (query.docs.isEmpty) return null;

      return query.docs.first;
    }

    return Scaffold(
      appBar: AppBar(title: Text("My Profile"), centerTitle: true),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getUserByEmail(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            final userDoc = snapshot.data!;
            final data = userDoc.data() as Map<String, dynamic>;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Card(
                    color: Colors.white,

                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Image.asset("images/user.png", width: 100),
                          SizedBox(height: 10),
                          Text(data["name"], style: AppTextStyle.avgmain),
                          SizedBox(height: 10),
                          Text(data["email"], style: AppTextStyle.submain),
                          SizedBox(height: 15),
                          CustomButton(
                            title: "Edit Profile",
                            onPressed: () {},
                            icon: Icons.edit,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ProfileTile(
                  title: 'Order History',
                  icon: Icons.settings_backup_restore_outlined,
                ),
                ProfileTile(
                  title: 'Saved Addresses',
                  icon: Icons.location_on_outlined,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text("Account Settings", style: AppTextStyle.avgmain),
                ),
                ProfileTile(title: 'Privacy', icon: Icons.lock_outline_rounded),
                ProfileTile(
                  title: 'Notification preferences',
                  icon: Icons.notifications_none,
                ),
                ProfileTile(title: 'Security', icon: Icons.settings_outlined),
                ProfileTile(title: 'Linked Accounts', icon: Icons.link_rounded),
                ProfileTile(
                  title: 'Help & support',
                  icon: Icons.help_outline_outlined,
                ),

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: CustomButton(
                    title: "Logout",
                    onPressed: () {},
                    icon: Icons.logout_rounded,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  final String title;
  final IconData icon;
  const ProfileTile({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: Card(
        color: Colors.white,
        child: ListTile(
          leading: Icon(icon, color: AppColors.mainColor, size: 30),
          title: Text(title),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
