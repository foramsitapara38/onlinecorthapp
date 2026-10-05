import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../models/address.dart';
import '../state/shop_store.dart';
import '../widgets/luxe_header.dart';

/// "Select Address" page - where the user types the delivery address.
///
/// Opened from two places:
///   * Bag  -> Checkout  (an address is needed before an order)
///   * Profile -> Saved Addresses
///
/// ← returns to whichever page opened it, X closes the shop.
class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _name = TextEditingController();
  final _line = TextEditingController();
  final _city = TextEditingController();
  final _pincode = TextEditingController();
  final _state = TextEditingController();
  bool _saveIt = true;

  @override
  void initState() {
    super.initState();
    // Edit the address that was saved earlier, if there is one.
    final saved = savedAddress.value;
    if (saved != null) {
      _name.text = saved.fullName;
      _line.text = saved.line;
      _city.text = saved.city;
      _pincode.text = saved.pincode;
      _state.text = saved.state;
      _saveIt = saved.saveIt;
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _line.dispose();
    _city.dispose();
    _pincode.dispose();
    _state.dispose();
    super.dispose();
  }

  void _goBack() {
    Navigator.of(context).pop();
  }

  void _closeShop() {
    // This page sits on top of the Bag or the Profile, so wipe the whole
    // stack to avoid leaving a home page underneath the login screen.
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/login',
      (route) => false,
    );
  }

  /// Returns a short message when something is missing, otherwise null.
  String? _problem() {
    if (_name.text.trim().isEmpty) return 'Please enter your full name';
    if (_line.text.trim().isEmpty) return 'Please enter your address';
    if (_city.text.trim().isEmpty) return 'Please enter your city';
    if (_pincode.text.trim().length != 6) return 'Pincode must be 6 digits';
    return null;
  }

  void _save() {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    final problem = _problem();
    if (problem != null) {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(backgroundColor: kInk, content: Text(problem)),
        );
      return;
    }

    savedAddress.value = Address(
      fullName: _name.text.trim(),
      line: _line.text.trim(),
      city: _city.text.trim(),
      pincode: _pincode.text.trim(),
      state: _state.text.trim(),
      saveIt: _saveIt,
    );

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          backgroundColor: kInk,
          content: Text('Address saved ✓'),
        ),
      );

    navigator.pop(); // back to the Bag or the Profile
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LuxeHeader(onBack: _goBack, onClose: _closeShop),
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 12, 24, 24),
              child: Center(
                child: Text(
                  'Select Address',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: kInk,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                children: [
                  _Field(
                    label: 'Full Name',
                    hint: 'Shree',
                    words: true,
                    controller: _name,
                  ),
                  const SizedBox(height: 20),
                  _Field(
                    label: 'Address',
                    hint: 'abc;block no 1,Rajkot',
                    controller: _line,
                  ),
                  const SizedBox(height: 20),
                  _Field(
                    label: 'City',
                    hint: 'Rajkot',
                    words: true,
                    controller: _city,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _Field(
                          label: 'Pincode',
                          hint: '000000',
                          digits: true,
                          controller: _pincode,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _Field(
                          label: 'State',
                          hint: 'Gujrat',
                          words: true,
                          controller: _state,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Checkbox(
                        value: _saveIt,
                        onChanged: (value) {
                          setState(() => _saveIt = value ?? false);
                        },
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Save this Address',
                        style: TextStyle(fontSize: 16, color: kInk),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: FilledButton(
                      onPressed: _save,
                      style: FilledButton.styleFrom(
                        backgroundColor: kAccent,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text(
                        'Save Address',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// One centred label above a grey input box, exactly like the design.
class _Field extends StatelessWidget {
  const _Field({
    required this.label,
    required this.controller,
    required this.hint,
    this.words = false,
    this.digits = false,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final bool words;
  final bool digits;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 15, color: kInk),
        ),
        const SizedBox(height: 8),
        Container(
          height: 44,
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(3),
          ),
          child: TextField(
            controller: controller,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            keyboardType: digits ? TextInputType.number : TextInputType.text,
            textCapitalization:
                words ? TextCapitalization.words : TextCapitalization.none,
            style: const TextStyle(fontSize: 15, color: kInk),
            decoration: InputDecoration(
              isDense: true,
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: 15,
                color: Colors.black.withValues(alpha: 0.5),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
