import 'package:flutter/material.dart';
import 'package:landlords_web_app/backend/flats_repository/flat.dart';
import 'package:intl/intl.dart';

class FlatDetailsDialog extends StatefulWidget {
  final Flat flat;
  final bool isEditing;

  const FlatDetailsDialog(
      {super.key, required this.flat, this.isEditing = false});

  @override
  State<FlatDetailsDialog> createState() => _FlatDetailsDialogState();
}

class _FlatDetailsDialogState extends State<FlatDetailsDialog> {
  late TextEditingController _flatNumberController;
  late TextEditingController _numBedroomsController;
  late TextEditingController _numBathroomsController;
  late TextEditingController _rentController;
  late TextEditingController _tenantNameController;
  bool _isOccupied = false;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _flatNumberController = TextEditingController(text: widget.flat.flatNumber);
    _numBedroomsController =
        TextEditingController(text: widget.flat.numBedrooms.toString());
    _numBathroomsController =
        TextEditingController(text: widget.flat.numBathrooms.toString());
    _rentController = TextEditingController(text: widget.flat.rent.toString());
    _tenantNameController = TextEditingController(text: widget.flat.tenantName);
    _isOccupied = widget.flat.isOccupied;
    _isEditing = widget.isEditing;
  }

  @override
  void dispose() {
    _flatNumberController.dispose();
    _numBedroomsController.dispose();
    _numBathroomsController.dispose();
    _rentController.dispose();
    _tenantNameController.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveChanges() {
    final updatedFlat = Flat(
      flatId: widget.flat.flatId,
      buildingId: widget.flat.buildingId,
      flatNumber: _flatNumberController.text,
      numBedrooms: int.tryParse(_numBedroomsController.text) ?? 1,
      numBathrooms: int.tryParse(_numBathroomsController.text) ?? 1,
      rent: double.tryParse(_rentController.text) ?? 0.0,
      isOccupied: _isOccupied,
      tenantName: _tenantNameController.text,
      createdAt: widget.flat.createdAt,
      updatedAt: DateTime.now(),
    );

    Navigator.pop(context, updatedFlat);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _isEditing
                ? 'Edit Flat Details'
                : 'Flat ${widget.flat.flatNumber} Details',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEditableRow('Flat Number:', _flatNumberController,
                editable: _isEditing),
            _buildEditableRow('Bedrooms:', _numBedroomsController,
                editable: _isEditing, isNumeric: true),
            _buildEditableRow('Bathrooms:', _numBathroomsController,
                editable: _isEditing, isNumeric: true),
            _buildEditableRow('Rent:', _rentController,
                editable: _isEditing, isNumeric: true),
            _buildEditableRow('Tenant Name:', _tenantNameController,
                editable: _isEditing),
            if (_isEditing)
              SwitchListTile(
                title: const Text(
                  'Occupied:',
                  style: TextStyle(color: Colors.white),
                ),
                value: _isOccupied,
                onChanged: (value) {
                  setState(() {
                    _isOccupied = value;
                  });
                },
              )
            else
              _buildInfoRow('Occupied:', widget.flat.isOccupied ? 'Yes' : 'No'),
            _buildInfoRow('Created At:',
                DateFormat.yMMMMd().format(widget.flat.createdAt)),
            _buildInfoRow('Last Updated:',
                DateFormat.yMMMMd().format(widget.flat.updatedAt)),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        if (_isEditing)
          ElevatedButton(
            onPressed: _saveChanges,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
            child: const Text(
              'Save',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          )
        else
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Close',
              style: TextStyle(color: Colors.amber),
            ),
          ),
      ],
    );
  }

  Widget _buildEditableRow(String label, TextEditingController controller,
      {bool editable = false, bool isNumeric = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$label ',
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: editable
                ? TextField(
                    controller: controller,
                    keyboardType:
                        isNumeric ? TextInputType.number : TextInputType.text,
                    style: const TextStyle(color: Colors.white),
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
                    controller.text,
                    style: const TextStyle(color: Colors.white),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$label ',
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
