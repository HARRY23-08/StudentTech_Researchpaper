import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MCC Queue System',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFB71C1C)),
        useMaterial3: true,
      ),
      home: const MainNavigationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// -----------------------------------------------------------------
// MAIN NAVIGATION WRAPPER (Handles Bottom Nav & Routing between screens)
// -----------------------------------------------------------------
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const AppointmentsScreen(),
    const NotificationsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: const Color(0xFFB71C1C),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Appointments'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------
// 1. HOME SCREEN & DASHBOARD
// -----------------------------------------------------------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0E0E0),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: const Color(0xFFB71C1C),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hello, Jhian',
                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Welcome to the Registrar\'s Office',
                    style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Your Queue Number', style: TextStyle(color: Colors.black54, fontSize: 14)),
                                const Text('A-023', style: TextStyle(color: Color(0xFFB71C1C), fontSize: 42, fontWeight: FontWeight.bold, height: 1)),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.timer_outlined, size: 16, color: Colors.black54),
                                    const SizedBox(width: 4),
                                    Text('Estimated Wait: ~ 15 mins', style: TextStyle(color: Colors.black87, fontSize: 12, backgroundColor: const Color(0xFFFFE082).withOpacity(0.5))),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const QueueStatusScreen()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFB71C1C).withOpacity(0.1),
                              foregroundColor: const Color(0xFFB71C1C),
                              elevation: 0,
                            ),
                            child: const Text('Waiting'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildShortcutIcon(context, Icons.book_online, 'Book\nAppointment', const BookAppointmentScreen()),
                          _buildShortcutIcon(context, Icons.qr_code_scanner, 'Get\nQueue Status', const QueueStatusScreen()),
                          _buildShortcutIcon(context, Icons.calendar_today, 'My\nAppointments', const AppointmentsScreen()),
                        ],
                      ),
                      const SizedBox(height: 32),
                      const Text('Available Services', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                      const SizedBox(height: 16),
                      _buildServiceTile(context, Icons.school_outlined, 'Enrollment/Registration'),
                      _buildServiceTile(context, Icons.description_outlined, 'Request for Documents'),
                      _buildServiceTile(context, Icons.folder_shared_outlined, 'Academic Records'),
                      _buildServiceTile(context, Icons.workspace_premium_outlined, 'Graduation & Clearance'),
                      _buildServiceTile(context, Icons.more_horiz, 'Others'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShortcutIcon(BuildContext context, IconData icon, String label, Widget targetScreen) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => targetScreen));
      },
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFB71C1C).withOpacity(0.05),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFB71C1C).withOpacity(0.1)),
              ),
              child: Icon(icon, color: const Color(0xFFB71C1C), size: 30),
            ),
            const SizedBox(height: 10),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, height: 1.2, color: Colors.black87)),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceTile(BuildContext context, IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFFB71C1C)),
        title: Text(title, style: const TextStyle(fontSize: 15)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Colors.black12, width: 1)),
        tileColor: Colors.grey.shade50,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const BookAppointmentScreen()));
        },
      ),
    );
  }
}

