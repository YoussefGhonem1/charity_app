import 'package:flutter/material.dart';
import 'package:charity/src/shared/theme/app_colors.dart';
import 'package:charity/src/shared/localization/app_translations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charity/src/features/create_account/cubits/user_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen();

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  File? _pickedImage;
  String? _avatarUrl;
  bool _isUploading = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final user = context.read<UserCubit>().state;
    if (user != null) {
      final name = '${user.firstName} ${user.lastName}'.trim();
      _nameController.text = name;
      _emailController.text = user.email;
      _avatarUrl = user.avatarUrl;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (image != null) {
        setState(() {
          _pickedImage = File(image.path);
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  Future<String?> _uploadImage() async {
    if (_pickedImage == null) return _avatarUrl;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return _avatarUrl;

    setState(() {
      _isUploading = true;
    });

    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('users')
          .child('${user.uid}_avatar.jpg');

      await ref.putFile(_pickedImage!);
      final url = await ref.getDownloadURL();
      
      setState(() {
        _isUploading = false;
        _avatarUrl = url;
      });
      
      return url;
    } catch (e) {
      setState(() {
        _isUploading = false;
      });
      if (!mounted) return _avatarUrl;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading image: $e')),
      );
      return _avatarUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppTranslations.of(context);
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(t.editProfile),
        actions: [
          if (_isUploading)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            TextButton(
              onPressed: _onSave,
              child: Text(
                t.save,
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
                      radius: 60,
                      backgroundColor: theme.colorScheme.surface,
                      backgroundImage: _pickedImage != null
                          ? FileImage(_pickedImage!)
                          : (_avatarUrl != null && _avatarUrl!.isNotEmpty)
                              ? NetworkImage(_avatarUrl!)
                              : null,
                      child: _pickedImage == null && (_avatarUrl == null || _avatarUrl!.isEmpty)
                          ? Icon(
                              Icons.person,
                              size: 60,
                              color: theme.iconTheme.color,
                            )
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.scaffoldBackgroundColor,
                            width: 3,
                          ),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                          onPressed: _pickImage,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: TextButton(
                  onPressed: _pickImage,
                  child: Text(
                    _avatarUrl != null ? t.translate('change_photo') : t.translate('select_photo'),
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: t.fullName,
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return t.translate('name_is_required');
                  }
                  if (value.trim().length < 3) {
                    return t.translate('enter_at_least_3_characters');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: t.email,
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return t.translate('email_is_required');
                  }
                  final emailRegex = RegExp(r'^\S+@\S+\.\S+$');
                  if (!emailRegex.hasMatch(value.trim())) {
                    return t.translate('enter_a_valid_email');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: t.phoneNumber,
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return t.translate('phone_is_required');
                  }
                  if (value.trim().length < 8) {
                    return t.translate('enter_a_valid_phone_number');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _isUploading ? null : _onSave,
                child: _isUploading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(t.saveChanges),
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
    _saveToBackend();
  }

  Future<void> _saveToBackend() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    
    setState(() {
      _isUploading = true;
    });

    // Upload image if picked
    final avatarUrl = await _uploadImage();
    
    final fullName = _nameController.text.trim();
    final parts = fullName.split(' ');
    final firstName = parts.isNotEmpty ? parts.first : '';
    final lastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';
    
    final updateData = {
      'firstName': firstName,
      'lastName': lastName,
      'email': _emailController.text.trim(),
      'phone': _phoneController.text.trim(),
    };
    
    if (avatarUrl != null && avatarUrl.isNotEmpty) {
      updateData['avatarUrl'] = avatarUrl;
    }
    
    await FirebaseFirestore.instance.collection('users').doc(uid).set(
      updateData,
      SetOptions(merge: true),
    );
    
    await context.read<UserCubit>().loadUserData();
    
    setState(() {
      _isUploading = false;
    });
    
    if (!mounted) return;
    final t = AppTranslations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(t.profileUpdatedSuccessfully)),
    );
    Navigator.pop(context, {
      'name': fullName,
      'email': _emailController.text.trim(),
      'phone': _phoneController.text.trim(),
      'avatarUrl': avatarUrl,
    });
  }
}
