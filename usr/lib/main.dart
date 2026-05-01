import 'package:flutter/material.dart';

void main() {
  runApp(const CapacityBuildingApp());
}

class CapacityBuildingApp extends StatelessWidget {
  const CapacityBuildingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CBC Concept Note',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3A8A), // Deep blue
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const ConceptNoteHome(),
    );
  }
}

class ConceptNoteHome extends StatefulWidget {
  const ConceptNoteHome({super.key});

  @override
  State<ConceptNoteHome> createState() => _ConceptNoteHomeState();
}

class _ConceptNoteHomeState extends State<ConceptNoteHome> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const OverviewPage(),
    const ObjectivesPage(),
    const ActivitiesPage(),
    const OutcomesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      appBar: isDesktop
          ? AppBar(
              title: const Text('Capacity Building Cell Proposal'),
              elevation: 0,
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            )
          : null,
      body: Row(
        children: [
          if (isDesktop)
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.info_outline),
                  selectedIcon: Icon(Icons.info),
                  label: Text('Overview'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.track_changes_outlined),
                  selectedIcon: Icon(Icons.track_changes),
                  label: Text('Objectives'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.local_activity_outlined),
                  selectedIcon: Icon(Icons.local_activity),
                  label: Text('Activities'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.trending_up_outlined),
                  selectedIcon: Icon(Icons.trending_up),
                  label: Text('Outcomes'),
                ),
              ],
            ),
          if (isDesktop) const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _pages[_selectedIndex],
            ),
          ),
        ],
      ),
      bottomNavigationBar: !isDesktop
          ? NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.info_outline),
                  selectedIcon: Icon(Icons.info),
                  label: 'Overview',
                ),
                NavigationDestination(
                  icon: Icon(Icons.track_changes_outlined),
                  selectedIcon: Icon(Icons.track_changes),
                  label: 'Objectives',
                ),
                NavigationDestination(
                  icon: Icon(Icons.local_activity_outlined),
                  selectedIcon: Icon(Icons.local_activity),
                  label: 'Activities',
                ),
                NavigationDestination(
                  icon: Icon(Icons.trending_up_outlined),
                  selectedIcon: Icon(Icons.trending_up),
                  label: 'Outcomes',
                ),
              ],
            )
          : null,
    );
  }
}

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        if (MediaQuery.of(context).size.width <= 800)
          SliverAppBar.large(
            title: const Text('Concept Note'),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Establishment of a Capacity Building Cell (CBC)',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const SizedBox(height: 24),
                _buildSection(
                  context,
                  'Background & Rationale',
                  'The Capacity Building Cell (CBC) is envisioned as a dedicated hub for continuous learning, skill enhancement, and professional development. In an ever-evolving socio-economic and technological landscape, organizations and communities must adapt rapidly. The CBC will bridge the gap between current competencies and future requirements.',
                  Icons.business_center,
                ),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildInfoCard(
                        context,
                        'Our Vision',
                        'To empower individuals and organizations by cultivating a culture of lifelong learning, innovation, and leadership.',
                        Icons.visibility,
                        Theme.of(context).colorScheme.secondaryContainer,
                        Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildInfoCard(
                        context,
                        'Our Mission',
                        'To design, implement, and monitor targeted training programs, mentorship initiatives, and resource-sharing platforms that address specific skill gaps and foster holistic development.',
                        Icons.flag,
                        Theme.of(context).colorScheme.tertiaryContainer,
                        Theme.of(context).colorScheme.onTertiaryContainer,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSection(
      BuildContext context, String title, String content, IconData icon) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              content,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.6,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, String title, String content,
      IconData icon, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: textColor, size: 32),
          const SizedBox(height: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: textColor,
                  height: 1.5,
                ),
          ),
        ],
      ),
    );
  }
}

