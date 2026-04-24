#lang forge/temporal

/*
  Core structure for Axelrod's original iterated Prisoner's Dilemma
  tournament in Temporal Forge.

  We model one state as one round of play. The first tournament used
  exactly 200 rounds per match, so the trace length is fixed to 200.
  This file intentionally stays generic about how a strategy computes
  its next move, because the real tournament accepted arbitrary submitted
  programs rather than only memory-one rules.
*/

option max_tracelength 200
option min_tracelength 200

abstract sig Action {}
one sig Cooperate, Defect extends Action {}

abstract sig Strategy {}

sig Player {
    uses: one Strategy,
    var move: one Action
}

pred AxelrodFirstTournamentCore {
    // Every player always has exactly one legal move in each round.
    always {
        all p: Player | p.move in Action
    }
}

pred legalAction[a: Action] {
    a in Action
}

pred legalRound[p1Move, p2Move: Action] {
    legalAction[p1Move]
    legalAction[p2Move]
}

pred legalCurrentRound[p1, p2: Player] {
    p1 != p2
    legalRound[p1.move, p2.move]
}

pred officialMatch[p1, p2: Player] {
    p1 != p2
    AxelrodFirstTournamentCore
    always legalCurrentRound[p1, p2]
}
