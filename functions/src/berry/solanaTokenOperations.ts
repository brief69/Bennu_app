import {
  TOKEN_PROGRAM_ID,
  Token,
} from "@solana/spl-token";

// トークン関連の操作を行うための関数をインポート
const getAssociatedTokenAddress = Token.getAssociatedTokenAddress;
const mintTo = Token.createMintToInstruction;
const transfer = Token.createTransferInstruction;

import {
  Connection,
  PublicKey,
  Keypair,
  Transaction,
  sendAndConfirmTransaction,
} from "@solana/web3.js";

// Solanaのメインネットへの接続を作成
const CONNECTION = new Connection("https://api.mainnet-beta.solana.com");
// 環境変数からMINT_AUTHORITY_SECRET_KEYを取得
const MINT_AUTHORITY_KEY = process.env.MINT_AUTHORITY_SECRET_KEY as string;
// MINT_AUTHORITY_SECRET_KEYをUint8Arrayに変換
const parsedKey = new Uint8Array(JSON.parse(MINT_AUTHORITY_KEY));
// MINT_AUTHORITY_SECRET_KEYからKeypairを作成
const MINT_AUTHORITY = Keypair.fromSecretKey(parsedKey);
// トークンの最大供給量を設定
const MAX_SUPPLY = 3300000000; 

// トークンを発行する関数
/**
 * トークンを発行する関数
 * @param {string} mintPublicKey - 発行するトークンの公開鍵
 * @param {string} destinationPublicKey - トークンを受け取るアカウントの公開鍵
 * @param {number} amount - 発行するトークンの量
 * @returns {Promise<void>} - Promiseが解決するとトークンが発行されます
 */
export async function mintToken(
  mintPublicKey: string,
  destinationPublicKey: string,
  amount: number
): Promise<void> {
  // 公開鍵からPublicKeyを作成
  const mint = new PublicKey(mintPublicKey);
  const destination = new PublicKey(destinationPublicKey);

  // 現在のトークンの供給量を取得
  const mintInfo = await CONNECTION.getParsedTokenAccountsByOwner(mint, {programId: TOKEN_PROGRAM_ID});
  const currentSupply = mintInfo.value[0].account.data.parsed.info.supply;

  // 発行上限を超えるか確認
  if (currentSupply + amount > MAX_SUPPLY) {
    throw new Error("この量を発行すると最大供給量を超えます。");
  }

  // トークンを発行
  const newRecipientAssociatedTokenAddress = await getAssociatedTokenAddress(
    TOKEN_PROGRAM_ID,
    mint,
    destination,
    MINT_AUTHORITY.publicKey
  );

  const mintInstruction = mintTo(
    TOKEN_PROGRAM_ID,
    mint,
    newRecipientAssociatedTokenAddress,
    MINT_AUTHORITY.publicKey,
    [],
    amount
  );

  const mintTransaction = new Transaction().add(mintInstruction);
  await sendAndConfirmTransaction(CONNECTION, mintTransaction, [MINT_AUTHORITY]);


  // トークンを転送する関数
  async function transferToken(
    sourcePrivateKey: string,
    destinationPublicKey: string,
    amount: number
  ): Promise<void> {
    const parsedSourceKey = new Uint8Array(JSON.parse(sourcePrivateKey));
    const sourceAccount = Keypair.fromSecretKey(parsedSourceKey);
    const destination = new PublicKey(destinationPublicKey);
  
    // トークンを転送する命令を作成
    const transferInstruction = transfer(
      TOKEN_PROGRAM_ID,
      sourceAccount.publicKey,
      destination,
      sourceAccount.publicKey,
      [],
      amount
    );
  
    // トランザクションを作成し実行
    const transferTransaction = new Transaction().add(transferInstruction);
    await sendAndConfirmTransaction(CONNECTION, transferTransaction, [sourceAccount]);
  }
  
  export { mintToken, transferToken };


