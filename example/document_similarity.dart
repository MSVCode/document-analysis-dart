import 'package:document_analysis/document_analysis.dart';

void main(){
  String doc1 = "Report: Xiaomi topples Fitbit and Apple as world's largest wearables vendor";
  String doc2 = "Xiaomi topples Fitbit and Apple as world's largest wearables vendor: Strategy Analytics";
  String doc3 = 'An intermediate-sized asteroid, categorised as a "potentially hazardous asteroid", will make a close approach to earth on February 4, said Nasa.';

  print("Doc 1-2. WordFreq, Jaccard: ${wordFrequencySimilarity(doc1, doc2, distanceFunction: jaccardDistance)}");
  print("Doc 1-2. WordFreq, Cosine: ${wordFrequencySimilarity(doc1, doc2, distanceFunction: cosineDistance)}");
  print("Doc 1-3. WordFreq, Jaccard: ${wordFrequencySimilarity(doc1, doc3, distanceFunction: jaccardDistance)}");
  print("Doc 1-3. WordFreq, Cosine: ${wordFrequencySimilarity(doc1, doc3, distanceFunction: cosineDistance)}");
}