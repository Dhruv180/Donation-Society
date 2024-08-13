import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../models/Bloodbank_model.dart'; // Assuming this imports your model correctly

class Health extends StatefulWidget {
  static const String id = 'health';

  @override
  _HealthState createState() => _HealthState();
}

class _HealthState extends State<Health> {
  late GoogleMapController mapController;
  late PageController _pageController;
  int prevPage = 0; // Initialize prevPage

  final TextEditingController _searchController = TextEditingController();
  List<Bank> filteredBanks = [];
  List<Marker> allMarkers = [];

  @override
  void initState() {
    super.initState();

    // Initialize the page controller and markers
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);

    // Populate the markers from bbnames
    bbnames.forEach((element) {
      allMarkers.add(Marker(
        markerId: MarkerId(element.name),
        draggable: false,
        infoWindow: InfoWindow(title: element.name, snippet: element.address),
        position: element.locationCoords,
      ));
    });

    // Initialize filteredBanks with all banks initially
    filteredBanks = bbnames;
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
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: filteredBanks[_pageController.page!.toInt()].locationCoords,
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
                backgroundImage: (filteredBanks[index].image as Image).image,
                radius: 30,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      filteredBanks[index].name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(filteredBanks[index].address),
                    SizedBox(height: 4),
                    Text(filteredBanks[index].no),
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
          'Blood Banks',
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
              itemCount: filteredBanks.length,
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
        onPressed: _addNewBank,
        child: Icon(Icons.add),
      ),
    );
  }

  void mapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void _updateSearch(String query) {
    List<Bank> filteredList = bbnames.where((bank) {
      return bank.name.toLowerCase().contains(query.toLowerCase()) ||
          bank.address.toLowerCase().contains(query.toLowerCase()) ||
          bank.no.contains(query);
    }).toList();

    setState(() {
      filteredBanks = filteredList;
    });
  }

  void _addNewBank() {
    // Example function to add a new bank entry
    // Implement your logic here to add a new entry to bbnames
    // For example:
    // bbnames.add(Bank(
    //   name: 'New Bank',
    //   address: 'New Address',
    //   locationCoords: LatLng(0.0, 0.0),
    //   image: Image.asset('images/default_image.png'),
    //   no: '1234567890',
    // ));
    // setState(() {
    //   filteredBanks = bbnames; // Update filteredBanks with the new list
    // });
  }
}
