import * as admin from "firebase-admin"
import { applicationDefault } from "firebase-admin/app";
var serviceAccount = require("./serviceAccountKey.json");

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
})

export const firestore = admin.firestore();
export const notifications = admin.messaging();
