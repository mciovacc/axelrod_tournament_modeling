#lang forge/temporal

open "tournament.frg"

/*
  This is the full entry file for the example tournament

  It runs the starter tournament with the real 200 round length from Axelrod's first tournament

  Use this when you want the full version instead of a quick debug run
*/

option run_sterling "tournament.cnd"
option max_tracelength 200
option min_tracelength 200

// This run command launches the full tournament model
run {
    starterTournament
} for 9 Int
