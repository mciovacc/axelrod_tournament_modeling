#lang forge/temporal

open "core.frg"
open "payoffs.frg"
open "strategies.frg"

/*
  This file puts the pieces together into a small example tournament

  Right now the tournament is just a starter demo with four players and two matches

  The goal is to have something small that runs, shows traces, and is easy to build on later
*/

// A match stores the two players facing each other
sig Match {
    left: one Player,
    right: one Player
}

// These are the four example players in the demo tournament
one sig ACPlayer, ADPlayer, TFTPlayer, GrimPlayer extends Player {}

// These are the two matches that happen in the demo round robin round
one sig MatchOne, MatchTwo extends Match {}

// This fixes the exact tournament shape so the demo stays small and clear
pred tournamentShape {
    Player = ACPlayer + ADPlayer + TFTPlayer + GrimPlayer
    Match = MatchOne + MatchTwo

    all m: Match | m.left != m.right

    // Each player should appear in exactly one of the two matches
    all p: Player | one m: Match | p = m.left or p = m.right
    no (MatchOne.left + MatchOne.right) & (MatchTwo.left + MatchTwo.right)
}

// This assigns one strategy to each demo player
pred exampleStrategyAssignments {
    ACPlayer.uses = AlwaysCooperate
    ADPlayer.uses = AlwaysDefect
    TFTPlayer.uses = TitForTat
    GrimPlayer.uses = GrimTrigger
}

// This chooses the two example matchups for the demo
pred examplePairings {
    // Match one is Tit For Tat against Always Defect
    MatchOne.left = TFTPlayer
    MatchOne.right = ADPlayer

    // Match two is Always Cooperate against Grim Trigger
    MatchTwo.left = ACPlayer
    MatchTwo.right = GrimPlayer
}

// This tells each player to follow the strategy they were assigned
pred strategiesControlMoves {
    playerFollowsAssignedStrategy[MatchOne.left, MatchOne.right]
    playerFollowsAssignedStrategy[MatchOne.right, MatchOne.left]
    playerFollowsAssignedStrategy[MatchTwo.left, MatchTwo.right]
    playerFollowsAssignedStrategy[MatchTwo.right, MatchTwo.left]
}

// This gives the score for the left side of a match in the current round
fun currentLeftScore[m: Match]: one Int {
    payoffToFirst[m.left.move, m.right.move]
}

// This gives the score for the right side of a match in the current round
fun currentRightScore[m: Match]: one Int {
    payoffToSecond[m.left.move, m.right.move]
}

// This is the main predicate for the starter tournament run
pred starterTournament {
    AxelrodFirstTournamentCore
    AxelrodRoundPayoffs
    tournamentShape
    exampleStrategyAssignments
    examplePairings
    strategiesControlMoves
    officialMatch[MatchOne.left, MatchOne.right]
    officialMatch[MatchTwo.left, MatchTwo.right]
}
