#lang forge/temporal

open "tournament.frg"

/*
  This file is a quick non visual check for the tournament model

  It runs the same starter tournament with a short trace and keeps Sterling turned off

  This is useful when you want to check solving speed without waiting on visualization
*/

option run_sterling off
option max_tracelength 8
option min_tracelength 8

// This run command checks that the short tournament model can solve without opening Sterling
debugNoViz: run {
    starterTournament
} for 9 Int
