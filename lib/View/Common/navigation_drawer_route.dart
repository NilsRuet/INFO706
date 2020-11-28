import 'package:flutter/material.dart';

abstract class NavigationDrawerRoute{
    String getViewName();
    Widget build();
}
