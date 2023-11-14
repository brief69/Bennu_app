


// edit_address_page.dart
import 'package:flutter/material.dart';

class AddressSetPage extends StatefulWidget {
  const AddressSetPage({super.key});

  @override
  AddressSetPageState createState() => AddressSetPageState();
}

class AddressSetPageState extends State<AddressSetPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String address = '';
  String savedAddress = 'No Address Saved';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address'),
        backgroundColor: const Color.fromARGB(255, 74, 2, 2),// TODO: #6 themeを使用するように変更して
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Register your address',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (value) => value!.isEmpty ? 'Address is required' : null,
                onSaved: (value) => address = value!,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    setState(() {
                      savedAddress = address;
                    });
                  }
                },
                child: const Text('Register Address'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Registered Address:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                savedAddress,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
