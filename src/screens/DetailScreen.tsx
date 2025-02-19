import React from 'react';
import {View, Text} from 'react-native';
import {RouteProp} from '@react-navigation/native';

type DetailScreenRouteProp = RouteProp<{Detail: {itemId: number}}, 'Detail'>;

type Props = {
  route: DetailScreenRouteProp;
};

export default function DetailScreen({route}: Props) {
  const {itemId} = route.params;

  return (
    <View>
      <Text>📄 상세 화면</Text>
      <Text>받은 ID: {itemId}</Text>
    </View>
  );
}
