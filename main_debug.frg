#lang forge/temporal

open "tournament.frg"

/*
  This is a short debug entry file for the example tournament

  It uses the same tournament model as main but only shows 8 rounds so it loads much faster

  This is helpful when checking whether a problem is in the model or just in the long visualization
*/

option run_sterling "tournament.cnd"
option max_tracelength 8
option min_tracelength 8

// This run command launches the short debug version of the tournament
run {
    starterTournament
} for 9 Int
