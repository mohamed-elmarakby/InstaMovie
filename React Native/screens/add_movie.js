import React, { useEffect, useState } from "react";
import {
  StyleSheet,
  Text,
  TouchableOpacity,
  View,
  ScrollView,
  TextInput,
  Image,
  Pressable,
} from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import Header from "../components/header";
import * as ImagePicker from "expo-image-picker";
export default function AddMovie({ navigation }) {
  const [title, onChangeTitle] = React.useState();
  const [date, onChangeDate] = React.useState();
  const [review, onChangeReview] = React.useState();
  const [image, onChangeImage] = React.useState();
  const [resourcePath, onChangeResourcePath] = React.useState({});
  const [selectedImage, setSelectedImage] = React.useState(null);

  let openImagePickerAsync = async () => {
    let permissionResult =
      await ImagePicker.requestMediaLibraryPermissionsAsync();

    if (permissionResult.granted === false) {
      alert("Permission to access camera roll is required!");
      return;
    }

    let pickerResult = await ImagePicker.launchImageLibraryAsync();

    if (pickerResult.cancelled === true) {
      return;
    }

    setSelectedImage({ localUri: pickerResult.uri });
    onChangeImage(pickerResult.uri);
  };
  useEffect(() => {
    onChangeTitle("");
    onChangeDate("");
    onChangeReview("");
    onChangeImage("");
    setSelectedImage(null);
  }, []);
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
        <View>
          <Text style={styles.title}>Add Movie</Text>
        </View>
        <View>
          <Text style={styles.primaryOp40}>Title</Text>
          <TextInput
            style={styles.input}
            onChangeText={onChangeTitle}
            value={title}
            placeholder="The Amazing..."
            placeholderTextColor="#FFDE5940"
          />
        </View>
        <View>
          <Text style={styles.primaryOp40}>Overview</Text>
          <TextInput
            style={styles.input}
            onChangeText={onChangeReview}
            value={review}
            multiline={true}
            placeholder="This movie is about the amazing..."
            placeholderTextColor="#FFDE5940"
          />
        </View>
        <View style={{ paddingBottom: 21 }}>
          <Text style={styles.primaryOp40}>Date</Text>
          <TextInput
            style={styles.input}
            onChangeText={onChangeDate}
            value={date}
            placeholder="2022-01-12"
            placeholderTextColor="#FFDE5940"
          />
        </View>
        <View
          style={{
            paddingBottom: 21,
            flexDirection: "row",
            justifyContent: "space-between",
          }}
        >
          <View style={{ flex: 1 }}>
            <Text style={styles.primaryOp40}>Poster</Text>
            <TextInput
              style={styles.input}
              editable={false}
              onChangeText={onChangeImage}
              value={image}
              placeholder="example.JPG"
              placeholderTextColor="#FFDE5940"
            />
          </View>

          <View
            style={{
              flex: 1,
              right: 0,
              left: 0,
              top: 0,
              bottom: 0,
              paddingStart: 12,
              paddingTop: 24,
            }}
          >
            <TouchableOpacity
              onPress={openImagePickerAsync}
              style={styles.button}
            >
              <Text style={styles.buttonText}>Choose Poster</Text>
            </TouchableOpacity>
          </View>
        </View>
        <View style={{ paddingBottom: 12 }}>
          {selectedImage != null ? (
            <Image
              source={{ uri: selectedImage.localUri }}
              style={styles.thumbnail}
            />
          ) : (
            <View></View>
          )}
        </View>
        <View style={{ paddingBottom: 40 }}>
          <Pressable
            style={styles.button}
            onPress={() => {
              if (
                title == "" ||
                review == "" ||
                date == "" ||
                selectedImage == null ||
                selectedImage.localUri == ""
              ) {
                alert("Please Fill all Fields and Choose Poster");
              } else {
                global.myMovieLists.push({
                  id: Date.now().toString(),
                  overview: review,
                  poster_path: selectedImage.localUri,
                  release_date: date,
                  title: title,
                });
                navigation.navigate("myMovies");
              }
            }}
          >
            <Text style={{ color: "black", fontWeight: "bold", fontSize: 16 }}>
              Save
            </Text>
          </Pressable>
        </View>
      </ScrollView>
    </View>
  );
}

const styles = StyleSheet.create({
  input: {
    height: 40,
    // margin: 12,
    borderWidth: 1,
    borderBottomColor: "#FFDE5940",
    backgroundColor: "#FFFFFF00",
    color: "#FFDE59",
    textDecorationColor: "#FFDE5940",
    // padding: 10,
  },
  container: {
    backgroundColor: "black",
    flex: 1,
  },
  title: {
    color: "#FFDE59",
    paddingTop: 24,
    paddingBottom: 24,
    fontSize: 34,
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
  thumbnail: {
    width: 300,
    height: 300,
    borderRadius: 10,
    paddingBottom: 20,
    resizeMode: "contain",
  },
});
