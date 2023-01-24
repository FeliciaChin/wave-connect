import 'package:flutter/material.dart';

class trackOrder {
  IconData icon = Icons.home;
  String title = "";
  String subtitle = "";

  trackOrder({required this.icon, required this.title, required this.subtitle});

  trackOrder.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    title = json['title'];
    subtitle = json['subtitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    return data;
  }
}
