import 'package:document_analysis/document_analysis.dart';
import "package:flutter/material.dart";

void main() => runApp(DocSimilarity());

class DocSimilarity extends StatefulWidget {
  @override
  _DocSimilarityState createState() => _DocSimilarityState();
}

class _DocSimilarityState extends State<DocSimilarity> {
  TextEditingController _doc1Con = TextEditingController();
  TextEditingController _doc2Con = TextEditingController();
  String _output = "";

  void _checkSimilarity() {
    String doc1 = _doc1Con.text;
    String doc2 = _doc2Con.text;
    List<String> background = [
      'A government source has told the BBC there will be "no deal tonight", as officials continue to work on the technical details in Brussels and German',
      'iOS 13 has continued Apple’s impressive installation rate of a new version of the iPhone’s operating system. Launched on September 19th, the mobile OS is now installed on half of all iPhones, and 55 percent of iPhones launched in the last year.',
      'Chinese phone maker Xiaomi today held an event in New Delhi, India where it revealed the pricing and availability of the Redmi Note 8 and 9',
      "Samsung's version of Android 10, called One UI 2.0, features more secure facial recognition for unlocking your Galaxy S10 and Note 10.",
      "NASA's Center for Near-Earth Object Studies (CNEOS) has reported how the larger of the approaching asteroids is almost three times taller and five times heavier"
    ];

    double wfSim = wordFrequencySimilarity(doc1, doc2);

    //idf require background text (help determine)
    double tfIdfSim = tfIdfSimilarity(doc1, doc2, background);
    double hybridTfIdfSim = hybridTfIdfSimilarity(doc1, doc2, background);

    setState(() {
      _output =
        "Word-Freq Similarity: $wfSim\nTF-IDF Similarity: $tfIdfSim\nHybrid TF-IDF Similarity: $hybridTfIdfSim";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Doc Similarity",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Doc Similarity"),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _doc1Con,
                decoration: InputDecoration(
                  labelText: "Document 1",
                ),
                maxLines: 3,
              ),
              TextField(
                controller: _doc2Con,
                decoration: InputDecoration(
                  labelText: "Document 1",
                ),
                maxLines: 3,
              ),
              RaisedButton(
                child: Text("Check"),
                onPressed: _checkSimilarity,
              ),
              Text(_output),
            ],
          ),
        ),
      ),
    );
  }
}
