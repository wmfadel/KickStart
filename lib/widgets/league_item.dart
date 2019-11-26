import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/league.dart';

class LeagueItem extends StatelessWidget {
  final League _league;

  LeagueItem(this._league);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
          borderRadius: BorderRadius.circular(10),
          clipBehavior: Clip.hardEdge,
          elevation: 10,
          child: Container(
            width: _size.width,
            height: 270,
            //  padding: EdgeInsets.all(8),
            child: Stack(
              children: <Widget>[

                if(_league.logo != null)
                  Positioned(
                    top: 70,
                    left: _size.width*0.45,
                    child: Image.network(
                      _league.logo,
                      width: _size.width * 0.45,
                      height: 200,
                    ),
                  ),
                Container(
                  height: 280,
                  width: _size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.deepOrange,
                      Colors.deepOrange.withOpacity(0.6),
                    ],
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 30,right: 40,bottom: 10),
                        child: Text(
                          '${_league.name}, ${_league.country}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      Text(
                        'Fromt:${_league.seasonStart}, To: ${_league.seasonEnd}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),


                    ],
                  ),
                ),
                if (_league.flag != null)
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(top: 8, right: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          width: 48,
                          height: 48,

                          child:  SvgPicture.network(
                           _league.flag,
                            height: 45,
                            width: 45,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  )
              ],
            ),
          )),
    );
  }
}
