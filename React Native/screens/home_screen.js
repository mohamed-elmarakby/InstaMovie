import React, { useEffect, useState, useCallback } from "react";
import {
  Image,
  FlatList,
  Text,
  View,
  StyleSheet,
  SafeAreaView,
  StatusBar,
  Button,
  Pressable,
  TouchableOpacity,
} from "react-native";
import { MaterialIcons } from "@expo/vector-icons";
import { Appbar } from "react-native-paper";
import Header from "../components/header";
import { useFocusEffect } from "@react-navigation/native";
var currentPage = 1;
var data = [];
global.myMovieLists = [];
const ListFooterComponent = () => (
  <Text
    style={{
      fontSize: 20,
      fontWeight: "bold",
      textAlign: "center",
      color: "white",
      paddingBottom: 40,
    }}
  >
    Loading More...
  </Text>
);
export default function HomeScreen({ navigation }) {
  const [isLoading, setisLoading] = useState(true);
  const [myMovies, setmyMovies] = useState([]);
  const [data, setdata] = useState([]);
  const [page, setpage] = useState(1);

  getMyMovies = () => {
    setmyMovies([]);
  };
  LoadData = () => {
    fetch(
      "http://api.themoviedb.org/3/discover/movie?api_key=acea91d2bff1c53e6604e4985b6989e2&page=1"
    )
      .then((response) => response.json())
      .then((json) => {
        setdata(data.concat(json.results));
        console.log(json.results);
        setpage(json.page);
      })
      .catch((error) => console.error(error))
      .finally(() => {
        setisLoading(false);
      });
  };

  // useEffect(() => {
  //   setdata([]);
  //   LoadData();
  //   // getMyMovies();
  // }, []);
  useFocusEffect(
    useCallback(() => {
      setdata([]);
      LoadData();
    }, [])
  );
  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.container}>
        <Header />
        <View
          style={
            myMovieLists.length == 0 ? { height: "20%" } : { height: "35%" }
          }
        >
          <View
            style={{
              flexDirection: "row",
              width: "100%",
            }}
          >
            <Text style={{ flex: 1, color: "#FFFFFF60", fontSize: 16 }}>
              {"My Movies"}
            </Text>
            <TouchableOpacity onPress={() => navigation.navigate("myMovies")}>
              <Text style={{ color: "#FFFFFF60", fontSize: 16 }}>
                {"See All >"}
              </Text>
            </TouchableOpacity>
          </View>
          {global.myMovieLists.length == 0 ? (
            <View>
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
            <View>
              <FlatList
                horizontal
                data={global.myMovieLists}
                style={{
                  flexDirection: "row",
                  width: "100%",
                  height: "100%",
                }}
                keyExtractor={({ id }, index) => id + index}
                renderItem={({ item }) => (
                  <View
                    style={[
                      styles.item,
                      {
                        flexDirection: "column",
                        width: 150,
                        flex: 1,
                        // padding: 12
                      },
                    ]}
                  >
                    <View style={{ paddingRight: 12 }}>
                      <Image
                        style={{
                          aspectRatio: 1,
                          width: "100%",
                          borderRadius: 10,
                        }}
                        source={{
                          uri: item.poster_path,
                        }}
                      />
                    </View>

                    <View>
                      <Text
                        style={{
                          aspectRatio: 2 / 5,
                          color: "#FFDE59",
                          fontSize: 16,
                        }}
                      >
                        {item.title}
                      </Text>
                    </View>
                  </View>
                )}
              />
            </View>
          )}
        </View>
        <View
          style={{
            borderBottomColor: "#FFFFFF60",
            borderBottomWidth: 1,
            paddingTop: 12,
          }}
        ></View>
        <View
          style={{
            flexDirection: "row",
            width: "100%",
          }}
        >
          <Text style={{ flex: 1, color: "#FFFFFF60", fontSize: 16 }}>
            {"All Movies"}
          </Text>
        </View>
        <View style={{ flex: 3 }}>
          <FlatList
            data={data}
            ListFooterComponent={() => isLoading && <ListFooterComponent />}
            keyExtractor={({ id }, index) => id.toString() + index}
            renderItem={({ item }) => (
              <TouchableOpacity
                onPress={() => {
                  navigation.navigate("details", {
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
                      style={{ width: "100%", height: 100, borderRadius: 10 }}
                      source={{
                        uri:
                          "https://image.tmdb.org/t/p/w185_and_h278_bestv2" +
                          item.poster_path,
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
                    <View>
                      <Text style={{ color: "#FFFFFF60" }}>
                        {item.adult ? "Adults Only" : "Family Movie"}
                      </Text>
                    </View>
                    <View>
                      <Text style={{ color: "#FFFFFF60" }}>
                        {"Language: " + item.original_language.toUpperCase()}
                      </Text>
                    </View>
                    <View>
                      <Text style={{ color: "#FFFFFF60" }}>
                        <MaterialIcons
                          name="star"
                          style={{ color: "#FFDE59" }}
                        />{" "}
                        {item.vote_average}
                      </Text>
                    </View>
                  </View>
                </View>
              </TouchableOpacity>
            )}
            onEndReachedThreshold={0.01}
            onEndReached={(info) => {
              setisLoading(true);
              setTimeout(() => {
                console.log(currentPage);
                currentPage = currentPage + 1;
                console.log(currentPage);
                console.log(isLoading);
                fetch(
                  "http://api.themoviedb.org/3/discover/movie?api_key=acea91d2bff1c53e6604e4985b6989e2&page=" +
                    currentPage +
                    ""
                )
                  .then((response) => response.json())
                  .then((json) => {
                    setdata([...data, ...json.results]);
                    setpage(json.page);
                  })
                  .catch((error) => console.error(error))
                  .finally(() => {
                    setisLoading(false);
                  });
              }, 1000);
            }}
          />
        </View>
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "black",
    paddingHorizontal: 8,
  },
  appBar: {
    backgroundColor: "black",
    left: 0,
    right: 0,
    top: 0,
    bottom: 0,
    alignItems: "center",
    justifyContent: "center",
  },
  item: {
    width: "100%",
    paddingHorizontal: 0,
    paddingVertical: 16,
  },
  loading: {
    position: "absolute",
    backgroundColor: "white",
    left: 0,
    right: 0,
    top: 0,
    bottom: 0,
    alignItems: "center",
    justifyContent: "center",
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
