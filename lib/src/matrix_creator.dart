import 'package:document_analysis/src/vector_measurement.dart';
import 'package:document_analysis/src/probability.dart';
import 'package:document_analysis/src/structure.dart';
import 'package:document_analysis/src/tokenizer.dart';

///Create word-vector matrix using word-frequency metric
///
List<List<double>> wordFrequencyMatrix(List<String> documentList) {
  TokenizationOutput tokenOut = documentTokenizer(documentList);

  List<List<double>> matrix2d = List.generate(documentList.length, (_)=>[]);

  //for all distinct words
  tokenOut.bagOfWords.forEach((key, val) {
    for (int i = 0; i < documentList.length; i++) {
      if (tokenOut.documentBOW[i].containsKey(key)) {
        matrix2d[i].add(tokenOut.documentBOW[i][key].toDouble());
      } else {
        matrix2d[i].add(0);
      }
    }
  });

  return matrix2d;
}

///Create word-vector matrix using TF-IDF metric
///
List<List<double>> tfIdfMatrix(List<String> documentList,
    {measureFunction = cosineDistance}) {
  TokenizationOutput tokenOut = documentTokenizer(documentList);

  List<List<double>> matrix2d = List.generate(documentList.length, (_)=>[]);
  List<Map<String, double>> wpList = tfIdfProbability(tokenOut);

  //for all distinct words
  tokenOut.bagOfWords.forEach((key, val) {
    for (int i = 0; i < documentList.length; i++) {
      if (tokenOut.documentBOW[i].containsKey(key)) {
        matrix2d[i].add(wpList[i][key]);
      } else {
        matrix2d[i].add(0);
      }
    }
  });

  return matrix2d;
}

///Create word-vector matrix using Hybrid TF-IDF metric
///
List<List<double>> hybridTfIdfMatrix(List<String> documentList,
    {measureFunction = cosineDistance}) {
  TokenizationOutput tokenOut = documentTokenizer(documentList);

  List<List<double>> matrix2d = List.generate(documentList.length, (_)=>[]);
  Map<String, double> wordProbability = hybridTfIdfProbability(tokenOut);

  //for all distinct words
  tokenOut.bagOfWords.forEach((key, val) {
    for (int i = 0; i < documentList.length; i++) {
      if (tokenOut.documentBOW[i].containsKey(key)) {
        matrix2d[i].add(wordProbability[key]);
      } else {
        matrix2d[i].add(0);
      }
    }
  });

  return matrix2d;
}