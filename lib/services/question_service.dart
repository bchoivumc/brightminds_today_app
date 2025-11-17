import 'dart:math';
import '../models/question.dart';

class QuestionService {
  // New Testament Logic Questions from PDF resources
  static final List<List<Question>> _questionSets = [
    // Set 1: Questions 1-12 from PDF
    [
      Question(
        id: 'nt_q1',
        question: 'The Parable of the Lost Sheep (Luke 15:4-7): A shepherd has 100 sheep. One sheep gets lost. The shepherd leaves the 99 sheep to find the one lost sheep. He finds the lost sheep and brings it back.\n\nAfter finding the lost sheep, how many sheep does the shepherd have total?',
        options: [
          '99 sheep',
          '100 sheep',
          '101 sheep',
          'Cannot be determined'
        ],
        correctAnswerIndex: 1,
        explanation: 'The shepherd starts with 100 sheep. One gets lost (99 remain with the flock). He finds the lost sheep and brings it back. Total: 99 + 1 = 100 sheep. The shepherd returns to having his original 100 sheep.',
      ),
      Question(
        id: 'nt_q2',
        question: 'Feeding of the 5,000 (John 6:1-14): A boy has 5 loaves of bread and 2 fish. Jesus feeds 5,000 men with this food. The story says "five thousand men, besides women and children" were fed. After everyone ate, 12 baskets of leftovers were collected.\n\nWhich statement must be true based on this account?',
        options: [
          'Exactly 5,000 people were fed',
          'More than 5,000 people were fed',
          'Fewer than 5,000 people were fed',
          'The boy had 12 loaves originally'
        ],
        correctAnswerIndex: 1,
        explanation: 'The account specifically states "five thousand men, besides women and children." This means: 5,000 men + some number of women + some number of children. Therefore, the total must be MORE than 5,000 people.',
      ),
      Question(
        id: 'nt_q3',
        question: 'The Good Samaritan (Luke 10:30-37): A man traveling from Jerusalem to Jericho is robbed and injured. A priest passes by without helping. A Levite passes by without helping. A Samaritan stops and helps the injured man. The Samaritan takes the man to an inn and pays for his care.\n\nHow many people saw the injured man before the Samaritan helped him?',
        options: [
          '1 person',
          '2 people',
          '3 people',
          '4 people'
        ],
        correctAnswerIndex: 1,
        explanation: 'Before the Samaritan helped, the following people saw the injured man: (1) the priest, and (2) the Levite. Both passed by without helping. The Samaritan was the third person to see him, and he helped. So 2 people saw the man before the Samaritan helped.',
      ),
      Question(
        id: 'nt_q4',
        question: 'The Prodigal Son (Luke 15:11-32): A father has 2 sons. The younger son asks for his inheritance early. The father divides his property between both sons. The younger son leaves and spends all his money. The older son stays and works for his father.\n\nHow many sons received inheritance from the father?',
        options: [
          '0 sons',
          '1 son (only the younger)',
          '2 sons (both)',
          'Cannot be determined from the story'
        ],
        correctAnswerIndex: 2,
        explanation: 'The story explicitly states "the father divided his property between" both sons. The younger son received his share and left. The older son also received his share but stayed. Both sons received inheritance.',
      ),
      Question(
        id: 'nt_q5',
        question: 'Walking on Water (Matthew 14:22-33): Jesus sends his disciples ahead in a boat. There are 12 disciples in the boat. Jesus walks on water to meet them. Peter gets out of the boat and walks on water toward Jesus. Peter begins to sink and Jesus helps him back to the boat.\n\nAfter Peter gets back in the boat, how many people are in the boat?',
        options: [
          '11 people',
          '12 people',
          '13 people',
          '14 people'
        ],
        correctAnswerIndex: 2,
        explanation: 'Initially: 12 disciples in the boat. Peter gets out (11 remain in boat). Then both Peter AND Jesus get into the boat. Final count: 11 + Peter + Jesus = 13 people total in the boat.',
      ),
      Question(
        id: 'nt_q6',
        question: 'The Wise and Foolish Builders (Matthew 7:24-27): One man builds his house on rock. Another man builds his house on sand. Rain falls on both houses. Floods come to both houses. Winds blow on both houses. The house on rock stands firm. The house on sand collapses.\n\nWhich weather events did the house on rock experience?',
        options: [
          'Only rain',
          'Only floods',
          'Rain and floods only',
          'Rain, floods, and winds'
        ],
        correctAnswerIndex: 3,
        explanation: 'The passage states that rain, floods, and winds came against BOTH houses. "Rain falls on both houses • Floods come to both houses • Winds blow on both houses." The house on rock experienced all three weather events.',
      ),
      Question(
        id: 'nt_q7',
        question: 'Zacchaeus (Luke 19:1-10): Zacchaeus is a tax collector. He is short in height. Large crowds block his view of Jesus. Zacchaeus climbs a sycamore tree to see Jesus. Jesus sees him and calls him down.\n\nWhat is the logical reason Zacchaeus climbed the tree?',
        options: [
          'He wanted to pick fruit',
          'He was hiding from Jesus',
          'Being short, he needed height to see over the crowds',
          'The tree was in his way'
        ],
        correctAnswerIndex: 2,
        explanation: 'The setup provides three key facts: (1) Zacchaeus is short, (2) Large crowds block his view, (3) He climbs a tree to see Jesus. The logical conclusion is that being short, he needed the height advantage to see over the crowds.',
      ),
      Question(
        id: 'nt_q8',
        question: 'The Ten Lepers (Luke 17:11-19): Ten men with leprosy ask Jesus for healing. Jesus heals all 10 men. Jesus tells them to show themselves to the priests. All 10 men leave to go to the priests. Only 1 man returns to thank Jesus.\n\nHow many healed men did NOT return to thank Jesus?',
        options: [
          '1 man',
          '9 men',
          '10 men',
          '11 men'
        ],
        correctAnswerIndex: 1,
        explanation: 'Total healed: 10 men. Number who returned: 1 man. Number who did NOT return: 10 - 1 = 9 men.',
      ),
      Question(
        id: 'nt_q9',
        question: 'The Parable of the Talents (Matthew 25:14-30): A master gives talents (money) to 3 servants before traveling. First servant receives 5 talents. Second servant receives 2 talents. Third servant receives 1 talent. The master returns and asks for an accounting.\n\nHow many total talents did the master originally distribute?',
        options: [
          '3 talents',
          '5 talents',
          '7 talents',
          '8 talents'
        ],
        correctAnswerIndex: 3,
        explanation: 'First servant: 5 talents. Second servant: 2 talents. Third servant: 1 talent. Total distributed: 5 + 2 + 1 = 8 talents.',
      ),
      Question(
        id: 'nt_q10',
        question: 'The Workers in the Vineyard (Matthew 20:1-16): A landowner hires workers at different times. Group 1: Hired at 6 AM for 1 denarius per day. Group 2: Hired at 9 AM. Group 3: Hired at 12 PM. Group 4: Hired at 3 PM. Group 5: Hired at 5 PM. At 6 PM, all workers receive 1 denarius each.\n\nWhich group worked the longest hours?',
        options: [
          'Group 1 (hired at 6 AM)',
          'Group 2 (hired at 9 AM)',
          'Group 3 (hired at 12 PM)',
          'All groups worked the same hours'
        ],
        correctAnswerIndex: 0,
        explanation: 'Work ended at 6 PM for everyone. Group 1 hired at 6 AM worked from 6 AM to 6 PM = 12 hours. Group 2 hired at 9 AM worked 9 hours. Group 3 hired at 12 PM worked 6 hours. Group 4 hired at 3 PM worked 3 hours. Group 5 hired at 5 PM worked 1 hour. Group 1 worked the longest.',
      ),
      Question(
        id: 'nt_q11',
        question: 'The Twelve Apostles selection (Mark 3:13-19): Jesus calls his disciples to him. He appoints 12 of them to be apostles. The list includes: Simon Peter, James, John, Andrew, Philip, Bartholomew, Matthew, Thomas, James son of Alphaeus, Thaddaeus, Simon the Zealot, and Judas Iscariot.\n\nIf Jesus had 120 disciples following him, and he chose 12 to be apostles, how many disciples were NOT chosen as apostles?',
        options: [
          '12 disciples',
          '108 disciples',
          '120 disciples',
          '132 disciples'
        ],
        correctAnswerIndex: 1,
        explanation: 'Total disciples: 120. Disciples chosen as apostles: 12. Disciples NOT chosen: 120 - 12 = 108 disciples.',
      ),
      Question(
        id: 'nt_q12',
        question: 'Jesus Clears the Temple (John 2:13-16): Jesus enters the temple in Jerusalem. He finds people selling cattle, sheep, and doves. He finds people exchanging money. Jesus makes a whip from cords. He drives out all the sheep and cattle. He scatters the coins of money changers. He overturns their tables.\n\nWhich items did Jesus specifically drive out of the temple?',
        options: [
          'Only the sheep',
          'Only the cattle',
          'The sheep and cattle',
          'The sheep, cattle, and doves'
        ],
        correctAnswerIndex: 2,
        explanation: 'The passage states Jesus "drives out all the sheep and cattle." While doves were being sold in the temple, the text specifically mentions that Jesus drove out the sheep and cattle, but does not say he drove out the doves. Therefore, the answer is sheep and cattle.',
      ),
    ],
  ];

  Future<List<Question>> getDailyQuestions() async {
    // Get current day index from storage
    final dayIndex = await _getCurrentDayIndex();

    // Cycle through question sets
    final setIndex = dayIndex % _questionSets.length;

    return _questionSets[setIndex];
  }

  Future<int> _getCurrentDayIndex() async {
    // This would use StorageService to get the actual day index
    // For now, we'll use a simple calculation based on date
    final now = DateTime.now();
    final start = DateTime(2024, 1, 1);
    final difference = now.difference(start).inDays;
    return difference;
  }

  List<Question> getRandomQuestions(int count) {
    final allQuestions = _questionSets.expand((set) => set).toList();
    allQuestions.shuffle(Random());
    return allQuestions.take(count).toList();
  }
}
