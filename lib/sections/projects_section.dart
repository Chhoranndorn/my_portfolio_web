import 'package:flutter/material.dart';
import 'package:my_porfolio_web/util/images.dart';
import 'section_container.dart';
import 'section_header.dart';
import 'package:url_launcher/url_launcher.dart';

class Project {
  final String title;
  final String role;
  final String type;
  final String techStack;
  final String description;
  final String imageUrl;
  final String googlePlayUrl;
  final String appStoreUrl;

  Project({
    required this.title,
    required this.role,
    required this.type,
    required this.techStack,
    required this.description,
    required this.imageUrl,
    required this.googlePlayUrl,
    required this.appStoreUrl,
  });
}

final projects = [
  Project(
    title: 'MVP Mobile',
    role: 'Maintainer',
    type: 'Company Project',
    techStack: 'Flutter, REST API, Firebase',
    description:
        'Developed a marketplace mobile application with three modules: Customer App, Vendor App, and Delivery App.\n'
        'Implemented OTP authentication using Firebase for secure login and user verification.\n'
        'Designed and integrated APIs to connect customers with vendors and manage real-time delivery tracking.\n'
        'Built scalable architecture ensuring smooth performance across Android & iOS.\n'
        'Delivered responsive and user-friendly interfaces for all user roles.',
    imageUrl: Images.mvp,
    googlePlayUrl:
        'https://play.google.com/store/apps/details?id=com.buyandsell.userapp&hl=en',
    appStoreUrl: 'https://apps.apple.com/us/app/mvp-mobile/id6745422234',
  ),
  Project(
    title: 'NPN Auto Car 9999',
    role: 'Maintainer',
    type: 'Company Project',
    techStack: 'Flutter, REST API, Firebase, Plasgate',
    description:
        'Maintained and improved an automobile dealership platform, supporting customer, vendor, and delivery modules.\n'
        'Implemented and optimized OTP authentication using both Firebase and Plasgate SMS service for secure user verification.\n'
        'Collaborated with backend developers to integrate APIs for inventory listings and vendor–customer communication.\n'
        'Fixed bugs and optimized performance across Android and iOS, ensuring smooth cross-platform functionality.',
    imageUrl: Images.npn,
    googlePlayUrl:
        'https://play.google.com/store/apps/details?id=com.npnautocar.userapp&hl=en',
    appStoreUrl: 'https://apps.apple.com/us/app/npn-auto-car-9999/id6740723718',
  ),
  Project(
    title: 'MOL Shop',
    role: 'Maintainer',
    type: 'Company Project',
    techStack: 'Flutter, REST API, Firebase, Provider',
    description:
        'Improved UI/UX and responsive design for a retail e-commerce marketplace.\n'
        'Used Provider state management for scalable architecture.\n'
        'Integrated OTP authentication (Firebase/Plasgate) for secure login.\n'
        'Enhanced error handling to prevent crashes and improve reliability.\n'
        'Worked in Agile sprints, collaborating with the team to deliver features on time.',
    imageUrl: Images.mol,
    googlePlayUrl:
        'https://play.google.com/store/apps/details?id=com.molshopcustomerapp.app&hl=en',
    appStoreUrl: 'https://apps.apple.com/us/app/mol-shop/id6747336152',
  ),
];

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SectionContainer(
      background: theme.colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Projects',
            subtitle: 'A few things I’ve built recently',
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: projects.map((project) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Card(
                  elevation: 2,
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {}, // optional preview
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // if (project.imageUrl.isNotEmpty)
                          //   SizedBox(
                          //     width: double.infinity,
                          //     height: 180,
                          //     child: Image.asset(
                          //       project.imageUrl,
                          //       fit: BoxFit.cover,
                          //     ),
                          //   ),
                          if (project.imageUrl.isNotEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                project.imageUrl,
                                width: double.infinity,
                                fit: BoxFit
                                    .fitWidth, // fit width, height adjusts automatically
                              ),
                            ),

                          const SizedBox(height: 12),
                          Text(
                            '${project.title} – ${project.role} (${project.type})',
                            style: theme.textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Tech Stack: ${project.techStack}',
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(fontStyle: FontStyle.italic),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            project.description,
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              TextButton.icon(
                                onPressed: () async {
                                  final url = Uri.parse(project.googlePlayUrl);
                                  if (!await launchUrl(url)) {
                                    throw 'Could not launch $url';
                                  }
                                },
                                icon: const Icon(Icons.android),
                                label: const Text('Google Play'),
                              ),
                              const SizedBox(width: 12),
                              TextButton.icon(
                                onPressed: () async {
                                  final url = Uri.parse(project.appStoreUrl);
                                  if (!await launchUrl(url)) {
                                    throw 'Could not launch $url';
                                  }
                                },
                                icon: const Icon(Icons.apple),
                                label: const Text('App Store'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
