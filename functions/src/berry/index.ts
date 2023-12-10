// index.ts

// Firebase 関数をインポートします
import * as firebaseFunctions from "firebase-functions";
// solana.ts ファイルから mintToken 関数をインポートします
import {mintToken} from "../solana";

// getTokenDetails 関数をエクスポートします。この関数は HTTP リクエストを受け取り、トークンの詳細を返します
export const getTokenDetails = firebaseFunctions.https.onRequest(
  async (req: never, res: any) => {
    // リクエストから mintAddress を取得します
    const mintAddress = req.query.mintAddress;
    // mintAddress が存在しない場合、エラーメッセージを返します
    if (!mintAddress) {
      res.status(400).send("Mint address is required");
      return;
    }
    try {
      // mintAddress を使用してトークン情報を取得します
      // mintToken 関数は3つの引数が必要です。ここでは、デフォルトの値を使用します
      const tokenInfo: unknown = await mintToken(
        mintAddress,
        "defaultPublicKey",
        parseInt("defaultPrivateKey")
      );
      // トークン情報をレスポンスとして送信します
      res.status(200).send(tokenInfo);
    } catch (error: any) {
      // トークン詳細の取得に失敗した場合、エラーメッセージを送信します
      (res as any).status(500).send("Failed to get token details");
    }
  });
