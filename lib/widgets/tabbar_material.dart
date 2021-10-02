import 'package:flutter/material.dart';

class TabBarMaterial extends StatefulWidget {
  final int index;
  final ValueChanged<int> onChangedTab;
  const TabBarMaterial(
      {required this.index, required this.onChangedTab, Key? key})
      : super(key: key);

  @override
  _TabBarMaterialState createState() => _TabBarMaterialState();
}

class _TabBarMaterialState extends State<TabBarMaterial> {
  Widget buildTabItem({required int index, required IconData icon}) {
    final isSelected = index == widget.index;
    return IconTheme(
      data: IconThemeData(
          color: isSelected
              ? Theme.of(context).colorScheme.secondary
              : Colors.grey),
      child: IconButton(
        onPressed: () => widget.onChangedTab(index),
        icon: Icon(icon),
      ),
    );
  }

  final placeholder = const Opacity(
      opacity: 0,
      child: IconButton(onPressed: null, icon: Icon(Icons.no_cell)));
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      // shape: const CircularNotchedRectangle(),
      // notchMargin: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildTabItem(index: 0, icon: Icons.home_filled),
          buildTabItem(index: 1, icon: Icons.favorite_rounded),
          placeholder,
          buildTabItem(index: 2, icon: Icons.assignment_rounded),
          buildTabItem(index: 3, icon: Icons.person_rounded),
        ],
      ),
    );
  }
}
