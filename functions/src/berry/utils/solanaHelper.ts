// solanaHelper.ts
import {
  TOKEN_PROGRAM_ID,
  ASSOCIATED_TOKEN_PROGRAM_ID,
  Token,
} from "@solana/spl-token"; // SolanaのSPLトークンから必要な定数をインポート

import {
  Connection,
  PublicKey,
  Keypair,
} from "@solana/web3.js"; // Solanaのweb3.jsから必要なクラスをインポート

const CONNECTION = new Connection(
  "https://api.mainnet-beta.solana.com"
); // Solanaのメインネットへの接続を作成
const TOKEN_MINT_ADDRESS = "YourTokenMintAddressHere"; // あなたのトークンのMintアドレス
const MINT_AUTHORITY_KEY =
  process.env.MINT_AUTHORITY_SECRET_KEY as string; // Mint権限の秘密鍵を環境変数から取得
const parsedKey = new Uint8Array(
  JSON.parse(MINT_AUTHORITY_KEY)
); // 秘密鍵をUint8Arrayに変換
const MINT_AUTHORITY = Keypair.fromSecretKey(parsedKey); // 秘密鍵からKeypairを作成
const MAX_SUPPLY = 3300000000; // 33億berry

// トークンを発行する関数
/**
 * @param {string} mintPublicKey
 * @param {string} destinationPublicKey
 * @param {number} amount
 * @return {Promise<void>}
 */
async function mintToken(
  mintPublicKey: string,
  destinationPublicKey: string,
  amount: number
): Promise<void> {
  const mint = new PublicKey(mintPublicKey); // Mintの公開鍵を作成
  const destination = new PublicKey(destinationPublicKey); // 宛先の公開鍵を作成
  const token = new Token(
    CONNECTION,
    mint,
    TOKEN_PROGRAM_ID,
    MINT_AUTHORITY
  ); // Tokenインスタンスを作成

  // 現在のトークンの供給量を取得
  const tokenInfo = await token.getMintInfo(); // Mint情報を取得
  const currentSupply = tokenInfo.supply.toString(); // 現在の供給量を取得

  // 発行上限を超えるか確認
  if (Number(currentSupply) + amount > MAX_SUPPLY) {
    throw new Error(
      "この量を発行すると最大供給量を超えます。" // 発行上限を超える場合はエラーを投げる
    );
  }

  // トークンを発行
  const recipientAssociatedTokenAddress = await Token.getAssociatedTokenAddress(
    ASSOCIATED_TOKEN_PROGRAM_ID,
    TOKEN_PROGRAM_ID,
    mint,
    destination
  ); // 宛先の関連トークンアドレスを取得

  await token.mintTo(
    recipientAssociatedTokenAddress,
    MINT_AUTHORITY.publicKey,
    [],
    amount
  ); // トークンを発行
}

// トークンを転送する関数
/**
 * @param {string} sourcePrivateKey
 * @param {string} destinationPublicKey
 * @param {number} amount
 * @return {Promise<void>}
 */
async function transferToken(
  sourcePrivateKey: string,
  destinationPublicKey: string,
  amount: number
): Promise<void> {
  const parsedSourceKey = new Uint8Array(
    JSON.parse(sourcePrivateKey)
  ); // 秘密鍵をUint8Arrayに変換
  const sourceAccount = Keypair.fromSecretKey(
    parsedSourceKey
  ); // 秘密鍵からKeypairを作成
  const destination = new PublicKey(
    destinationPublicKey
  ); // 宛先の公開鍵を作成

  const token = new Token(
    CONNECTION,
    new PublicKey(TOKEN_MINT_ADDRESS),
    TOKEN_PROGRAM_ID,
    sourceAccount
  ); // Tokenインスタンスを作成

  // トークンを転送
  await token.transfer(
    sourceAccount.publicKey,
    destination,
    sourceAccount,
    [],
    amount
  ); // トークンを転送
}

export {
  mintToken,
  transferToken,
}; // 関数をエクスポート
