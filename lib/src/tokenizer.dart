import 'package:document_analysis/src/structure.dart';

///Simple document tokenization.
///
///Only processes `[a-z A-Z 0-9]`.
///
///May use external stemmer if available.
TokenizationOutput documentTokenizer(List<String> documentList,
    {minLen = 1, String Function(String)? stemmer, List<String>? stopwords}) {
  TokenizationOutput tokenOut = TokenizationOutput();

  for (int k = 0; k < documentList.length; k++) {
    Map<String, double> currentBOW = {};
    int currentTotalWord = 0;
    List<String> words = documentList[k]
        .toLowerCase()
        .replaceAll(RegExp(r"[^a-z0-9 ]"), "")
        .split(" ");
    List<String> contentWords = [];

    if (words.length >= minLen) {
      //remove short sentences
      for (int j = 0; j < words.length; j++) {
        String word = stemmer != null
            ? stemmer(words[j])
            : words[j]; //use stemmer if available
        if (word.trim().isNotEmpty && (stopwords==null || !stopwords.contains(word))) {
          //not empty and not a stopword
          contentWords.add(word);

          //general bag of words of whole input
          if (tokenOut.bagOfWords.containsKey(word)) {
            tokenOut.bagOfWords[word] = tokenOut.bagOfWords[word]!+1; //current sentence bag of word
          } else {
            tokenOut.bagOfWords[word] = 1;
            tokenOut.numberOfDistintWords++;
          }

          //document specific bag of words
          if (currentBOW.containsKey(word)) {
            currentBOW[word] = currentBOW[word]!+1; //current sentence bag of word
          } else {
            currentBOW[word] = 1;
            //found in this document for the first time
            if (tokenOut.wordInDocumentOccurrence.containsKey(word)) {
              tokenOut.wordInDocumentOccurrence[word] = tokenOut.wordInDocumentOccurrence[word]!+1;
            } else {
              tokenOut.wordInDocumentOccurrence[word] = 1;
            }
          }
        }
      }
      tokenOut.totalNumberOfWords += contentWords.length;
      currentTotalWord += contentWords.length;
    }
    //add stats for each document
    tokenOut.documentBOW.add(currentBOW);
    tokenOut.documentTotalWord.add(currentTotalWord);
  }

  return tokenOut;
}
