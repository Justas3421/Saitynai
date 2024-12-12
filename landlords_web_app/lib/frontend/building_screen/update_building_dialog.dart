import 'package:flutter/material.dart';
import 'package:landlords_web_app/backend/buildings_repository/building.dart';

class UpdateBuildingDialog extends StatefulWidget {
  final Building building;

  const UpdateBuildingDialog({
    super.key,
    required this.building,
  });

  @override
  State<UpdateBuildingDialog> createState() => _UpdateBuildingDialogState();
}

class _UpdateBuildingDialogState extends State<UpdateBuildingDialog> {
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _zipCodeController;
  late TextEditingController _floorsController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.building.name);
    _addressController = TextEditingController(text: widget.building.address);
    _cityController = TextEditingController(text: widget.building.city);
    _stateController = TextEditingController(text: widget.building.state);
    _zipCodeController = TextEditingController(text: widget.building.zipCode);
    _floorsController =
        TextEditingController(text: widget.building.numberOfFloors.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    _floorsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: Text(
        'Update Building',
        style: theme.textTheme.headlineSmall!.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('Name', _nameController),
            const SizedBox(height: 12),
            _buildTextField('Address', _addressController),
            const SizedBox(height: 12),
            _buildTextField('City', _cityController),
            const SizedBox(height: 12),
            _buildTextField('State', _stateController),
            const SizedBox(height: 12),
            _buildTextField('Zip Code', _zipCodeController),
            const SizedBox(height: 12),
            _buildTextField('Number of Floors', _floorsController,
                isNumeric: true),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            final updatedBuilding = Building(
              buildingId: widget.building.buildingId,
              landlordId: widget.building.landlordId,
              name: _nameController.text,
              address: _addressController.text,
              city: _cityController.text,
              state: _stateController.text,
              zipCode: _zipCodeController.text,
              numberOfFloors: int.tryParse(_floorsController.text) ?? 1,
              createdAt: widget.building.createdAt,
              updatedAt: DateTime.now(),
            );
            Navigator.pop(context, updatedBuilding);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
          ),
          child: const Text(
            'Save',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isNumeric = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.amber),
            ),
          ),
        ),
      ],
    );
  }
}