class ObjectivesPage extends StatelessWidget {
  const ObjectivesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final objectives = [
      {
        'title': 'Skill Assessment & Gap Analysis',
        'desc':
            'Regularly identify the evolving needs of the target demographic to tailor programs effectively.',
        'icon': Icons.analytics,
      },
      {
        'title': 'Professional Development',
        'desc':
            'Offer certified courses, workshops, and seminars focusing on technical, soft, and leadership skills.',
        'icon': Icons.school,
      },
      {
        'title': 'Mentorship & Coaching',
        'desc':
            'Establish a network of industry experts and experienced professionals to guide emerging talent.',
        'icon': Icons.people,
      },
      {
        'title': 'Knowledge Repository',
        'desc':
            'Create an accessible digital library of resources, best practices, and e-learning modules.',
        'icon': Icons.library_books,
      },
      {
        'title': 'Impact Evaluation',
        'desc':
            'Continuously measure the effectiveness of training programs to ensure tangible outcomes.',
        'icon': Icons.query_stats,
      },
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          if (MediaQuery.of(context).size.width <= 800)
            SliverAppBar.large(
              title: const Text('Core Objectives'),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          SliverPadding(
            padding: const EdgeInsets.all(24.0),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Strategic Goals of the CBC',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final obj = objectives[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Card(
                      elevation: 2,
                      shadowColor: Colors.transparent,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          child: Icon(
                            obj['icon'] as IconData,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        ),
                        title: Text(
                          obj['title'] as String,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            obj['desc'] as String,
                            style: const TextStyle(fontSize: 15, height: 1.4),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                childCount: objectives.length,
              ),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 40)),
        ],
      ),
    );
  }
}

class ActivitiesPage extends StatelessWidget {
  const ActivitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = [
      {
        'title': 'Quarterly Bootcamps',
        'desc':
            'Intensive, multi-day training sessions focusing on emerging trends and high-demand technologies.',
        'color': Colors.blue,
        'icon': Icons.flash_on,
      },
      {
        'title': 'Webinar Series',
        'desc':
            'Monthly online sessions with thought leaders, industry veterans, and subject matter experts.',
        'color': Colors.orange,
        'icon': Icons.video_camera_front,
      },
      {
        'title': 'Peer-to-Peer Learning',
        'desc':
            'Structured forums, discussion boards, and working groups to encourage collaborative problem-solving.',
        'color': Colors.green,
        'icon': Icons.forum,
      },
      {
        'title': 'Innovation Grants',
        'desc':
            'Providing resources for participants to apply their newly acquired skills in real-world prototype scenarios.',
        'color': Colors.purple,
        'icon': Icons.lightbulb,
      },
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          if (MediaQuery.of(context).size.width <= 800)
            SliverAppBar.large(
              title: const Text('Key Activities'),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          SliverPadding(
            padding: const EdgeInsets.all(24.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 800 ? 2 : 1,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 2.5,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final act = activities[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.outlineVariant),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: (act['color'] as Color).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            act['icon'] as IconData,
                            color: act['color'] as Color,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                act['title'] as String,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                act['desc'] as String,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(height: 1.4),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: activities.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OutcomesPage extends StatelessWidget {
  const OutcomesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          if (MediaQuery.of(context).size.width <= 800)
            SliverAppBar.large(
              title: const Text('Expected Outcomes'),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          SliverPadding(
            padding: const EdgeInsets.all(24.0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Measuring Our Impact',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  _buildOutcomeItem(
                    context,
                    'Highly Skilled Workforce',
                    'A highly skilled, adaptable, and motivated workforce capable of handling modern challenges.',
                    Icons.check_circle,
                  ),
                  _buildOutcomeItem(
                    context,
                    'Increased Efficiency',
                    'Noticeable improvements in productivity and operational efficiency across all participating departments.',
                    Icons.trending_up,
                  ),
                  _buildOutcomeItem(
                    context,
                    'Leadership Pipeline',
                    'Enhanced leadership pipelines with individuals prepared and ready to take on advanced administrative or technical roles.',
                    Icons.groups,
                  ),
                  _buildOutcomeItem(
                    context,
                    'Sustainable Ecosystem',
                    'Creation of a sustainable ecosystem of continuous improvement, knowledge sharing, and peer support.',
                    Icons.eco,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutcomeItem(
      BuildContext context, String title, String desc, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 40, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  desc,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
