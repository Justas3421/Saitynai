import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:landlords_web_app/backend/auth_repository/models/user.dart';
import 'package:landlords_web_app/backend/buildings_repository/building.dart';
import 'package:landlords_web_app/backend/buildings_repository/building_repository.dart';
import 'package:landlords_web_app/backend/landlords_repository/landlord.dart';
import 'package:landlords_web_app/constants/nav_bar.dart';
import 'package:landlords_web_app/frontend/auth_screen/cubit/auth_cubit.dart';
import 'package:landlords_web_app/frontend/building_screen/cubit/buildings_cubit.dart';
import 'package:landlords_web_app/frontend/building_screen/update_building_dialog.dart';
import 'package:landlords_web_app/frontend/flats_screen/flats_screen.dart';
import 'package:landlords_web_app/frontend/login_screen/widgets/landing_background.dart';
import 'package:intl/intl.dart';

class BuildingScreen extends StatelessWidget {
  final bool isManagment;
  final Landlord landlord;

  const BuildingScreen(
      {super.key, required this.landlord, this.isManagment = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return NavBar(
      child: BlocProvider(
        create: (context) => BuildingCubit(context.read<BuildingRepository>())
          ..fetchBuildings(landlord.landlordId),
        child: BlocBuilder<BuildingCubit, BuildingState>(
          builder: (context, state) {
            if (state.status == BuildingStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == BuildingStatus.success) {
              return Scaffold(
                backgroundColor: Colors.transparent,
                floatingActionButton: isManagment
                    ? FloatingActionButton(
                        backgroundColor: Colors.amber,
                        onPressed: () {
                          _addBuilding(context);
                        },
                        child: const Icon(Icons.add, color: Colors.black),
                      )
                    : null,
                body: Stack(
                  children: [
                    LandingBackground(
                      title: '${landlord.name} Buildings',
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 70.0),
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.buildings.length,
                          itemBuilder: (context, index) {
                            final building = state.buildings[index];
                            final bool canEdit = isManagment
                                ? context.read<AuthCubit>().state.user.role ==
                                        UserRole.admin ||
                                    context
                                            .read<AuthCubit>()
                                            .state
                                            .user
                                            .userId ==
                                        landlord.userId
                                : false;
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
                                        const Icon(
                                          Icons.apartment,
                                          color: Colors.amber,
                                          size: 36,
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          building.name,
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
                                      'Address: ${building.address}, ${building.city}, ${building.state}, ${building.zipCode}',
                                      style:
                                          theme.textTheme.bodyMedium!.copyWith(
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Floors: ${building.numberOfFloors}',
                                      style:
                                          theme.textTheme.bodyMedium!.copyWith(
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Created At: ${DateFormat.yMMMMd().format(building.createdAt)}',
                                      style:
                                          theme.textTheme.bodySmall!.copyWith(
                                        color: Colors.grey[500],
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Last Updated: ${DateFormat.yMMMMd().format(building.updatedAt)}',
                                      style:
                                          theme.textTheme.bodySmall!.copyWith(
                                        color: Colors.grey[500],
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              _createRoute(landlord, building),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.amber,
                                          ),
                                          child: const Text(
                                            'View Flats',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        if (canEdit) ...[
                                          ElevatedButton(
                                            onPressed: () {
                                              _updateBuilding(
                                                  building, context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue,
                                            ),
                                            child: const Text(
                                              'Update',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              context
                                                  .read<BuildingCubit>()
                                                  .deleteBuilding(
                                                      landlord.landlordId,
                                                      building.buildingId,
                                                      building);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                            ),
                                            child: const Text(
                                              'Delete',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state.status == BuildingStatus.error) {
              return const Center(
                child: Text(
                  'Failed to load buildings',
                  style: TextStyle(color: Colors.red),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  void _addBuilding(BuildContext context) async {
    final newBuilding = await showDialog<Building>(
      context: context,
      builder: (context) {
        return UpdateBuildingDialog(
          building: Building(
            buildingId:
                0, // Temporary ID, backend should generate the actual ID
            landlordId: landlord.landlordId,
            name: '',
            address: '',
            city: '',
            state: '',
            zipCode: '',
            numberOfFloors: 1,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );
      },
    );

    if (newBuilding != null) {
      context
          .read<BuildingCubit>()
          .addBuilding(landlord.landlordId, newBuilding);
    }
  }

  Route _createRoute(Landlord landlord, Building building) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => FlatScreen(
        buildingId: building,
        landlordId: landlord,
        isManagement: isManagment,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  void _updateBuilding(Building building, BuildContext context) async {
    final updatedBuilding = await showDialog<Building>(
      context: context,
      builder: (context) {
        return UpdateBuildingDialog(
          building: building,
        );
      },
    );

    if (updatedBuilding != null) {
      context.read<BuildingCubit>().updateBuilding(
          landlord.landlordId, building.buildingId, updatedBuilding);
    }
  }
}
