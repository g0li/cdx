import 'package:flutter/material.dart';

class CDXChippy extends StatefulWidget {
  final List<String> reportList;
  final Function(String) onSelectionChanged;
  CDXChippy(this.reportList, {this.onSelectionChanged});
  @override
  _CDXChippyState createState() => _CDXChippyState();
}

class _CDXChippyState extends State<CDXChippy> {
  String selectedChoice = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.blueGrey.shade700,
          height: 60,
          child: ListView.builder(
            itemCount: widget.reportList.length,
            itemBuilder: (ctx, i) {
              return Container(
                padding: const EdgeInsets.all(2.0),
                child: ChoiceChip(
                  backgroundColor: Colors.blueGrey,
                  selectedColor: Colors.blueGrey.shade900,
                  label: Text(widget.reportList[i],
                      style: TextStyle(color: Colors.white60)),
                  selected: selectedChoice == widget.reportList[i],
                  onSelected: (selected) {
                    setState(() {
                      selectedChoice = widget.reportList[i];
                      widget.onSelectionChanged(selectedChoice);
                    });
                  },
                ),
              );
            },
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
          ),
          width: double.maxFinite,
        ),
      ],
    );
  }
}
