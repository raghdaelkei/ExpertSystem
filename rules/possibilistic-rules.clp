; =========================
; rules/possibilistic-rules.clp
; =========================

; ---------------- START POSSIBILISTIC PHASE ----------------
; We use salience -15 so this triggers only after the deterministic 
; print-result rule (which has a salience of -10) has finished.
(defrule start-possibilistic-phase
  (declare (salience -15))
  =>
  (printout t crlf "==========================================" crlf)
  (printout t " PHASE 2: HARDWARE ENGINEERING TRADE-OFFS " crlf)
  (printout t "==========================================" crlf)
  (printout t "Let's refine this with some fuzzy constraints." crlf crlf)
  
  (printout t "How important is a highly COMPACT size to you?" crlf)
  (printout t "(Enter a value from -1.0 to 1.0, where 1.0 is critically important): ")
  (bind ?comp (read))
  (assert (fuzzy-need (item compactness) (importance-cf ?comp)))

  (printout t crlf "How important is AFFORDABILITY (low cost) to you?" crlf)
  (printout t "(Enter a value from -1.0 to 1.0, where 1.0 is critically important): ")
  (bind ?aff (read))
  (assert (fuzzy-need (item affordability) (importance-cf ?aff)))

  (assert (phase (name possibilistic-eval)))
)

; ---------------- EVALUATE FUZZY MATCH ----------------
; This rule calculates a score based on multiplying the user's CF 
; by the board's CF. It ONLY evaluates boards that survived the deterministic phase.
(defrule evaluate-possibilistic-match
  (phase (name possibilistic-eval))
  (recommendation (board ?b)) 
  (board-fuzziness (board ?b) (compactness-cf ?b-comp) (affordability-cf ?b-aff))
  (fuzzy-need (item compactness) (importance-cf ?u-comp))
  (fuzzy-need (item affordability) (importance-cf ?u-aff))
  =>
  ; Multiply the user's desire by the board's actual capability
  (bind ?comp-score (* ?b-comp ?u-comp))
  (bind ?aff-score (* ?b-aff ?u-aff))
  
  ; Combine the scores
  (bind ?total-score (+ ?comp-score ?aff-score))

  (assert (possibilistic-score (board ?b) (score ?total-score)))
)

; ---------------- PRINT POSSIBILISTIC RESULTS ----------------
(defrule print-possibilistic-results
  (declare (salience -20))
  ?ph <- (phase (name possibilistic-eval))
  =>
  (printout t crlf "==========================================" crlf)
  (printout t " FINAL FUZZY MATCH SCORES " crlf)
  (printout t "==========================================" crlf)
  
  (do-for-all-facts ((?ps possibilistic-score)) TRUE
    (printout t "-> " ?ps:board " has a fuzzy suitability score of: " ?ps:score crlf)
  )
  
  (printout t crlf "(Higher scores indicate a better fit for your subjective constraints.)" crlf)
  (printout t "Engineering assessment complete." crlf)
  (retract ?ph)
)