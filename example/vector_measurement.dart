import 'package:document_analysis/document_analysis.dart';

void main(){
  List<double> vector1 = [0, 1, 1.5, 3, 2, 0.5];
  List<double> vector2 = [1, 3, 3.5, 4, 0.5, 0];

  print("Jaccard: ${jaccardDistance(vector1, vector2)}");
  print("Cosine: ${cosineDistance(vector1, vector2)}");
}