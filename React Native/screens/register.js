import React from "react";
import {
  StyleSheet,
  Text,
  TouchableOpacity,
  View,
  ScrollView,
  TextInput,
  Pressable,
} from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import Header from "../components/header";

export default function RegisterScreen({ navigation }) {
  const [email, onChangeEmail] = React.useState();
  const [password, onChangepassword] = React.useState();
  const [confirmPassword, onChangeconfirmPassword] = React.useState();
  return (
    <View style={styles.container}>
      <Header />
      <View style={{ paddingHorizontal: 12 }}>
        <Pressable
          style={styles.back}
          onPress={() => {
            navigation.navigate("login");
          }}
        >
          <Text style={{ color: "black", fontWeight: "bold", fontSize: 16 }}>
            Back
          </Text>
        </Pressable>
      </View>
      <ScrollView style={styles.body}>
        <View>
          <Text style={styles.title}>Create Account</Text>
        </View>
        <View>
          <Text style={styles.primaryOp40}>Email Address</Text>
          <TextInput
            style={styles.input}
            onChangeText={onChangeEmail}
            value={email}
            placeholder="example@example.example"
            placeholderTextColor="#FFDE5940"
          />
        </View>
        <View>
          <Text style={styles.primaryOp40}>Password</Text>
          <TextInput
            style={styles.input}
            onChangeText={onChangepassword}
            value={password}
            placeholder="●●●●●●●●●●●"
            placeholderTextColor="#FFDE5940"
            secureTextEntry={true}
            password={true}
          />
        </View>
        <View style={{ paddingBottom: 21 }}>
          <Text style={styles.primaryOp40}>Confirm Password</Text>
          <TextInput
            style={styles.input}
            onChangeText={onChangeconfirmPassword}
            value={confirmPassword}
            placeholder="●●●●●●●●●●●"
            placeholderTextColor="#FFDE5940"
            secureTextEntry={true}
            password={true}
          />
        </View>

        <Pressable
          style={styles.button}
          onPress={() => {
            navigation.navigate("login");
          }}
        >
          <Text style={{ color: "black", fontWeight: "bold", fontSize: 16 }}>
            Register
          </Text>
        </Pressable>
        <View style={{ flexDirection: "row", paddingTop: 18 }}>
          <Text
            style={{
              color: "#767676",
              fontSize: 16,
            }}
          >
            Already have an account?{" "}
          </Text>
          <Text>
            <TouchableOpacity
              onPress={() => {
                navigation.navigate("login");
              }}
            >
              <Text
                style={{
                  color: "#DE2C2C",
                  fontSize: 16,
                }}
              >
                Login Now!
              </Text>
            </TouchableOpacity>
          </Text>
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
});