// -----------------------------------------------------------------
// 2. BOOK APPOINTMENT SCREEN
// -----------------------------------------------------------------
class BookAppointmentScreen extends StatelessWidget {
  const BookAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Book an Appointment', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFB71C1C),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStepIndicator('1', 'Service', true),
                Container(width: 40, height: 2, color: Colors.grey),
                _buildStepIndicator('2', 'Date & Time', false),
                Container(width: 40, height: 2, color: Colors.grey),
                _buildStepIndicator('3', 'Review', false),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Select Service', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: 'Enrollment / Registration',
              decoration: InputDecoration(filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
              items: ['Enrollment / Registration', 'Request for Documents', 'Academic Records'].map((String value) {
                return DropdownMenuItem<String>(value: value, child: Text(value));
              }).toList(),
              onChanged: (_) {},
            ),
            const SizedBox(height: 20),
            const Text('Select Date', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('February 2027', style: TextStyle(fontWeight: FontWeight.bold)),
                      Icon(Icons.arrow_forward_ios, size: 14),
                    ],
                  ),
                  const Divider(),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Sun', style: TextStyle(color: Colors.grey)),
                      Text('Mon', style: TextStyle(color: Colors.grey)),
                      Text('Tue', style: TextStyle(color: Colors.grey)),
                      Text('Wed', style: TextStyle(color: Colors.grey)),
                      Text('Thu', style: TextStyle(color: Colors.grey)),
                      Text('Fri', style: TextStyle(color: Colors.grey)),
                      Text('Sat', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Table(
                    children: const [
                      TableRow(children: [Text('1'), Text('2'), Text('3'), Text('4'), Text('5'), Text('6'), Text('7')]),
                      TableRow(children: [Text('8'), Text('9'), Text('10'), Text('11'), Text('12'), Text('13'), Text('14')]),
                      TableRow(children: [Text('15'), Text('16'), Text('17'), Text('18'), Text('19'), Text('20'), Text('21')]),
                      TableRow(children: [Text('22'), Text('23'), Text('24'), Text('25'), Text('26'), Text('27'), Text('28')]),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('Select Time', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildTimeSlot('8:00 AM', false),
                const SizedBox(width: 8),
                _buildTimeSlot('9:00 AM', true),
                const SizedBox(width: 8),
                _buildTimeSlot('10:00 AM', false),
              ],
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Appointment Booked Successfully!')));
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB71C1C),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Next', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator(String number, String label, bool isActive) {
    return Column(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: isActive ? const Color(0xFFB71C1C) : Colors.grey.shade300,
          child: Text(number, style: TextStyle(color: isActive ? Colors.white : Colors.black54, fontSize: 12)),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 11, color: isActive ? const Color(0xFFB71C1C) : Colors.grey)),
      ],
    );
  }

  Widget _buildTimeSlot(String time, bool isSelected) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFB71C1C) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isSelected ? const Color(0xFFB71C1C) : Colors.grey.shade300),
        ),
        child: Text(
          time,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------
// 3. QUEUE STATUS SCREEN
// -----------------------------------------------------------------
class QueueStatusScreen extends StatelessWidget {
  const QueueStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB71C1C),
      appBar: AppBar(
        title: const Text('Queue Number', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFB71C1C),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              ),
              child: ListView(
                children: [
                  const Center(
                    child: Column(
                      children: [
                        Text('Your Queue Number', style: TextStyle(color: Colors.grey, fontSize: 14)),
                        SizedBox(height: 4),
                        Text('A-023', style: TextStyle(color: Color(0xFFB71C1C), fontSize: 40, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Service', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 4),
                  DropdownButtonFormField<String>(
                    value: 'Enrollment / Registration',
                    decoration: InputDecoration(filled: true, fillColor: Colors.grey.shade50, border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                    items: ['Enrollment / Registration'].map((String value) {
                      return DropdownMenuItem<String>(value: value, child: Text(value));
                    }).toList(),
                    onChanged: (_) {},
                  ),
                  const SizedBox(height: 16),
                  const Text('Current Counter', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 4),
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(hintText: 'A-02 / Processing', filled: true, fillColor: Colors.grey.shade50, border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                  ),
                  const SizedBox(height: 20),
                  const Text('Queue Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(width: 12, height: 12, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                      const SizedBox(width: 8),
                      const Text('On Queue', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Fixed typo from black8net to black87
                  const Text('Estimated Waiting Time\n- 15mins', style: TextStyle(color: Colors.black87)),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB71C1C),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('View Queue Status Log', style: TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(height: 12),
                  const Center(child: Text('Please be at the waiting area', style: TextStyle(color: Colors.grey, fontSize: 12))),
                  const Divider(height: 30),
                  _buildStatusLogItem('Neil@mcc.edu.ph', 'Completed', Colors.teal, '7:30am Aug 11, 2026'),
                  _buildStatusLogItem('Neil@mcc.edu.ph', 'Called', Colors.green, '7:30am Aug 11, 2026'),
                  _buildStatusLogItem('Neil@mcc.edu.ph', 'Now Serving', Colors.brown, '7:30am Aug 11, 2026'),
                  _buildStatusLogItem('Neil@mcc.edu.ph', 'Waiting', Colors.blue, '7:30am Aug 11, 2026'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusLogItem(String email, String status, Color statusColor, String timestamp) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(Icons.circle_outlined, size: 20, color: Colors.grey),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(email, style: const TextStyle(fontSize: 12, color: Colors.black54)),
                const Text('Counter A-01', style: TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12)),
              Text(timestamp, style: const TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------
// 4. APPOINTMENTS TAB SCREEN
// -----------------------------------------------------------------
class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Appointments', style: TextStyle(color: Colors.white)), backgroundColor: const Color(0xFFB71C1C)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(
            child: ListTile(
              leading: Icon(Icons.event, color: Color(0xFFB71C1C)),
              title: Text('Enrollment Consultation'),
              subtitle: Text('Date: Feb 15, 2027 | 09:00 AM[cite: 3]'),
              trailing: Chip(label: Text('Confirmed', style: TextStyle(color: Colors.white)), backgroundColor: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------
// 5. NOTIFICATIONS SCREEN
// -----------------------------------------------------------------
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB71C1C),
      appBar: AppBar(
        title: const Text('Notification', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFB71C1C),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            ListTile(
              leading: Icon(Icons.description, color: Color(0xFFB71C1C)),
              title: Text('Your queue number A-023 is now being served.', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              subtitle: Text('09:42 AM', style: TextStyle(fontSize: 11)),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.calendar_month, color: Color(0xFFB71C1C)),
              title: Text('Your appointment for Enrollment is confirmed.', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              subtitle: Text('Sept. 16, 2026   09:30 AM[cite: 4]', style: TextStyle(fontSize: 11)),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.notifications_active, color: Color(0xFFB71C1C)),
              title: Text('Reminder: Bring necessary document for your appointment.', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              subtitle: Text('Sept. 12, 2026   10:30 AM[cite: 4]', style: TextStyle(fontSize: 11)),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------
// 6. PROFILE SCREEN
// -----------------------------------------------------------------
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB71C1C),
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFB71C1C),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Center(
              child: Column(
                children: [
                  CircleAvatar(radius: 40, backgroundColor: Color(0xFFB71C1C), child: Icon(Icons.person, size: 40, color: Colors.white)),
                  SizedBox(height: 8),
                  Text('Cunanan Jhian[cite: 5]', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('Student[cite: 5]', style: TextStyle(color: Colors.grey, fontSize: 13)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildProfileField('Student ID', '2023-12345[cite: 5]'),
            _buildProfileField('Program', 'BSIT[cite: 5]'),
            _buildProfileField('Year Level', '3rd Year[cite: 5]'),
            _buildProfileField('Email', 'CUrananmcc@gmail.com[cite: 5]'),
            _buildProfileField('Phone', '+63 245 432 9876[cite: 5]'),
            const Divider(height: 30),
            ListTile(
              leading: const Icon(Icons.lock_outline, color: Color(0xFFB71C1C)),
              title: const Text('Change Password'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.info_outline, color: Color(0xFFB71C1C)),
              title: const Text('Help & Support'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Color(0xFFB71C1C)),
              title: const Text('Log Out'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
          const Divider(),
        ],
      ),
    );
  }
}