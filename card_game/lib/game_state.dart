import 'package:flutter/material.dart';
import 'card_model.dart';

class GameState extends ChangeNotifier {
  final List<String> backImages = [
    'img/fire.png',
    'img/acid.png',
    'img/water.png',
  ];

  final List<String> frontImages = [
    'img/img2/godfree.png',
    'img/img2/mill.png',
    'img/img2/radahn.png',
    'img/img2/ranni.png',
  ];

  late List<CardModel> _cards;
  List<int> _selectedCards = [];

  GameState() {
    _cards = _generateCards();
  }

  List<CardModel> get cards => _cards;

  List<CardModel> _generateCards() {
    List<CardModel> cards = [];

    List<String> shuffledFronts = List.from(frontImages)..addAll(frontImages);
    shuffledFronts.shuffle();

    for (int i = 0; i < shuffledFronts.length; i++) {
      cards.add(CardModel(
          front: shuffledFronts[i], back: backImages[i % backImages.length]));
    }

    cards.shuffle();
    return cards;
  }

  void flipCard(int index) {
    if (_cards[index].isMatched || _selectedCards.contains(index)) return;

    _cards[index].isFaceUp = !_cards[index].isFaceUp;
    _selectedCards.add(index);
    notifyListeners();

    if (_selectedCards.length == 2) {
      _checkForMatch();
    }
  }

  static const Duration matchedMessageDelay = Duration(milliseconds: 700);

  void _checkForMatch() async {
    int firstIndex = _selectedCards[0];
    int secondIndex = _selectedCards[1];

    if (_cards[firstIndex].front == _cards[secondIndex].front) {
      _cards[firstIndex].isMatched = true;
      _cards[secondIndex].isMatched = true;

      await Future.delayed(matchedMessageDelay);
      _cards[firstIndex].showMatchedMessage = true;
      _cards[secondIndex].showMatchedMessage = true;
    } else {
      await Future.delayed(const Duration(seconds: 1));
      _cards[firstIndex].isFaceUp = false;
      _cards[secondIndex].isFaceUp = false;
    }

    _selectedCards.clear();
    notifyListeners();
  }
}
