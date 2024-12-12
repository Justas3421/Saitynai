import 'package:flutter/material.dart';
import 'package:landlords_web_app/backend/auth_repository/models/user.dart';
import 'package:landlords_web_app/constants/colors.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  const ProfileScreen({required this.user, super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _emailController;

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.user.username);
    _passwordController = TextEditingController(text: widget.user.password);
    _emailController =
        TextEditingController(text: widget.user.role.stringValue);
    _phoneNumberController =
        TextEditingController(text: widget.user.phoneNumber);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveProfile() {
    setState(() {
      _isEditing = false;
      // Update user data or send it to the backend
    });
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    // Determine responsive sizes
    final bool isTablet =
        ResponsiveBreakpoints.of(context).largerThan(MOBILE) &&
            ResponsiveBreakpoints.of(context).smallerThan(TABLET);
    final bool isMobile = ResponsiveBreakpoints.of(context).equals(MOBILE);

    final avatarRadius = isTablet ? 100.0 : (isMobile ? 80.0 : 120.0);
    final cardPadding = isTablet ? 300.0 : (isMobile ? 8.0 : 16.0);
    final fontSize = isTablet ? 18.0 : (isMobile ? 16.0 : 20.0);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Color.fromARGB(255, 34, 2, 53)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    CircleAvatar(
                      radius: avatarRadius,
                      backgroundImage: const NetworkImage(
                        "https://landlordsdefence.co.uk/wp-content/uploads/2022/07/Landlords-Defence-Expert-Des-Taylor-300x300-1.jpg", // Replace with user's avatar URL
                      ),
                      backgroundColor: Colors.grey[700],
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: EdgeInsets.all(cardPadding),
                      child: Card(
                        color: Colors.grey[900],
                        elevation: 8,
                        margin: EdgeInsets.all(cardPadding),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(cardPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildProfileField(
                                label: 'Username',
                                controller: _usernameController,
                                isEditing: _isEditing,
                                fontSize: fontSize,
                              ),
                              const SizedBox(height: 12),
                              _buildProfileField(
                                label: 'Role',
                                controller: _emailController,
                                isEditing: _isEditing,
                                fontSize: fontSize,
                              ),
                              const SizedBox(height: 12),
                              _buildProfileField(
                                label: 'Password',
                                controller: _passwordController,
                                isEditing: _isEditing,
                                obscureText: true,
                                fontSize: fontSize,
                              ),
                              const SizedBox(height: 12),
                              _buildProfileField(
                                label: 'Phone Number',
                                controller: _phoneNumberController,
                                isEditing: _isEditing,
                                fontSize: fontSize,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _isEditing ? _saveProfile : _toggleEditMode,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _isEditing ? Colors.green : Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        _isEditing ? 'Save' : 'Edit',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileField({
    required String label,
    required TextEditingController controller,
    bool isEditing = false,
    bool obscureText = false,
    required double fontSize,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey,
            fontSize: fontSize - 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        isEditing
            ? TextField(
                controller: controller,
                obscureText: obscureText,
                style: TextStyle(color: Colors.white, fontSize: fontSize),
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber),
                  ),
                ),
              )
            : Text(
                obscureText ? '*' * controller.text.length : controller.text,
                style: TextStyle(
                  color: ColorSeed.darkPrimaryText.color,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                ),
              ),
      ],
    );
  }
}
