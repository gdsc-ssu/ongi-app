import React from 'react';
import {View, Text, Button} from 'react-native';
import {StackNavigationProp} from '@react-navigation/stack';

type HomeScreenNavigationProp = StackNavigationProp<{Detail: {itemId: number}}>;

type Props = {
  navigation: HomeScreenNavigationProp;
};

export default function HomeScreen({navigation}: Props) {
  return (
    <View>
      <Text>홈 화면</Text>
      <Button
        title="상세 화면으로 이동"
        onPress={() => navigation.navigate('Detail', {itemId: 42})}
      />
    </View>
  );
}
