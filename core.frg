#lang forge/temporal

/*
  This file sets up the basic building blocks of the Axelrod model

  It defines the possible actions, the idea of a strategy, and what a player looks like over time

  We treat each state in the temporal trace as one round of play

  The files that run the model choose how many rounds to show so we can have both a short debug run and a full tournament run
*/

// These are the only two actions a player can choose in the Prisoner's Dilemma
abstract sig Action {}
one sig Cooperate, Defect extends Action {}

// A strategy is the rule a player follows to decide moves
abstract sig Strategy {}

// Each player is assigned one strategy and has a move that can change over time
sig Player {
    uses: one Strategy,
    var move: one Action
}

// This keeps the model sensible by saying every player always has a valid move
pred AxelrodFirstTournamentCore {
    // Every player should always be set to cooperate or defect
    always {
        all p: Player | p.move in Action
    }
}

// This checks that a single action is one of the legal game actions
pred legalAction[a: Action] {
    a in Action
}

// This checks that both moves in one round are legal
pred legalRound[p1Move, p2Move: Action] {
    legalAction[p1Move]
    legalAction[p2Move]
}

// This checks that two different players are making legal moves right now
pred legalCurrentRound[p1, p2: Player] {
    p1 != p2
    legalRound[p1.move, p2.move]
}

// This says a full match keeps the two players legal for the whole trace
pred officialMatch[p1, p2: Player] {
    p1 != p2
    AxelrodFirstTournamentCore
    always legalCurrentRound[p1, p2]
}
