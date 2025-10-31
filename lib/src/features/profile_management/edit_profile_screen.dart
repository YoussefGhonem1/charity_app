import 'package:flutter/material.dart';
import 'package:charity/src/shared/theme/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../shared/state/profile_service.dart';
import 'data/profile_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
<<<<<<< HEAD
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  String? _avatarPath;

  @override
  void initState() {
    super.initState();
    final p = ProfileService.instance.profile.value;
    final accountEmail = FirebaseAuth.instance.currentUser?.email ?? '';
    _nameController = TextEditingController(text: p.name);
    _emailController = TextEditingController(
      text: accountEmail.isNotEmpty ? accountEmail : p.email,
    );
    _phoneController = TextEditingController(text: p.phone);
    _avatarPath = p.avatarPathOrUrl;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final xfile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 75);
    if (xfile != null) {
      setState(() {
        _avatarPath = xfile.path;
      });
    }
  }
=======
  final TextEditingController _nameController = TextEditingController(text: 'Mr Hegazy' );
  final TextEditingController _emailController = TextEditingController(text: 'hegazy@example.com');
  final TextEditingController _phoneController = TextEditingController(text: '+201234567890');
>>>>>>> develop

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: _onSave,
            child: Text(
              'Save',
              style: TextStyle(color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundImage: _avatarPath == null
                          ? null
                          : (_avatarPath!.startsWith('http')
                              ? NetworkImage(_avatarPath!) as ImageProvider
                              : FileImage(File(_avatarPath!))),
                      child: _avatarPath == null
                          ? const Icon(Icons.person, size: 48)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: _pickImage,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full name' ,
                  prefixIcon: Icon(Icons.person),
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  final v = value?.trim() ?? '';
                  if (v.isEmpty) return null; // optional
                  if (v.length < 3) return 'Enter at least 3 characters';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (_) => null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone number',
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  final v = value?.trim() ?? '';
                  if (v.isEmpty) return null; // optional
                  if (v.length < 8) return 'Enter a valid phone number';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(48),
                ),
                onPressed: _onSave,
                child: const Text('Save changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSave() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    FocusScope.of(context).unfocus();
    _saveAsync();
  }
}

extension on _EditProfileScreenState {
  Future<void> _saveAsync() async {
    final name = _nameController.text.trim();
    final email = FirebaseAuth.instance.currentUser?.email?.trim() ?? '';
    final phone = _phoneController.text.trim();

    String? avatarUrl = ProfileService.instance.profile.value.avatarPathOrUrl;
    if (_avatarPath != null && !_avatarPath!.startsWith('http')) {
      try {
        avatarUrl = await ProfileRepository.instance.uploadAvatar(File(_avatarPath!));
      } catch (_) {}
    }

    await ProfileRepository.instance.upsertProfile(
      name: name,
      email: email,
      phone: phone,
      avatarUrl: avatarUrl,
    );

    final updated = ProfileService.instance.profile.value.copyWith(
      name: name,
      email: email,
      phone: phone,
      avatarPathOrUrl: avatarUrl,
    );
    ProfileService.instance.update(updated);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully')),
    );
    Navigator.pop(context);
  }
}


