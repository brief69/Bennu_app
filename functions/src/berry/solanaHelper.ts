// solanaHelper.ts
import {
  TOKEN_PROGRAM_ID,
  ASSOCIATED_TOKEN_PROGRAM_ID,
} from "@solana/spl-token";

import {
  Connection,
  PublicKey,
  Keypair,
} from "@solana/web3.js";

const CONNECTION = new Connection("https://api.mainnet-beta.solana.com");
const TOKEN_MINT_ADDRESS = "YourTokenMintAddressHere"; // あなたのトークンのMintアドレス
const MINT_AUTHORITY_KEY = process.env.MINT_AUTHORITY_SECRET_KEY as string;
const parsedKey = new Uint8Array(JSON.parse(MINT_AUTHORITY_KEY));
const MINT_AUTHORITY = Keypair.fromSecretKey(parsedKey);
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
  const mint = new PublicKey(mintPublicKey);
  const destination = new PublicKey(destinationPublicKey);
  const Token = require('@solana/spl-token').Token;
  const token = new Token(
    CONNECTION,
    mint,
    TOKEN_PROGRAM_ID,
    MINT_AUTHORITY
  );

  // 現在のトークンの供給量を取得
  const tokenInfo = await token.getMintInfo();
  const currentSupply = tokenInfo.supply.toNumber();

  // 発行上限を超えるか確認
  if (currentSupply + amount > MAX_SUPPLY) {
    throw new Error("Minting this amount would exceed the maximum supply.");
  }

  // トークンを発行
  const recipientAssociatedTokenAddress = await token.getAssociatedTokenAddress(
    ASSOCIATED_TOKEN_PROGRAM_ID,
    TOKEN_PROGRAM_ID,
    mint,
    destination
  );

  await token.mintTo(
    recipientAssociatedTokenAddress,
    MINT_AUTHORITY.publicKey,
    [],
    amount
  );
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
  const parsedSourceKey = new Uint8Array(JSON.parse(sourcePrivateKey));
  const sourceAccount = Keypair.fromSecretKey(parsedSourceKey);
  const destination = new PublicKey(destinationPublicKey);

  const token = new token(
    CONNECTION,
    new PublicKey(TOKEN_MINT_ADDRESS),
    TOKEN_PROGRAM_ID,
    sourceAccount
  );

  // トークンを転送
  await token.transfer(
    sourceAccount.publicKey,
    destination,
    sourceAccount,
    [],
    amount
  );
}

export {
  mintToken,
  transferToken,
};
