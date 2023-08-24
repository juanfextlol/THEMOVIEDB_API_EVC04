
class OnboardingItem {
  final String imageFilename;
  final String title;
  final String description;

  OnboardingItem({
    required this.imageFilename,
    required this.title,
    required this.description,
  });
}

List<OnboardingItem> onboardingItems = [
  OnboardingItem(
    imageFilename: 't1.png',
    title: 'Bienvenido',
    description: 'Descubre Las Mejores Peliculas Del Momento',
  ),
  OnboardingItem(
    imageFilename: 't2.png',
    title: 'Explora y Elije',
    description: 'Explora una amplia variedad de Series y elige la pelicula perfecta para ver.',
  ),
  OnboardingItem(
    imageFilename: 't3.png',
    title: 'Disfruta de la Experiencia',
    description: 'Vive experiencias con las  mejores series y peliculas.',
  ),
];