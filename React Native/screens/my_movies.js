import React from "react";
import {
  StyleSheet,
  Text,
  TouchableOpacity,
  View,
  FlatList,
  Image,
  TextInput,
  Pressable,
} from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import Header from "../components/header";

export default function MyMovies({ route, navigation }) {
  // useFocusEffect(useCallback(() => {}, []));
  return (
    <View style={styles.container}>
      <Header />
      <View style={{ paddingHorizontal: 12 }}>
        <Pressable
          style={styles.back}
          onPress={() => {
            navigation.navigate("home");
          }}
        >
          <Text style={{ color: "black", fontWeight: "bold", fontSize: 16 }}>
            Back
          </Text>
        </Pressable>
      </View>
      <View style={{}}>
        {global.myMovieLists.length == 0 ? (
          <View style={{ paddingHorizontal: "8%" }}>
            <View>
              <Text style={styles.title}>You Don't Have Any Movies Yet</Text>
            </View>
            <Pressable
              style={styles.button}
              onPress={() => {
                navigation.navigate("addMovie");
              }}
            >
              <Text
                style={{ color: "black", fontWeight: "bold", fontSize: 16 }}
              >
                Add One
              </Text>
            </Pressable>
          </View>
        ) : (
          <View style={{ paddingTop: 12 }}>
            <Pressable
              style={styles.button}
              onPress={() => {
                navigation.navigate("addMovie");
              }}
            >
              <Text
                style={{ color: "black", fontWeight: "bold", fontSize: 16 }}
              >
                Add New One
              </Text>
            </Pressable>
            <FlatList
              style={{ paddingTop: 12 }}
              data={global.myMovieLists}
              keyExtractor={({ id }, index) => id.toString() + index}
              renderItem={({ item }) => (
                <View style={{ padding: 12 }}>
                  <TouchableOpacity
                    onPress={() => {
                      navigation.navigate("myDetails", {
                        title: item.title,
                        date: item.release_date,
                        overview: item.overview,
                        poster: item.poster_path,
                      });
                    }}
                  >
                    <View
                      style={[
                        styles.item,
                        {
                          flexDirection: "row",
                        },
                      ]}
                    >
                      <View style={{ flex: 1, paddingRight: 12 }}>
                        <Image
                          style={{
                            width: "100%",
                            height: 100,
                            borderRadius: 10,
                          }}
                          source={{
                            uri: item.poster_path,
                          }}
                        />
                      </View>
                      <View
                        style={{
                          flexDirection: "column",
                          flex: 3,
                        }}
                      >
                        <View>
                          <Text style={{ color: "#FFDE59", fontSize: 16 }}>
                            {item.title}
                          </Text>
                        </View>
                        <View>
                          <Text style={{ color: "#FFFFFF60", fontSize: 12 }}>
                            Release Date: {item.release_date}
                          </Text>
                        </View>
                      </View>
                    </View>
                  </TouchableOpacity>
                </View>
              )}
            />
          </View>
        )}
      </View>
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
  title: {
    color: "#FFDE5940",
    paddingTop: 24,
    paddingBottom: 12,
    fontSize: 18,
    alignSelf: "center",
    fontWeight: "bold",
  },
  button: {
    alignItems: "center",
    justifyContent: "center",
    paddingVertical: 12,
    paddingHorizontal: 32,
    borderRadius: 4,
    elevation: 3,
    color: "black",
    backgroundColor: "#FFDE59",
  },
});
