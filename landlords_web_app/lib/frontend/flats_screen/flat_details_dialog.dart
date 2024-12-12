import 'package:flutter/material.dart';
import 'package:landlords_web_app/backend/flats_repository/flat.dart';
import 'package:intl/intl.dart';

class FlatDetailsDialog extends StatelessWidget {
  final Flat flat;

  const FlatDetailsDialog({super.key, required this.flat});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: Text(
        'Flat ${flat.flatNumber} Details',
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Bedrooms:', flat.numBedrooms.toString()),
            _buildInfoRow('Bathrooms:', flat.numBathrooms.toString()),
            _buildInfoRow('Rent:', '\$${flat.rent.toStringAsFixed(2)}'),
            _buildInfoRow('Occupied:', flat.isOccupied ? 'Yes' : 'No'),
            _buildInfoRow('Tenant:',
                flat.tenantName.isNotEmpty ? flat.tenantName : 'N/A'),
            _buildInfoRow(
                'Created At:', DateFormat.yMMMMd().format(flat.createdAt)),
            _buildInfoRow(
                'Last Updated:', DateFormat.yMMMMd().format(flat.updatedAt)),
          ],
        ),
      ),
      actions: [
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
