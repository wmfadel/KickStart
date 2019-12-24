import 'package:flutter/material.dart';
import 'package:kick_start/models/transfer.dart';

class TransferItem extends StatelessWidget {
  final Transfer transfer;
  final int teamId;
  TransferItem(this.transfer, this.teamId);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Material(
        color: Colors.white,
        elevation: 10,
        borderRadius: BorderRadius.circular(15),
        clipBehavior: Clip.hardEdge,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 220,
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(transfer.playerName,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: transfer.teamIn.teamId == teamId
                          ? Colors.green
                          : Colors.red)),
              if (transfer.type != null)
                Text(transfer.type,
                    style: TextStyle(
                      fontSize: 20,
                    )),
              SizedBox(height: 5),
              if (transfer.transferDate != null)
                Text(transfer.transferDate,
                    style: TextStyle(fontSize: 23, color: Colors.black)),
// Flag:  https://media.api-football.com/teams/541.png
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Image.network(
                    'https://media.api-football.com/teams/${transfer.teamIn.teamId}.png',
                    height: 95,
                    fit: BoxFit.fitHeight,
                  ),
                  Icon(
                    Icons.arrow_left,
                    size: 50,
                    color: transfer.teamIn.teamId == teamId
                        ? Colors.green
                        : Colors.red,
                  ),
                  Image.network(
                    'https://media.api-football.com/teams/${transfer.teamOut.teamId}.png',
                    height: 95,
                    fit: BoxFit.fitHeight,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
