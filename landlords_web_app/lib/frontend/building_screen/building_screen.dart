import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:landlords_web_app/backend/auth_repository/models/user.dart';
import 'package:landlords_web_app/backend/buildings_repository/building.dart';
import 'package:landlords_web_app/backend/buildings_repository/building_repository.dart';
import 'package:landlords_web_app/backend/landlords_repository/landlord.dart';
import 'package:landlords_web_app/constants/nav_bar.dart';
import 'package:landlords_web_app/frontend/auth_screen/cubit/auth_cubit.dart';
import 'package:landlords_web_app/frontend/building_screen/cubit/buildings_cubit.dart';
import 'package:landlords_web_app/frontend/flats_screen/flats_screen.dart';
import 'package:landlords_web_app/frontend/login_screen/widgets/landing_background.dart';
import 'package:intl/intl.dart';

class BuildingScreen extends StatelessWidget {
  final Landlord landlord;

  const BuildingScreen({super.key, required this.landlord});

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
                            final bool canEdit = context
                                        .read<AuthCubit>()
                                        .state
                                        .user
                                        .role ==
                                    UserRole.admin ||
                                context.read<AuthCubit>().state.user.userId ==
                                    landlord.landlordId;
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
                                              _createRoute(landlord.landlordId,
                                                  building.buildingId),
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
                                              // Add update logic here
                                              _updateBuilding(building);
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
                                              // Add delete logic here
                                              _deleteBuilding(building);
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

  Route _createRoute(int landlord, int building) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => FlatScreen(
        buildingId: building,
        landlordId: landlord,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0); // Change to come from the bottom
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        var scaleTween =
            Tween<double>(begin: 0.8, end: 1.0).chain(CurveTween(curve: curve));
        var scaleAnimation = animation.drive(scaleTween);

        var fadeTween =
            Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));
        var fadeAnimation = animation.drive(fadeTween);

        return SlideTransition(
          position: offsetAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: FadeTransition(
              opacity: fadeAnimation,
              child: child,
            ),
          ),
        );
      },
    );
  }

  void _deleteBuilding(Building building) {
    // Add your delete logic here, such as calling the backend API
    print('Delete Building: ${building.name}');
  }

  void _updateBuilding(Building building) {
    // Add your update logic here, such as opening an update form
    print('Update Building: ${building.name}');
  }
}
