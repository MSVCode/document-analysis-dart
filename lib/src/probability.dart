import 'dart:math';

import 'package:document_analysis/src/structure.dart';

///Word probability calculation - `Word Frequency`.
///
///This function is used to calculate the probability of a word to be the main topic (important score)
///Could be used to calculate Term Frequency - document exclusive
///
Map<String, double> wordFrequencyProbability(TokenizationOutput tokenOut) {
  Map<String, double> wordsProbability = {};

  tokenOut.bagOfWords.forEach((key, val) {
    wordsProbability[key] = val / tokenOut.totalNumberOfWords;
  });

  return wordsProbability;
}

///Word probability calculation - `Term Frequency - Inverse Document Frequency`.
///
///This function is used to calculate the probability of a word to be the main topic (important score)
///
///Returns probability for each word in each document
List<Map<String, double>> tfIdfProbability(TokenizationOutput tokenOut) {
  List<Map<String, double>> documentExclusiveWP = [];
  int documentCount = tokenOut.documentTotalWord.length;

  //calculate the IDF first, the value is used for all document
  Map<String, double> wordIDF = {};
  tokenOut.wordInDocumentOccurrence.forEach((key, val) {
    wordIDF[key] = log(documentCount / tokenOut.wordInDocumentOccurrence[key]!) /
        ln10; //log10
  });

  //for all document
  for (int i = 0; i < tokenOut.documentTotalWord.length; i++) {
    Map<String, double> currentWordProb = {};
    //for all word available in a document
    tokenOut.documentBOW[i].forEach((key, val) {
      var tf = val / tokenOut.documentTotalWord[i];
      var idf = wordIDF[key]!;
      currentWordProb[key] = tf * idf;
    });
    //every document have their own word probability
    documentExclusiveWP.add(currentWordProb);
  }

  return documentExclusiveWP;
}

///Word probability calculation - `Hybird Term Frequency - Inverse Document Frequency`.
///
///This function is used to calculate the probability of a word to be the main topic (important score).
///
///The difference is that tf is occurence in all document not only one document. IDF is the same.
///
///Returns probability for each word
Map<String, double> hybridTfIdfProbability(TokenizationOutput tokenOut) {
  Map<String, double> wordsProbability = {};
  int documentCount = tokenOut.documentTotalWord.length;

  //calculate the IDF first, the value is used for all document
  Map<String, double> wordIDF = {};
  tokenOut.wordInDocumentOccurrence.forEach((key, val) {
    wordIDF[key] = log(documentCount / tokenOut.wordInDocumentOccurrence[key]!) /
        ln10; //log10
  });

  //for all word
  tokenOut.bagOfWords.forEach((key, val) {
    var tf = val / tokenOut.totalNumberOfWords;
    var idf = wordIDF[key]!;
    wordsProbability[key] = tf * idf;
  });

  return wordsProbability;
}
