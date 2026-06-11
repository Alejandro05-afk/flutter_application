import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class TouristSite {
  final String name;
  final String location;
  final String description;
  final String image;

  const TouristSite({
    required this.name,
    required this.location,
    required this.description,
    required this.image,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecuador Turístico',
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<TouristSite> _sites = const [
    TouristSite(
      name: 'Islas Galápagos',
      location: 'Océano Pacífico, Ecuador',
      image: 'images/galapagos.webp',
      description:
          'Archipiélago volcánico considerado uno de los destinos naturales '
          'más importantes del mundo. Famoso por su fauna única como las '
          'tortugas gigantes, iguanas marinas y pinzones de Darwin. '
          'Patrimonio de la Humanidad por la UNESCO.',
    ),
    TouristSite(
      name: 'Mitad del Mundo',
      location: 'Quito, Pichincha',
      image: 'images/mitadMundo.webp',
      description:
          'Monumento que marca la línea ecuatorial que divide el planeta en '
          'hemisferio norte y sur. Incluye un museo interactivo sobre la '
          'cultura indígena y experimentos científicos en la línea cero.',
    ),
    TouristSite(
      name: 'Quito',
      location: 'Pichincha',
      image: 'images/quito.webp',
      description:
          'Capital de Ecuador y primera ciudad declarada Patrimonio de la '
          'Humanidad por la UNESCO. Su centro histórico colonial con iglesias '
          'barrocas, plazas y museos es uno de los mejor conservados de América.',
    ),
    TouristSite(
      name: 'Baños de Agua Santa',
      location: 'Tungurahua',
      image: 'images/banos.webp',
      description:
          'Ciudad turística conocida como "la puerta al oriente". Famosa por '
          'sus aguas termales, cascadas impresionantes como el Pailón del '
          'Diablo, y deportes de aventura como rafting, canopy y puenting.',
    ),
    TouristSite(
      name: 'Cuenca',
      location: 'Azuay',
      image: 'images/cuenca.webp',
      description:
          'Ciudad colonial declarada Patrimonio de la Humanidad. Reconocida '
          'por su arquitectura republicana, sus famosos sombreros de paja '
          'toquilla, el río Tomebamba y su vibrante escena cultural.',
    ),
    TouristSite(
      name: 'Montañita',
      location: 'Santa Elena',
      image: 'images/montanita.webp',
      description:
          'Playa emblemática de la costa ecuatoriana, famosa por sus olas '
          'perfectas para el surf. Ambiente juvenil, vida nocturna vibrante '
          'y atardeceres espectaculares la convierten en un destino imperdible.',
    ),
    TouristSite(
      name: 'Otavalo',
      location: 'Imbabura',
      image: 'images/otavalo.webp',
      description:
          'Famoso por su mercado indígena, el más grande de Sudamérica. '
          'Artesanías, textiles, y la cultura otavaleña atraen visitantes '
          'de todo el mundo. Además, la laguna de Cuicocha es un bello '
          'cráter volcánico.',
    ),
    TouristSite(
      name: 'Parque Nacional Cotopaxi',
      location: 'Cotopaxi',
      image: 'images/cotopaxi.webp',
      description:
          'Hogar del volcán activo más alto del mundo (5.897 m). Ofrece '
          'paisajes andinos impresionantes, lagunas glaciares y la '
          'oportunidad de escalar uno de los volcanes más emblemáticos '
          'de Ecuador.',
    ),
    TouristSite(
      name: 'Tena',
      location: 'Napo',
      image: 'images/tena.webp',
      description:
          'Capital de la provincia del Napo y puerta de entrada a la '
          'Amazonía ecuatoriana. Ideal para rafting, kayak y excursiones '
          'en la selva donde se puede aprender de comunidades indígenas '
          'y observar fauna exótica.',
    ),
    TouristSite(
      name: 'Guayaquil',
      location: 'Guayas',
      image: 'images/guayaquil.webp',
      description:
          'Principal puerto y ciudad más grande de Ecuador. El Malecón 2000, '
          'Cerro Santa Ana, Las Peñas y el Parque Histórico son sus '
          'principales atractivos. Conocida como la "Perla del Pacífico".',
    ),
  ];

  final Set<int> _favorites = {};

  void _toggleFavorite(int index) {
    setState(() {
      if (_favorites.contains(index)) {
        _favorites.remove(index);
      } else {
        _favorites.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ecuador Turístico'),
        actions: [
          TextButton.icon(
            onPressed: () => _showFavorites(context),
            icon: const Icon(Icons.favorite),
            label: Text('${_favorites.length}'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _sites.length,
        itemBuilder: (context, index) => _SiteCard(
          site: _sites[index],
          isFavorite: _favorites.contains(index),
          onToggleFavorite: () => _toggleFavorite(index),
        ),
      ),
    );
  }

  void _showFavorites(BuildContext context) {
    if (_favorites.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No tienes favoritos aún')),
      );
      return;
    }
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView(
        children: _favorites.map((i) {
          final site = _sites[i];
          return ListTile(
            leading: const Icon(Icons.favorite, color: Colors.red),
            title: Text(site.name),
            subtitle: Text(site.location),
          );
        }).toList(),
      ),
    );
  }
}

class _SiteCard extends StatelessWidget {
  final TouristSite site;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const _SiteCard({
    required this.site,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset(site.image, width: double.infinity, height: 200, fit: BoxFit.cover),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                    size: 32,
                  ),
                  onPressed: onToggleFavorite,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        site.name,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Icon(Icons.location_on, color: Colors.grey[600], size: 16),
                    const SizedBox(width: 4),
                    Text(site.location, style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
                const SizedBox(height: 12),
                Text(site.description, style: const TextStyle(fontSize: 14, height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
