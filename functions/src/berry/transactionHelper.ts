import * as admin from "firebase-admin";
const db = admin.firestore();

// 商品を出品する関数
/**
 * @param {string} userId - The ID of the user listing the item
 * @param {object} itemDetails - The details of the item being listed
 * @return {Promise<string>} - The ID of the newly listed item
 */
async function listItem(userId: string, itemDetails: object): Promise<string> {
  // 新しい商品の詳細を作成
  const newItem = {
    originalSeller: userId,
    currentSeller: userId,
    transactionHistory: [],
    ...itemDetails,
  };
  // 新しい商品をデータベースに追加
  const docRef = await db.collection("posts").add(newItem);
  // 新しく作成された商品のIDを返す
  return docRef.id;
}

// 商品を購入する関数
/**
 * @param {string} itemId - The ID of the item being purchased
 * @param {string} buyerId - The ID of the user purchasing the item
 * @return {Promise<void>}
 */
async function purchaseItem(itemId: string, buyerId: string): Promise<void> {
  // 購入する商品の参照を取得
  const itemRef = db.collection("posts").doc(itemId);
  // 商品のデータを取得
  const item = await itemRef.get();

  // 商品が存在しない場合はエラーをスロー
  if (!item.exists) {
    throw new Error("Item does not exist");
  }

  // 商品のデータを取得
  const itemData = item.data();
  // 新しいトランザクションの詳細を作成
  const newTransaction = {
    seller: itemData?.currentSeller,
    buyer: buyerId,
    timestamp: admin.firestore.FieldValue.serverTimestamp(),
  };

  // currentSellerを更新し、transactionHistoryに新しいトランザクションを追加
  await itemRef.update({
    currentSeller: buyerId,
    transactionHistory: admin.firestore.FieldValue.arrayUnion(newTransaction),
  });
}

export {listItem, purchaseItem};

