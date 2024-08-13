import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../models/FoodBank_model.dart'; // Adjust the path as per your project structure

class Ehelp extends StatefulWidget {
  static const String id = 'ehelp';

  @override
  _EhelpState createState() => _EhelpState();
}

class _EhelpState extends State<Ehelp> {
  GoogleMapController? mapController;
  PageController _pageController = PageController(initialPage: 1, viewportFraction: 0.8);
  late int prevPage;
  final TextEditingController _searchController = TextEditingController();
  List<FoodBank> filteredFoodBanks = [];
  List<Marker> allMarkers = [];

  @override
  void initState() {
    super.initState();
    // Initialize markers
    centerNames.forEach((element) {
      allMarkers.add(Marker(
        markerId: MarkerId(element.name),
        draggable: false,
        infoWindow: InfoWindow(title: element.name, snippet: element.address),
        position: element.locationCoords,
      ));
    });

    // Initialize filteredFoodBanks with all food banks initially
    filteredFoodBanks = List.from(centerNames); // Assuming centerNames is your list of FoodBank objects
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose PageController on widget dispose
    super.dispose();
  }

  void _onScroll() {
    // Check if page has changed
    if (_pageController.page!.toInt() != prevPage) {
      setState(() {
        prevPage = _pageController.page!.toInt();
      });
      moveCamera();
    }
  }

  void moveCamera() {
    // Move the GoogleMap camera to the selected marker's position
    mapController!.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: filteredFoodBanks[_pageController.page!.toInt()].locationCoords,
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0,
      ),
    ));
  }

  Widget _buildCenterItem(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: (filteredFoodBanks[index].image as Image).image,
                radius: 30,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      filteredFoodBanks[index].name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(filteredFoodBanks[index].address),
                    SizedBox(height: 4),
                    Text(filteredFoodBanks[index].no),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Food Banks',
          style: GoogleFonts.acme(fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _updateSearch('');
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: _updateSearch,
            ),
          ),
          Expanded(
            flex: 3,
            child: PageView.builder(
              controller: _pageController,
              itemCount: filteredFoodBanks.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildCenterItem(index);
              },
            ),
          ),
          Expanded(
            flex: 7,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(28.7041, 77.1025), // Initial map position
                zoom: 12.0,
              ),
              onMapCreated: mapCreated,
              markers: Set.from(allMarkers),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _searchController.clear();
          _updateSearch('');
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void mapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void _updateSearch(String query) {
    List<FoodBank> filteredList = centerNames.where((bank) {
      return bank.name.toLowerCase().contains(query.toLowerCase()) ||
          bank.address.toLowerCase().contains(query.toLowerCase()) ||
          bank.no.contains(query);
    }).toList();

    setState(() {
      filteredFoodBanks = filteredList;
    });
  }
}
