import React, { useEffect, useState } from "react";
import Routes from "./routes/route";
import {
  Image,
  FlatList,
  Text,
  View,
  StyleSheet,
  SafeAreaView,
  StatusBar,
  TouchableOpacity,
} from "react-native";
import { MaterialIcons } from "@expo/vector-icons";
import { Appbar } from "react-native-paper";
import Header from "./components/header";

export default function App() {
  StatusBar.setBarStyle("light-content", true);

  return <Routes />;
}
