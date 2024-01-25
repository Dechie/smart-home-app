String assetz = 'assets/svg';

class HomeDevice {
  final String title, image, subtitle;

  HomeDevice({
    required this.title,
    required this.image,
    required this.subtitle,
  });
}

List dummyHomeDevices = [
  HomeDevice(
    title: 'Smart Bulb',
    image: '$assetz/ceiling_lamp.svg',
    subtitle: 'Smart Light Bulb',
  ),
  HomeDevice(
    title: 'LightStar',
    image: '$assetz/floor_lamp.svg',
    subtitle: 'Desk lamp',
  ),
  HomeDevice(
    title: 'Samsung',
    image: '$assetz/television.svg',
    subtitle: 'Smart Tv',
  ),
  HomeDevice(
    title: 'Ventilator',
    image: '$assetz/ventilator.svg',
    subtitle: 'Fan',
  ),
];
