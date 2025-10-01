import 'package:flutter/material.dart';

import 'login_page.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  final List<String> roadmaps = const ["Flutter Basics", "AI Journey", "Web Dev"]; // Example data

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isWideScreen = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isWideScreen ? 500 : double.infinity),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isWideScreen ? 32 : 16,
              vertical: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile section
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: isWideScreen ? 48 : 60,
                      backgroundImage: const AssetImage('assets/default_profile.png'),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Material(
                        elevation: 2,
                        shape: const CircleBorder(),
                        color: theme.colorScheme.primary,
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () {
                            // TODO: Implement image edit functionality
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.edit,
                              color: theme.colorScheme.onPrimary,
                              size: isWideScreen ? 18 : 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Your Name', // TODO: Bind to user name
                  style: theme.textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Short bio or tagline', // TODO: Bind to user bio
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // Add Roadmap button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.add_road),
                    label: const Text('Add Roadmap'),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => LoginDialog(
                          onLogin: (email, password) {
                            // TODO: Add your login logic here
                            Navigator.of(context).pop(); // Close dialog after login attempt
                          },
                          onCancel: () {
                            Navigator.of(context).pop(); // Close dialog on cancel
                          },
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: isWideScreen ? 12 : 16,
                      ),
                      textStyle: theme.textTheme.titleMedium,
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // Roadmaps section
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Your Roadmaps',
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),

                Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: roadmaps.isEmpty
                        ? Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          Icon(Icons.route, size: isWideScreen ? 30 : 34, color: theme.colorScheme.primary),
                          const SizedBox(height: 10),
                          Text(
                            'You haven\'t added any roadmaps yet.',
                            style: theme.textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Tap "Add Roadmap" to share your journey!',
                            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                        : ListView.builder(
                      itemCount: roadmaps.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => ListTile(
                        title: Text(roadmaps[index]),
                        leading: const Icon(Icons.account_tree_outlined),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // TODO: Edit roadmap
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}