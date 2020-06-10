import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';

import './add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your place'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false).fetchAndSetPlaces(),
          builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting ? Center(child: CircularProgressIndicator(),)  :  Consumer<GreatPlaces>(
            builder: (context, greatPlacesData, ch) =>
                greatPlacesData.items.length <= 0 ? ch : ListView.builder(
                  itemCount: greatPlacesData.items.length,
                  itemBuilder: (ctx, index) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: FileImage(greatPlacesData.items[index].image),
                    ),
                    title: Text(greatPlacesData.items[index].title),
                    onTap: (){},
                  )
                ),
            child: Center(
              child: const Text('Got not Places yet, start adding some!'),
            ),
        ),
      ),
    );
  }
}
