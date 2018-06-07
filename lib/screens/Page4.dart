import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:convert' as convert;
import 'package:flutter_fetch_widget/flutter_fetch_widget.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Four extends StatelessWidget {
  final storage = new FlutterSecureStorage();

  
  
  @override
  Widget build(BuildContext context) {
        return new Scaffold(
          bottomNavigationBar: new BottomAppBar(
            hasNotch: true,
            color: new Color(0xFF6200ea),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BackButton(
                  color: Colors.white,
                ),
              ],
            ),
          ),
          floatingActionButton: new FloatingActionButton(
              onPressed: () => {},
              elevation: 5.0,
              notchMargin: 7.0,
              highlightElevation: 1.0,
              backgroundColor: Colors.black,
              child: Icon(Icons.add),
          ), floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
            body: new Center(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new Container(
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                      begin: Alignment.centerLeft,
                      end:  Alignment.bottomRight,
                      colors: [
                        new Color(0xFF6ff9ff),
                        new Color(0xFF000070)
                      ]
                    )
                  ),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
                      child: new Material(
                        borderRadius: new BorderRadius.circular(100.0),
                        elevation: 5.0,
                          child: new CachedNetworkImage(
                            imageUrl: "https://avatars.io/instagram/a.i.d.x.n",
                            width: 84.0, height: 84.0,
                        ),
                      ),
                    ),
                    new Text("Aidan"),
                new Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 8.0),
                child: new FetchWidget<Balance>(
                  url: "https://horizon-testnet.stellar.org/accounts/GBHLPXLJ4YR5UBDM75YYCHY4PWZWITIGPFAH7ENEY5DPMU5W6YB7M52C",
                  transform: _toPost,
                  builder: (fetchPost) {
                    if (fetchPost.isWaiting) {
                      return new Text("Loading...");
                    }
                    if (fetchPost.isDone && fetchPost.statusCode != 200) {
                      return new Text(
                        'Could not connect to API service. `${fetchPost.response.body}`'
                      );
                    }
                    return new Column(
                      children: <Widget>[
                        new Text("   ${fetchPost.data.balance}",  style: TextStyle(fontSize: 32.0, color: Colors.white)),
                        new Text(' XLM', style: TextStyle(fontSize: 18.0, color: Colors.white),),
                        new Padding(
                          padding: const EdgeInsets.fromLTRB(350.0,0.0,0.0,0.0),
                          child: new IconButton(
                            color: Colors.white,
                            onPressed: () async{ fetchPost.doFetch();
                            final user_id = await storage.read(key: 'user_id');
                            print(user_id);
                            },
                            icon: new Icon(Icons.refresh),
                          ),
                        )
                      ],
                    );
                  },
                ),
              )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

Balance _toPost(response) {
  final Map<String, dynamic> json = convert.json.decode(response.body);
  final bal = json['balances'];
  for (var items in bal) {
    Map myMap = items;
    print(myMap['balance']);
    return new Balance(myMap['balance']);
  }
}

class Balance {
  final balance;
  Balance(this.balance);
}
