import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../models/Cloth_model.dart';

class Clothes extends StatefulWidget {
  static const String id = 'clothes';

  @override
  _ClothesState createState() => _ClothesState();
}

class _ClothesState extends State<Clothes> {
  List<Marker> allMarkers = [];
  late GoogleMapController mapController;
  late PageController _pageController;
  late int prevPage;
  final TextEditingController _searchController = TextEditingController();
  List<Example> filteredExamples = [];

  @override
  void initState() {
    super.initState();
    // Initialize the page controller and markers
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);

    // Populate the markers from exnames
    exnames.forEach((element) {
      allMarkers.add(Marker(
        markerId: MarkerId(element.name),
        draggable: false,
        infoWindow: InfoWindow(title: element.name, snippet: element.address),
        position: element.locationCoords,
      ));
    });

    // Initialize filteredExamples with all examples initially
    filteredExamples = exnames;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_pageController.page?.toInt() != prevPage) {
      setState(() {
        prevPage = _pageController.page!.toInt();
        moveCamera();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        
        title: Text(
          'Clothing Centers',
          style: GoogleFonts.acme(fontSize: 30),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
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
              itemCount: filteredExamples.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildCenterItem(index);
              },
            ),
          ),
          Expanded(
            flex: 7,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(28.7041, 77.1025),
                zoom: 12.0,
              ),
              onMapCreated: mapCreated,
              markers: Set.from(allMarkers),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewExample,
        child: Icon(Icons.add),
      ),
    );
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
                backgroundImage: (filteredExamples[index].image as Image).image,
                radius: 30,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      filteredExamples[index].name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(filteredExamples[index].address),
                    SizedBox(height: 4),
                    Text(filteredExamples[index].no),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void mapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }

  void moveCamera() {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: filteredExamples[_pageController.page!.toInt()].locationCoords,
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0,
      ),
    ));
  }

  void _updateSearch(String query) {
    setState(() {
      filteredExamples = searchExamples(query);
    });
  }

  void _addNewExample() {
    // Implement logic to add a new Example
    // For example:
    // showDialog(...);
    // Inside the dialog, use addNewExample method from example.dart to add a new Example
  }
}
