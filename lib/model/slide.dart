
class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: 'images/image1.jpg',
    title: 'Improving Lives with IDental',
    description: 'Our artificial intelligence platform supports providers and payers to enhance clinical care and administrative efficiency.',
  ),
  Slide(
    imageUrl: 'images/image2.jpg',
    title: 'The Future Of Dentistry Powered By AI',
    description: 'Machine learning and computer vision provide the foundation of every solution.',
  ),
  Slide(
    imageUrl: 'images/image3.png',
    title: 'It\'s Just the Beginning',
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec dapibus tincidunt bibendum. Maecenas eu viverra orci. Duis diam leo, porta at justo vitae, euismod aliquam nulla.',
  ),
];
