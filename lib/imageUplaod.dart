// await FirebaseStorage.instance
//     .ref()
//     .child("ProfileImage/${sharedPreferences!.getString("token")}.jpg")
//     .putFile(profileController.profileImage.value)
//     .then((TaskSnapshot taskSnapshot) {
// if (taskSnapshot.state == TaskState.success) {
// taskSnapshot.ref.getDownloadURL().then((imageURL) async {
// profileController.profileImageLink.value = imageURL;
// await FirebaseFirestore.instance.collection('user').doc(sharedPreferences!.getString("token")).update({
// "profile_image": profileController.profileImageLink.value.toString(),
// "first_name": profileController.firstName.value.text,
// "last_name": profileController.lastName.value.text,
// "bio": profileController.bio.value.text,
// "dob": profileController.dob.value,
// "gender": profileController.selectedGender.toString(),
// "mobile_no": "${profileController.countryCode.value}${profileController.phone.value.text}",
// "profile_setup": true,
// "otherImages": profileController.otherImagesLink,
// "country": profileController.country.value,
// "city": profileController.city.value,
// "state": profileController.state.value
// });
// await sharedPreferences!.setString("first_name", profileController.firstName.value.text);
// await sharedPreferences!.setString("profile_pic", profileController.profileImageLink.value.toString());
// profileController.firstName.value.clear();
// profileController.lastName.value.clear();
// profileController.phone.value.clear();
// profileController.bio.value.clear();
// profileController.profileImage.value = File("");
// profileController.profileImageLink.value = "";
// profileController.gender.value = "Male";
// profileController.country.value = "";
// profileController.state.value = "";
// profileController.city.value = "";
// profileController.countryCode.value = "+91";
// profileController.selectedGender.value = "Man";
// profileController.dob.value = "";
// profileController.otherImages.clear();
// profileController.otherImagesLink.clear();
// if (sharedPreferences!.getBool('interest_fill') == false) {
// hideLoadingDialog();
// Get.to(() => const InterestScreen(
// isStartPage: true,
// ));
// } else {
// hideLoadingDialog();
// Get.to(() => const BottomScreen());
// }
// });
// } else if (taskSnapshot.state == TaskState.running) {
// // Show Progress indicator
// } else if (taskSnapshot.state == TaskState.error) {
// // Handle Error Here
// }
// });
