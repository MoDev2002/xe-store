import 'package:flutter/material.dart';

import '../models/drawer_item.dart';

class DrawerWidget extends StatelessWidget {
  final ValueChanged<DrawerItem> onSelectedItem;
  final int selectedIndex;

  const DrawerWidget(this.selectedIndex,
      {required this.onSelectedItem, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 15, bottom: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                child: Image.asset('assets/images/circle-cropped.png'),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Mohamed El Masry',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Active status',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  )
                ],
              )
            ],
          ),
          _buildDrawerItems(context),
          ListTile(
            onTap: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Logging Out')));
            },
            leading: const Icon(
              Icons.exit_to_app_rounded,
              color: Colors.white,
              size: 28,
            ),
            title: const Text(
              'Sign Out',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDrawerItems(BuildContext context) => Column(
        children: DrawerItems.all
            .map((item) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () => onSelectedItem(item),
                    title: Text(
                      item.title,
                      style: TextStyle(
                          color: selectedIndex == item.index
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                          fontSize: 20),
                    ),
                    leading: Icon(
                      item.icon,
                      color: selectedIndex == item.index
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                      size: 28,
                    ),
                  ),
                ))
            .toList(),
      );
}
