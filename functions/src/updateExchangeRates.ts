import * as functions from 'firebase-functions';
import axios from 'axios';

// 為替レートを取得する関数
async function fetchExchangeRate() {
  try {
    const response = await axios.get('https://api.exchangeratesapi.io/latest?base=JPY');
    const rates = response.data.rates;
    // ここでFirebaseのデータベースにレートを保存する
    // 例: Firestore, Realtime Database, etc.
    console.log('Exchange Rates Updated:', rates);
  } catch (error) {
    console.error('Error fetching exchange rate:', error);
  }
}

// 毎週火曜日に実行されるスケジュールされた関数
export const scheduledFunction = functions.pubsub.schedule('every tuesday 00:00').timeZone('Asia/Tokyo').onRun((context) => {
  console.log('This will be run every Tuesday at 00:00 Tokyo time!');
  fetchExchangeRate();
});
