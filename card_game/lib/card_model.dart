class CardModel {
  final String front;
  final String back;
  bool isFaceUp;
  bool isMatched;
  bool showMatchedMessage;

  CardModel({
    required this.front,
    required this.back,
    this.isFaceUp = false,
    this.isMatched = false,
    this.showMatchedMessage = false,
  });
}
