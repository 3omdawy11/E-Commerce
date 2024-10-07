import 'package:ecommerce/manager/user_details/user_details_bloc.dart';
import 'package:ecommerce/utilis/colors.dart';
import 'package:ecommerce/utilis/fonts.dart';
import 'package:ecommerce/utilis/shared_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

late Uint8List? profilePicture;

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController locationController = TextEditingController();

    // late Uint8List? profilePicture;

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: CustomColors.white,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.05,
                vertical: screenSize.height * 0.05),
            child: Column(
              children: [
                CustomAppBar(
                  screenSize: screenSize,
                  leftIcon: const Icon(CupertinoIcons.back),
                  appBarHeading: const Text('Profile', style: Fonts.h2),
                  leftIconAction: () => GoRouter.of(context).pop(),
                ),
                BlocBuilder<UserDetailsBloc, UserDetailsState>(
                  builder: (context, state) {
                    if (state is UserLoaded) {
                      // Initialize controllers with the current user data
                      profilePicture = state.profilePicture;
                      firstNameController.text = state.firstName ?? '';
                      lastNameController.text = state.lastName ?? '';
                      locationController.text = state.location ?? '';

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50),
                            child: Column(
                              children: [
                                ProfilePicEditor(
                                  context: context,
                                  username:
                                     state.username,
                                  screenSize: screenSize,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                CustomTextField(
                                  fieldLabel: 'First Name',
                                  fieldHint: firstNameController.text != ""
                                      ? 'Add First Name'
                                      : firstNameController.text,
                                  screenSize: screenSize,
                                  textEditingController: firstNameController,
                                ),
                                const SizedBox(height: 20),
                                CustomTextField(
                                  fieldLabel: 'Last Name',
                                  fieldHint: lastNameController.text != ""
                                      ? 'Add Last Name'
                                      : lastNameController.text,
                                  screenSize: screenSize,
                                  textEditingController: lastNameController,
                                ),
                                const SizedBox(height: 20),
                                CustomTextField(
                                  fieldLabel: 'Location',
                                  fieldHint: 'Location',
                                  screenSize: screenSize,
                                  textEditingController: locationController,
                                ),
                                const SizedBox(height: 20),
                                ActionButton(
                                  color: state is SavingProfile
                                      ? CustomColors.grey
                                      : null,
                                  screenSize: screenSize,
                                  message: state is SavingProfile
                                      ? 'Saving...'
                                      : 'Save Now',
                                  action: () {
                                    if (state is! SavingProfile) {
                                      context.read<UserDetailsBloc>().add(
                                          SaveUserData(
                                              username: state.username,
                                              email: state.email,
                                              firstName:
                                                  firstNameController.text,
                                              lastName: lastNameController.text,
                                              location: locationController.text,
                                              profilePicture: profilePicture));
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else if (state is UserError) {
                      return const Center(
                          child: Text('Error loading user data.'));
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfilePicEditor extends StatelessWidget {
  const ProfilePicEditor({
    super.key,
    required this.screenSize,
    required this.username,
    required this.context,
  });

  final Size screenSize;
  final String username;
  final BuildContext context;
// Moved pickedImage here to hold the selected image
  Future<void> onProfileTapped() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageBytes = await image.readAsBytes();
    // Save the image to Firebase Storage
    profilePicture = imageBytes;

    // Update the pickedImage state to display the image
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfilePicture(screenSize: screenSize),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            onProfileTapped();
          },
          child: const Text(
            'Change Profile Picture',
            style: TextStyle(color: CustomColors.blue),
          ),
        ),
      ],
    );
  }
}

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key, required this.screenSize});
  final Size screenSize;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: CustomColors.darkerWhite,
          radius: screenSize.width * 0.13,
          child: profilePicture != null
              ? Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.memory(
                        profilePicture!,
                        fit: BoxFit.cover,
                      ).image,
                    ),
                  ),
                )
              : SvgPicture.asset(
                  'assets/svgs/profile.svg',
                  fit: BoxFit.cover,
                  height: screenSize.width * 0.2,
                ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
