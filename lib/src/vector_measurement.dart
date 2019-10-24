import 'dart:math';

///Cosine Similarity between two vectors
///
///1 = Max distance, 0 = No distance (same document)
double cosineDistance(List<double> vector1, List<double> vector2) {
  double upper = 0;
  double bottomA = 0;
  double bottomB = 0;
  int len = min(vector1.length, vector2.length);
  for (int i = 0; i < len; i++) {
    upper += vector1[i] * vector2[i];
    bottomA += vector1[i] * vector1[i];
    bottomB += vector2[i] * vector2[i];
  }
  double diviser = sqrt(bottomA) * sqrt(bottomB);
  return 1.0 - (diviser != 0 ? (upper / diviser) : 0);
}

///Jaccard Similarity between two vectors.
///
///Jaccard Similarity is number of change required to change Doc1 into Doc2
///
///1 = Max distance, 0 = No distance (same document)
double jaccardDistance(List<double> vector1, List<double> vector2,
    {bool distinctCalculation = false}) {
  double union = 0;
  double intersection = 0;
  int len = min(vector1.length, vector2.length);
  for (int i = 0; i < len; i++) {
    //for non distinct calculation
    if (distinctCalculation) {
      intersection += min(
          vector1[i], vector2[i]); //vector1 = 1, vector2 = 2 - intersect = 1
      union +=
          max(vector1[i], vector2[i]); //vector1 = 0, vector2 = 3 - union = 3
    } else {
      //for distinct calculation
      if (vector1[i] > 0 && vector2[i] > 0) {
        intersection++;
      }
      if (vector1[i] > 0 || vector2[i] > 0) {
        union++;
      }
    }
  }
  return 1.0 - (union == 0 ? 0 : (intersection / union));
}
