import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:landlords_web_app/backend/flats_repository/flat_repository.dart';
import 'package:landlords_web_app/constants/nav_bar.dart';
import 'package:landlords_web_app/frontend/flats_screen/cubit/flat_cubit.dart';
import 'package:intl/intl.dart';
import 'package:landlords_web_app/frontend/flats_screen/flat_details_dialog.dart';
import 'package:landlords_web_app/frontend/login_screen/widgets/landing_background.dart';

class FlatScreen extends StatelessWidget {
  final int landlordId;
  final int buildingId;

  const FlatScreen({
    super.key,
    required this.landlordId,
    required this.buildingId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return NavBar(
      child: Stack(
        children: [
          const LandingBackground(title: 'Flats'),
          BlocProvider(
            create: (context) =>
                FlatCubit(RepositoryProvider.of<FlatRepository>(context))
                  ..fetchBuildings(landlordId, buildingId),
            child: BlocBuilder<FlatCubit, FlatState>(
              builder: (context, state) {
                if (state.status == FlatStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.status == FlatStatus.error) {
                  return const Center(
                    child: Text(
                      'Failed to load flats. Please try again.',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                } else if (state.status == FlatStatus.success &&
                    state.flats.isEmpty) {
                  return const Center(
                    child: Text(
                      'No flats available.',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                } else if (state.status == FlatStatus.success) {
                  return SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.flats.length,
                        padding: const EdgeInsets.all(16),
                        itemBuilder: (context, index) {
                          final flat = state.flats[index];
                          return Card(
                            color: Colors.grey[900],
                            elevation: 8,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.home,
                                        color: flat.isOccupied
                                            ? Colors.green
                                            : Colors.red,
                                        size: 36,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        'Flat ${flat.flatNumber}',
                                        style: theme.textTheme.headlineSmall!
                                            .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Bedrooms: ${flat.numBedrooms}, Bathrooms: ${flat.numBathrooms}',
                                    style: theme.textTheme.bodyMedium!.copyWith(
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Rent: \$${flat.rent.toStringAsFixed(2)}',
                                    style: theme.textTheme.bodyMedium!.copyWith(
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Occupied: ${flat.isOccupied ? 'Yes' : 'No'}',
                                    style: theme.textTheme.bodyMedium!.copyWith(
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Tenant: ${flat.tenantName.isEmpty ? 'N/A' : flat.tenantName}',
                                    style: theme.textTheme.bodyMedium!.copyWith(
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Created At: ${DateFormat.yMMMMd().format(flat.createdAt)}',
                                    style: theme.textTheme.bodySmall!.copyWith(
                                      color: Colors.grey[500],
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Last Updated: ${DateFormat.yMMMMd().format(flat.updatedAt)}',
                                    style: theme.textTheme.bodySmall!.copyWith(
                                      color: Colors.grey[500],
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              FlatDetailsDialog(flat: flat),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.amber,
                                      ),
                                      child: const Text(
                                        'Details',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
