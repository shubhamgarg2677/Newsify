
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:newsify/Model/Articles.dart';

class BookmarkModel extends ChangeNotifier
{
  List<Articles> _items=new List<Articles>();

  UnmodifiableListView<Articles> get items => UnmodifiableListView(_items);

   void add(Articles item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
    void deleteItem(int pos)
    {
      _items.removeAt(pos);

      notifyListeners();
    }

  /// Removes all items from the cart.
  void removeAll() {
    _items.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

}