import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawfect_match/BloC/pet_bloc.dart';
import 'package:pawfect_match/BloC/pet_event.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../models/pet.dart';
import 'package:photo_view/photo_view.dart';
import 'package:confetti/confetti.dart';

// ignore: must_be_immutable
class DetailsScreen extends StatefulWidget {
  final Pet pet;

  const DetailsScreen({Key? key, required this.pet}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isAdopted = false;
  late ConfettiController _confettiController;
  Pet? pet;

  @override
  void initState() {
    pet = widget.pet;
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void adoptPet() async {
    pet?.isAdopted = true;
    pet?.adoptedDate = DateTime.now();

    // Start confetti animation
    _confettiController.play();
    // Show adopted popup
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Congratulations!'),
          content: Text('You’ve now adopted ${pet?.name}'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    // Dispatch the update event to PetBloc
    // ignore: use_build_context_synchronously
    BlocProvider.of<PetBloc>(context).add(UpdatePet(pet!));
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final overlayStart = screenHeight * 0.28;
    final imageHeight = screenHeight * 0.3;
    return BlocListener<PetBloc, List<Pet>>(
      listener: (context, state) {
        // Find the updated pet in the list and update the UI
        final updatedPet = state.firstWhere(
          (p) => p.id == pet?.id,
          orElse: () => pet!,
        );
        setState(() {
          pet = updatedPet;
        });
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(
            widget.pet.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => GalleryPhotoViewWrapper(
                        galleryItems: [widget.pet.imageUrl],
                        backgroundDecoration: const BoxDecoration(
                          color: Colors.black,
                        ),
                        initialIndex: 0,
                        scrollPhysics: const BouncingScrollPhysics(),
                      ),
                    ));
                  },
                  child: Hero(
                    tag: 'petHero-${widget.pet.id}',
                    child: Image.network(
                      widget.pet.imageUrl,
                      height: imageHeight,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
            Positioned(
              top: overlayStart,
              left: 0,
              right: 0,
              child: Container(
                // color: is_dark ? Colors.black : Colors.white,
                height: screenHeight - imageHeight - 95,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Name: ${widget.pet.name}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(
                            'Age: ${widget.pet.age}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            'Breed: ${widget.pet.breed}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            'Price: \₹${widget.pet.price}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: ConfettiWidget(
                        confettiController: _confettiController,
                        blastDirectionality: BlastDirectionality.explosive,
                        gravity: 0.3,
                        maxBlastForce: 30,
                        emissionFrequency: 0.04,
                        minBlastForce: 10,
                        numberOfParticles: 40,
                        // Other customizations
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.3,
                          vertical: 8),
                      child: ElevatedButton(
                        onPressed: widget.pet.isAdopted ? null : adoptPet,
                        child: Text(widget.pet.isAdopted
                            ? 'Already Adopted'
                            : 'Adopt Me'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GalleryPhotoViewWrapper extends StatelessWidget {
  GalleryPhotoViewWrapper({
    super.key,
    required this.galleryItems,
    required this.backgroundDecoration,
    this.initialIndex = 0,
    this.scrollPhysics,
  }) : pageController = PageController(initialPage: initialIndex);

  final List<String> galleryItems;
  final BoxDecoration backgroundDecoration;
  final int initialIndex;
  final PageController pageController;
  final ScrollPhysics? scrollPhysics;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            PhotoViewGallery.builder(
              scrollPhysics: scrollPhysics,
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(galleryItems[index]),
                  initialScale: PhotoViewComputedScale.contained,
                  heroAttributes:
                      PhotoViewHeroAttributes(tag: galleryItems[index]),
                );
              },
              itemCount: galleryItems.length,
              loadingBuilder: (context, event) => const Center(
                child: SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(),
                ),
              ),
              backgroundDecoration: backgroundDecoration,
              pageController: pageController,
            ),
            // Close button
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.close_sharp,
                    size: 30, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
