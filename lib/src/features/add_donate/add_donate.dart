import 'package:charity/src/features/home/cubits/campaign_cubit.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonationScreen extends StatefulWidget {
  @override
  _AddDonationPageState createState() => _AddDonationPageState();
}

class _AddDonationPageState extends State<DonationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _storyController = TextEditingController();
  final _amountController = TextEditingController();
  final _periodController = TextEditingController();
  final _organizationController = TextEditingController();
  final _categoryController = TextEditingController();
  final _imageLinkController = TextEditingController();
  final _imageLinkController1 = TextEditingController();

  bool _isLoading = false;

  Future<void> addDonationToFirestore() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_imageLinkController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please add the primary photo URL')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      String imageUrl = _imageLinkController.text.trim();
      String? imageUrl1 = _imageLinkController1.text.trim().isNotEmpty
          ? _imageLinkController1.text.trim()
          : null;

      await FirebaseFirestore.instance.collection('campaigns').add({
        'title': _titleController.text,
        'location': _locationController.text,
        'story': _storyController.text,
        'amount': double.parse(_amountController.text),
        'imageUrl': imageUrl,
        'imageUrl1': imageUrl1,
        'period': _periodController.text,
        'organization': _organizationController.text,
        'category': _categoryController.text,
        'donatedAmount': 0.0,
        'progress': 0.0,
        'createdAt': FieldValue.serverTimestamp(),
        'status': 'active',
        'currentAmount': 0,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Donation added successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      _titleController.clear();
      _locationController.clear();
      _storyController.clear();
      _amountController.clear();
      _periodController.clear();
      _categoryController.clear();
      _organizationController.clear();
      _imageLinkController.clear();
      _imageLinkController1.clear();

      context.read<CampaignsCubit>().fetchCampaigns();

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _storyController.dispose();
    _amountController.dispose();
    _periodController.dispose();
    _categoryController.dispose();
    _organizationController.dispose();
    _imageLinkController.dispose();
    _imageLinkController1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFE57373),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add Donation',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Primary Image URL',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _imageLinkController,
                decoration: InputDecoration(
                  hintText: 'Paste primary image URL here (https://...)',
                  prefixIcon: Icon(Icons.link),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the primary image URL';
                  }
                  if (!value.startsWith('http://') &&
                      !value.startsWith('https://')) {
                    return 'Please enter a valid URL';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text(
                'Secondary Image URL (Optional)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _imageLinkController1,
                decoration: InputDecoration(
                  hintText: 'Paste secondary image URL here (https://...)',
                  prefixIcon: Icon(Icons.link),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                ),
                validator: (value) {
                  if (value != null &&
                      value.isNotEmpty &&
                      !value.startsWith('http://') &&
                      !value.startsWith('https://')) {
                    return 'Please enter a valid URL or leave it empty';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text(
                'Title',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Enter donation title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text(
                'Location',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  hintText: 'Enter location details',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter location';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text(
                'Category',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(
                  hintText: 'Enter Category',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter category';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text(
                'Organization',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _organizationController,
                decoration: InputDecoration(
                  hintText: 'Enter organization',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter organization';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text(
                'Story',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _storyController,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: 'Write the story or reason for the donation...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the story';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Text(
                'Target Amount',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixText: '\$ ',
                  hintText: 'Enter target amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Collection Period",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextFormField(
                  controller: _periodController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.timer),
                    hintText: "Enter collection period (e.g., '30 days')",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter period';
                    }
                    return null;
                  }),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : addDonationToFirestore,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE57373),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'Add Donation',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}