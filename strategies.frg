#lang forge/temporal

open "core.frg"

/*
  This file defines example strategies for the tournament

  Each strategy is written as a predicate that explains how a player should behave over time against one opponent

  The tournament file decides who each opponent is in a given match
*/

// These are the four starter strategies we want available in the model
one sig AlwaysCooperate, AlwaysDefect, TitForTat, GrimTrigger extends Strategy {}

// This strategy cooperates in every round
pred alwaysCooperateBehavior[p: Player] {
    always p.move = Cooperate
}

// This strategy defects in every round
pred alwaysDefectBehavior[p: Player] {
    always p.move = Defect
}

// This strategy starts nice and then copies whatever the opponent did last round
pred titForTatBehavior[p, opp: Player] {
    // The very first move is cooperation
    p.move = Cooperate

    // After the first round the player copies the opponent's previous move
    always {
        (prev_state true and prev_state (opp.move = Cooperate)) implies p.move = Cooperate
        (prev_state true and prev_state (opp.move = Defect)) implies p.move = Defect
    }
}

// This strategy cooperates until the opponent defects once and then never forgives
pred grimTriggerBehavior[p, opp: Player] {
    // The very first move is cooperation
    p.move = Cooperate

    // Once the opponent has defected in the past this player defects forever
    always {
        (prev_state true and prev_state once (opp.move = Defect)) implies p.move = Defect
        (not (prev_state true and prev_state once (opp.move = Defect))) implies p.move = Cooperate
    }
}

// This connects a player's chosen strategy to the correct behavior rule
pred playerFollowsAssignedStrategy[p, opp: Player] {
    p.uses = AlwaysCooperate implies alwaysCooperateBehavior[p]
    p.uses = AlwaysDefect implies alwaysDefectBehavior[p]
    p.uses = TitForTat implies titForTatBehavior[p, opp]
    p.uses = GrimTrigger implies grimTriggerBehavior[p, opp]
}
