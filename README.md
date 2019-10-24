# document_analysis
A collection of document-analysis processing.

## Getting Started
In your Dart (or Flutter) project `pubspec.yaml` add the dependency:
```yaml
dependencies:
  ...
  document_analysis: ^0.1.2
```

## Vector Distance Measurement
Because this is document-based analysis. Distance measurement must range between 0-1 (normalized, unlike Euclidean distance). Current distance measurement available:
- Jaccard [Wiki](https://en.wikipedia.org/wiki/Jaccard_index)
- Cosine [Wiki](https://en.wikipedia.org/wiki/Cosine_similarity)

Call: `jaccardDistance(vector1, vector2)`
- Input vector is `List<double>`

Usage:
```dart
List<double> vector1 = [0, 1, 1.5, 3, 2, 0.5];
List<double> vector2 = [1, 3, 3.5, 4, 0.5, 0];

print("Jaccard: ${jaccardDistance(vector1, vector2)}");//0.333...
print("Cosine: ${cosineDistance(vector1, vector2)}");//0.156...
```

## Document Similarity
Current document-similarity function available are based on:
- Word Frequency [Wiki](https://en.wikipedia.org/wiki/Word_lists_by_frequency)
- Term-Frequency Inverse-Document-Frequency (TF-IDF) [Wiki](https://en.wikipedia.org/wiki/Tf%E2%80%93idf)
- Hybrid TF-IDF 

Call: `wordFrequencySimilarity(doc1, doc2, distanceFunction: jaccardDistance)`:
- `doc1, doc2`: Input document (String)
- `distanceFunction`: Vector distance measurement `(vector1, vector2)=>double`

Usage:
```dart
String doc1 = "Report: Xiaomi topples Fitbit and Apple as world's largest wearables vendor";
String doc2 = "Xiaomi topples Fitbit and Apple as world's largest wearables vendor: Strategy Analytics";

print("${wordFrequencySimilarity(doc1, doc2, distanceFunction: jaccardDistance)}");//0.769...
print("${wordFrequencySimilarity(doc1, doc2, distanceFunction: cosineDistance)}");//0.870...
```

## Matrix Creation
Word-vector matrix from collection of documents, current available:
- Word Frequency
- TF-IDF
- Hybrid TF-IDF 

Call: `wordFrequencyMatrix([doc1, doc2])`
- `[...]`: All document, `List<String>`

Usage:
```dart
String doc1 = "Report: Xiaomi topples Fitbit and Apple as world's largest wearables vendor";
String doc2 = "Xiaomi topples Fitbit and Apple as world's largest wearables vendor: Strategy Analytics";

print(wordFrequencyMatrix([doc1, doc2]));
//[[1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0], [0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0]]
```

## Document Tokenizer
Tokenize document (String) into multiple metrics:

Call: `documentTokenizer(List<String> documentList, {minLen = 1, String Function(String) stemmer, List<String> stopwords})`
- `documentList`: All document in a List
- `minLen`: Minimum word occurrence to be considered in tokenization
- `stemmer`: Stemming function
- `stopwords`: Collection of common words that should be ignored in document analysis

Usage:
```dart
documentTokenizer([doc1, doc2, doc3]);
```

Outputs `TokenizationOutput`.
```dart
class TokenizationOutput{
  ///Count for each words in all documents
  Map<String, double> bagOfWords = {};
  ///How often a certain word occur across all documents (unique word occurence - max 1 per document)
  Map<String, double> wordInDocumentOccurrence = {};
  ///List of 'Bag of Words' for each document
  List<Map<String, double>> documentBOW = [];
  ///Total number of word in each document
  List<int> documentTotalWord = [];
  ///Total distinct word in all documents
  int numberOfDistintWords = 0;
  ///Total number of word in all documents
  int totalNumberOfWords = 0;
}
```

# Remarks
- Hybrid TF-IDF based on `Sharifi, B., Hutton, M.-A. & Kalita, J. K., 2010. Experiments in microblog summarization. Social Computing (SocialCom), 2010 IEEE Second International Conference on, pp. 49-56.`