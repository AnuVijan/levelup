import 'package:flutter/material.dart';
import 'package:levelup/models/profile.dart';
import 'package:levelup/services/profile_service.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  final int growthScore;
  final int streak;
  final int totalTasks;
   

  const ProfileScreen({
    super.key,
    required this.growthScore,
    required this.streak,
    required this.totalTasks,
    
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileService profileService = ProfileService();

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController phoneController =
      TextEditingController();
     
   String imagePath = '';
   final ImagePicker picker = ImagePicker();
  

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    UserProfile profile =
        await profileService.loadProfile();

    setState(() {
      nameController.text = profile.name;
      emailController.text = profile.email;
      phoneController.text = profile.phone;
      imagePath = profile.imagePath;
      
    });
  }
Future<void> pickImage() async {
  

  final XFile? image =
      await picker.pickImage(
    source: ImageSource.gallery,
  );

  if (image != null) {
    setState(() {
      imagePath = image.path;
    });
    await saveProfile();
  }
}
  Future<void> saveProfile() async {
    if (!emailController.text.contains("@")) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Enter valid email"),
        ),
      );
      return;
    }

    if (phoneController.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Enter valid phone number"),
        ),
      );
      return;
    }

    UserProfile profile = UserProfile(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      imagePath: imagePath,
    );

    await profileService.saveProfile(profile);

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Profile Saved"),
      ),
    );
  }

  void showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Profile"),

          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Name",
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: "Phone",
                  ),
                ),
              ],
            ),
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () async {
                await saveProfile();
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        title: const Text("My Profile"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20),
              ),

              child: Padding(
                padding: const EdgeInsets.all(24),

                child: Column(
                  children: [

                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed:
                            showEditProfileDialog,
                      ),
                    ),

                   GestureDetector(
  onTap: pickImage,
  child: CircleAvatar(
    radius: 55,
    backgroundColor: const Color(0xFFE8F5E9),

    backgroundImage:
        imagePath.isNotEmpty
            ? FileImage(File(imagePath))
            : null,

    child: imagePath.isEmpty
        ? const Icon(
            Icons.person,
            size: 60,
            color: Color(0xFF2E7D32),
          )
        : null,
  ),
),

                    const SizedBox(height: 15),

                    Text(
                      nameController.text.isEmpty
                          ? "LevelUp User"
                          : nameController.text,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      emailController.text.isEmpty
                          ? "No Email Added"
                          : emailController.text,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      phoneController.text.isEmpty
                          ? "No Phone Added"
                          : phoneController.text,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20),
              ),

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceAround,

                  children: [

                    Column(
                      children: [
                        Text(
                          "${widget.growthScore}",
                          style:
                              const TextStyle(
                            fontSize: 24,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                        const Text("Growth"),
                      ],
                    ),

                    Column(
                      children: [
                        Text(
                          "${widget.streak}",
                          style:
                              const TextStyle(
                            fontSize: 24,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                        const Text("Streak"),
                      ],
                    ),

                    Column(
                      children: [
                        Text(
                          "${widget.totalTasks}",
                          style:
                              const TextStyle(
                            fontSize: 24,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                        const Text("Tasks"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}