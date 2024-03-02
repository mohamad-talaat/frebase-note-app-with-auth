import 'package:flutter/material.dart';

class cardNotes extends StatelessWidget {
  final String name;
  Function()? onTap;
  Function()? iconButtonMethod;
  Function()? onDismiss;

  cardNotes({
    required this.name,
    this.onTap,
    this.onDismiss,
    this.iconButtonMethod,
  });
  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) => onDismiss,
        direction: DismissDirection.horizontal, // اتجاه السحب (أفقي)
        child: Row(children: [
          // SizedBox(height: 10,),
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                width: 160,
                height: 150,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white70, width: 3),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white70,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                        image: AssetImage("assets/images/egyptionFootball.png"),
                        width: 90,
                        height: 90),
                    Expanded(
                        child: Center(
                      child: Text(
                        "${name}",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                        overflow:
                            TextOverflow.ellipsis, // Adjust overflow handling
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
        ]));
  }
}

class cardSmallNotes extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final Function()? onTap;
  final Function()? iconButtonMethod;
  final Function()? onDismiss;

  cardSmallNotes({
    required this.name,
    this.imageUrl,
    this.onTap,
    this.onDismiss,
    this.iconButtonMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) => onDismiss,
      direction: DismissDirection.horizontal,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            width: 160,
            height: 150,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white70, width: 3),
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      "$name",
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        textBaseline: TextBaseline.alphabetic,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                if (imageUrl != null && imageUrl != "none")
                  Image.network(
                    imageUrl!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                if (imageUrl == null && imageUrl == "none") Text("")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
