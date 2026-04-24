#lang forge/temporal

open "core.frg"

/*
  One-round payoff matrix for the Prisoner's Dilemma used by Axelrod's
  original tournament:
    T = 5  (temptation to defect)
    R = 3  (reward for mutual cooperation)
    P = 1  (punishment for mutual defection)
    S = 0  (sucker's payoff)
*/

one sig PayoffTable {
    temptation: one Int,
    reward: one Int,
    punishment: one Int,
    sucker: one Int
}

pred AxelrodRoundPayoffs {
    PayoffTable.temptation = 5
    PayoffTable.reward = 3
    PayoffTable.punishment = 1
    PayoffTable.sucker = 0

    // Standard Prisoner's Dilemma ordering.
    PayoffTable.temptation > PayoffTable.reward
    PayoffTable.reward > PayoffTable.punishment
    PayoffTable.punishment > PayoffTable.sucker
}

fun payoffToFirst[p1Move, p2Move: Action]: one Int {
    p1Move = Cooperate and p2Move = Cooperate => PayoffTable.reward else
    p1Move = Cooperate and p2Move = Defect => PayoffTable.sucker else
    p1Move = Defect and p2Move = Cooperate => PayoffTable.temptation else
    PayoffTable.punishment
}

fun payoffToSecond[p1Move, p2Move: Action]: one Int {
    p1Move = Cooperate and p2Move = Cooperate => PayoffTable.reward else
    p1Move = Cooperate and p2Move = Defect => PayoffTable.temptation else
    p1Move = Defect and p2Move = Cooperate => PayoffTable.sucker else
    PayoffTable.punishment
}

fun currentPayoffToFirst[p1, p2: Player]: one Int {
    payoffToFirst[p1.move, p2.move]
}

fun currentPayoffToSecond[p1, p2: Player]: one Int {
    payoffToSecond[p1.move, p2.move]
}
