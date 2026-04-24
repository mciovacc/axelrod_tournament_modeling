#lang forge/temporal

open "core.frg"

/*
  This file stores the score rules for one round of the Prisoner's Dilemma

  It uses the standard Axelrod payoff values

  T means temptation to defect
  R means reward for mutual cooperation
  P means punishment for mutual defection
  S means sucker's payoff
*/

// This single object holds the four payoff values used by the game
one sig PayoffTable {
    temptation: one Int,
    reward: one Int,
    punishment: one Int,
    sucker: one Int
}

// This fills in the actual payoff numbers and keeps them in the standard order
pred AxelrodRoundPayoffs {
    PayoffTable.temptation = 5
    PayoffTable.reward = 3
    PayoffTable.punishment = 1
    PayoffTable.sucker = 0

    // These inequalities make sure the payoffs really match the Prisoner's Dilemma setup
    PayoffTable.temptation > PayoffTable.reward
    PayoffTable.reward > PayoffTable.punishment
    PayoffTable.punishment > PayoffTable.sucker
}

// This returns the payoff for the first player based on the two moves in one round
fun payoffToFirst[p1Move, p2Move: Action]: one Int {
    p1Move = Cooperate and p2Move = Cooperate => PayoffTable.reward else
    p1Move = Cooperate and p2Move = Defect => PayoffTable.sucker else
    p1Move = Defect and p2Move = Cooperate => PayoffTable.temptation else
    PayoffTable.punishment
}

// This returns the payoff for the second player based on the same round
fun payoffToSecond[p1Move, p2Move: Action]: one Int {
    p1Move = Cooperate and p2Move = Cooperate => PayoffTable.reward else
    p1Move = Cooperate and p2Move = Defect => PayoffTable.temptation else
    p1Move = Defect and p2Move = Cooperate => PayoffTable.sucker else
    PayoffTable.punishment
}

// This reads the current moves of two players and gives the first player score
fun currentPayoffToFirst[p1, p2: Player]: one Int {
    payoffToFirst[p1.move, p2.move]
}

// This reads the current moves of two players and gives the second player score
fun currentPayoffToSecond[p1, p2: Player]: one Int {
    payoffToSecond[p1.move, p2.move]
}
