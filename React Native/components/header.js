import React from 'react';
import {Text, View, StyleSheet} from 'react-native';
export default function Header() {
    return (
        <View style= {styles.header}>
        <Text style= {styles.title}>InstaMovies</Text>
        </View>
    )
}

const styles = StyleSheet.create({
    header: {
        backgroundColor: 'black',
        height: 80,
        paddingTop: 40,
    },
    title: {
        color: '#FFDE59',
        textAlign: 'center',
        fontSize: 20,
        fontWeight: 'bold',
    }
})