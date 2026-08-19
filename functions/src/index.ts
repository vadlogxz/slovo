import { initializeApp } from "firebase-admin/app";

initializeApp();

export { generateWord } from "./vocabulary/generateWord";
export { onWordsChanged } from "./vocabulary/updateWordCount";