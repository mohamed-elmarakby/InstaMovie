import React from "react";
import { NavigationContainer } from "@react-navigation/native";
import { createStackNavigator } from "@react-navigation/stack";
import HomeScreen from "../screens/home_screen";
import MovieDetails from "../screens/movie_details";
import MyMovies from "../screens/my_movies";
import AddMovie from "../screens/add_movie";
import { SafeAreaProvider } from "react-native-safe-area-context";
import LoginScreen from "../screens/login";
import RegisterScreen from "../screens/register";
import MyMovieDetails from "../screens/my_movie_details";

const Stack = createStackNavigator();

export default function route() {
  return (
    <SafeAreaProvider>
      <NavigationContainer>
        <Stack.Navigator screenOptions={{ headerShown: false }}>
          <Stack.Screen
            name="login"
            component={LoginScreen}
            options={{ headerShown: false }}
          />
          <Stack.Screen
            name="register"
            component={RegisterScreen}
            options={{ headerShown: false }}
          />
          <Stack.Screen
            name="home"
            component={HomeScreen}
            options={{ headerShown: false }}
          />
          <Stack.Screen
            name="details"
            component={MovieDetails}
            options={{ headerShown: false }}
          />
          <Stack.Screen
            name="myDetails"
            component={MyMovieDetails}
            options={{ headerShown: false }}
          />
          <Stack.Screen
            name="myMovies"
            component={MyMovies}
            options={{ headerShown: false }}
          />
          <Stack.Screen
            name="addMovie"
            component={AddMovie}
            options={{ headerShown: false }}
          />
        </Stack.Navigator>
      </NavigationContainer>
    </SafeAreaProvider>
  );
}
