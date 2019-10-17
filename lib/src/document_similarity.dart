import 'package:document_analysis/src/matrix_creator.dart';
import 'package:document_analysis/src/vector_measurement.dart';

///Check similarity between 2 documents using word frequency metric
///
///Default distanceFunction is cosineDistance
double wordFrequencySimilarity(String document1, String document2,
    {distanceFunction = cosineDistance}) {

  List<List<double>> vectorList = wordFrequencyMatrix([document1, document2]);

  return 1.0-distanceFunction(vectorList[0], vectorList[1]);
}


///Check similarity between 2 documents using TF-IDF metric.
///
///Default distanceFunction is cosineDistance
double tfIdfSimilarity(String document1, String document2, List<String> background,
    {distanceFunction = cosineDistance}) {
      
  List<List<double>> vectorList = tfIdfMatrix([document1, document2, ...background]);

  return 1.0-distanceFunction(vectorList[0], vectorList[1]);
}

///Check similarity between 2 documents using Hybrid TF-IDF metric.
///
///Default distanceFunction is cosineDistance
double hybridTfIdfSimilarity(String document1, String document2, List<String> background,
    {distanceFunction = cosineDistance}) {

  List<List<double>> vectorList = hybridTfIdfMatrix([document1, document2, ...background]);

  return 1.0-distanceFunction(vectorList[0], vectorList[1]);
}