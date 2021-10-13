import 'package:flutter/material.dart';

class TabBarMaterial extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChangedTab;
  const TabBarMaterial(
      {required this.index, required this.onChangedTab, Key? key})
      : super(key: key);

  Widget buildTabItem(BuildContext context,
      {required int index, required IconData icon}) {
    final isSelected = index == this.index;
    return IconTheme(
      data: IconThemeData(
          color:
              isSelected ? Theme.of(context).colorScheme.primary : Colors.grey),
      child: IconButton(
        onPressed: () => onChangedTab(index),
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
          buildTabItem(context, index: 0, icon: Icons.home_filled),
          buildTabItem(context, index: 1, icon: Icons.favorite_rounded),
          placeholder,
          buildTabItem(context, index: 2, icon: Icons.assignment_rounded),
          buildTabItem(context, index: 3, icon: Icons.person_rounded),
        ],
      ),
    );
  }
}
