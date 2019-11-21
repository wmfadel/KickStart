import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kick_start/providers/countries_provider.dart';
import 'package:provider/provider.dart';
import '../models/country.dart';

class CountryItem extends StatefulWidget {
  final Country _country;

  CountryItem(this._country);

  @override
  _CountryItemState createState() => _CountryItemState();
}

class _CountryItemState extends State<CountryItem> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CountriesProvider>(builder: (ctx, provider, ch) {
      return InkWell(
        splashColor: Colors.blueAccent,
        onTap: () {
          setState(() {
            if (provider.isFavorite(widget._country.code)) {
              provider.removeFromFavorite(widget._country.code);
            } else {
              provider.addToFavorite(widget._country.code);
            }
          });
        },
        child: Container(
          height: 60,
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    width: 60,
                    height: 60,
                    child: widget._country.flag == null
                        ? Placeholder()
                        : SvgPicture.network(
                            widget._country.flag,
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Text(
                  widget._country.country ?? 'Wolrd, World cup and stuff',
                  style: Theme.of(context).textTheme.body2,
                ),
              ),
              Container(
                width: 20,
                height: 60,
                decoration: BoxDecoration(
                    color: provider.isFavorite(widget._country.code)
                        ? Colors.blueAccent
                        : Colors.redAccent,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      topRight: Radius.circular(15),
                    )),
              )
            ],
          ),
        ),
      );
    });
  }
}
