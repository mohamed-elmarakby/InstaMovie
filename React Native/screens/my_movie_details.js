import React from "react";
import {
  StyleSheet,
  Text,
  TouchableOpacity,
  View,
  ScrollView,
  Image,
  TextInput,
  Pressable,
} from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import Header from "../components/header";

export default function MyMovieDetails({ route, navigation }) {
  const { title, date, overview, poster } = route.params;
  return (
    <View style={styles.container}>
      <Header />
      <View style={{ paddingHorizontal: 12 }}>
        <Pressable
          style={styles.back}
          onPress={() => {
            navigation.navigate("myMovies");
          }}
        >
          <Text style={{ color: "black", fontWeight: "bold", fontSize: 16 }}>
            Back
          </Text>
        </Pressable>
      </View>
      <ScrollView style={styles.body}>
        <View style={{ paddingRight: 12 }}>
          <Image
            style={{ height: 350, width: "100%", borderRadius: 10 }}
            resizeMode="stretch"
            source={{
              uri: poster,
            }}
          />
        </View>
        <View>
          <Text style={styles.title}>{title}</Text>
        </View>
        <View>
          <Text style={styles.date}>{date}</Text>
        </View>
        <View>
          <Text style={styles.overview}>{overview}</Text>
        </View>
      </ScrollView>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    backgroundColor: "black",
    flex: 1,
  },
  title: {
    color: "#FFDE59",
    paddingVertical: 12,
    fontSize: 21,
    fontWeight: "bold",
  },
  date: {
    color: "#FFFFFF60",
    fontSize: 14,
    paddingBottom: 8,
    fontWeight: "bold",
  },
  overview: {
    color: "#76767680",
    fontSize: 14,
    fontWeight: "bold",
    paddingBottom: 40,
  },
  body: {
    padding: 12,
  },
  primaryOp40: {
    color: "#FFDE5940",
    paddingTop: 12,
    // paddingStart: 12,
    fontSize: 16,
    fontWeight: "bold",
  },
  back: {
    alignItems: "center",
    justifyContent: "flex-start",
    paddingVertical: 12,
    width: 125,
    borderRadius: 4,
    elevation: 3,
    color: "black",
    backgroundColor: "#FFDE59",
  },
});
