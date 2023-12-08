
import { Connection, PublicKey } from '@solana/web3.js';
import { Token } from '@solana/spl-token';

// Solanaネットワークとの接続を作成
const connection = new Connection('https://api.mainnet-beta.solana.com');

// Berryトークンの公開鍵（これはBerryトークンの実際の公開鍵に置き換えてください）
const berryTokenPublicKey = new PublicKey('YourBerryTokenPublicKey');

// 送信者と受信者のウォレット公開鍵（これらは実際の公開鍵に置き換えてください）
const senderWalletPublicKey = new PublicKey('YourSenderWalletPublicKey');
const receiverWalletPublicKey = new PublicKey('YourReceiverWalletPublicKey');

// Berryトークンのインスタンスを作成
const berryToken = new Token(connection, berryTokenPublicKey, 'spl-token', senderWalletPublicKey);

// 送信者と受信者のトークンアカウントアドレスを取得（これらは実際のトークンアカウントアドレスに置き換えてください）
const senderTokenAccountAddress = new PublicKey('YourSenderTokenAccountAddress');
const receiverTokenAccountAddress = new PublicKey('YourReceiverTokenAccountAddress');

// 送信者のウォレット秘密鍵（これは実際の秘密鍵に置き換えてください）
const senderWalletSecretKey = Uint8Array.from([/* YourSenderWalletSecretKey */]);

// トークンを送信
const amountToSend = YourAmountToSend;  // 送信するトークンの量
const transaction = await berryToken.transfer(senderTokenAccountAddress, receiverTokenAccountAddress, senderWalletPublicKey, senderWalletSecretKey, amountToSend);