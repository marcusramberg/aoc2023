console.log("Day 7");
import readline from "readline";
let rank = {
  1: 1,
  2: 2,
  3: 3,
  4: 4,
  5: 5,
  6: 6,
  7: 7,
  8: 8,
  9: 9,
  T: 10,
  J: 1,
  Q: 12,
  K: 13,
  A: 14,
};
var hands = [];

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false,
});

rl.on("line", (line) => {
  let res = line.split(" ");
  var hand = { cards: {}, score: 0, hand: [] };
  let cards = res[0].split("");
  for (let i = 0; i < cards.length; i++) {
    if (hand.cards[cards[i]] === undefined) {
      hand.cards[cards[i]] = 1;
    } else {
      hand.cards[cards[i]] += 1;
    }
    hand.hand.push(cards[i]);
  }
  // J is a joker, so add it to the type of card with the highest count
  if (hand.cards["J"] !== undefined) {
    let max = 0;
    let max_card = "";
    for (let i = 0; i < hand.hand.length; i++) {
      if (rank[hand.cards[hand.hand[i]]] > max) {
        if (hand.hand[i] === "J") continue;
        max = hand.cards[hand.hand[i]];
        max_card = hand.hand[i];
      }
    }
    hand.cards[max_card] += hand.cards["J"];
  }
  delete hand.cards["J"];
  hand.score = res[1];
  hands.push(hand);
});
rl.once("close", () => {
  let sorted_hands = hands.sort((h1, h2) => {
    //  Shorter combination wins
    if (
      (Object.keys(h1.cards).length || 1) > (Object.keys(h2.cards).length || 1)
    )
      return -1;
    if (
      (Object.keys(h1.cards).length || 1) < (Object.keys(h2.cards).length || 1)
    )
      return 1;

    let a_cards = Object.keys(h1.cards).sort(
      (a, b) => h1.cards[a] < h1.cards[b],
    );
    let b_cards = Object.keys(h2.cards).sort(
      (a, b) => h2.cards[a] < h2.cards[b],
    );
    // If both hands have the same combination, the one with the highest count wins
    if (h1.cards[a_cards[0]] > h2.cards[b_cards[0]]) {
      return 1;
    } else if (h1.cards[a_cards[0]] < h2.cards[b_cards[0]]) {
      return -1;
    }
    // If both hands have the same combination and count, the one with the highest card wins
    // Beginnging with the first card, compare the cards until one hand wins
    for (let i = 0; i < h1.hand.length; i++) {
      if (rank[h1.hand[i]] > rank[h2.hand[i]]) {
        return 1;
      } else if (rank[h1.hand[i]] < rank[h2.hand[i]]) {
        return -1;
      }
    }
    return rank[h1.cards[a_cards[0]]] < rank[h2.cards[b_cards[0]]];
  });
  var sum = 0;
  for (let i = 0; i < sorted_hands.length; i++) {
    console.log(sorted_hands[i]);
    sum += sorted_hands[i].score * (i + 1);
  }
  console.log(sum);
});
