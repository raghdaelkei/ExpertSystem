; =========================
; rules/possibilistic-rules.clp
; =========================
; 10 rules   
; ---------------- 1. START POSSIBILISTIC PHASE ----------------
; Salience -15 triggers after the deterministic print-result rule
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

; ---------------- 2 & 3. INPUT SANITIZATION ----------------
; These rules catch user inputs outside the -1.0 to 1.0 bounds and clamp them.
(defrule clamp-high-fuzzy-input
  (declare (salience 10)) ; Runs immediately after input is gathered
  ?f <- (fuzzy-need (item ?i) (importance-cf ?cf))
  (test (> ?cf 1.0))
  =>
  (modify ?f (importance-cf 1.0))
  (printout t "-> System Note: Clamped " ?i " importance down to maximum 1.0" crlf)
)

(defrule clamp-low-fuzzy-input
  (declare (salience 10))
  ?f <- (fuzzy-need (item ?i) (importance-cf ?cf))
  (test (< ?cf -1.0))
  =>
  (modify ?f (importance-cf -1.0))
  (printout t "-> System Note: Clamped " ?i " importance up to minimum -1.0" crlf)
)

; ---------------- 4. ENGINEERING HEURISTICS ----------------
; Warns the user if their fuzzy needs contradict the laws of physics/economics
(defrule warn-conflicting-fuzzy-needs
  (phase (name possibilistic-eval))
  (fuzzy-need (item compactness) (importance-cf ?c))
  (fuzzy-need (item affordability) (importance-cf ?a))
  (test (>= ?c 0.8))
  (test (>= ?a 0.8))
  =>
  (printout t crlf "-> ENGINEERING WARNING: You requested extreme compactness AND extreme affordability. In hardware engineering, severe miniaturization usually increases cost. These constraints may conflict!" crlf)
)

; ---------------- 5. EVALUATE FUZZY MATCH ----------------
; Calculates a score based on multiplying the user's CF by the board's CF.
(defrule evaluate-possibilistic-match
  (phase (name possibilistic-eval))
  (recommendation (board ?b)) 
  (board-fuzziness (board ?b) (compactness-cf ?b-comp) (affordability-cf ?b-aff))
  (fuzzy-need (item compactness) (importance-cf ?u-comp))
  (fuzzy-need (item affordability) (importance-cf ?u-aff))
  =>
  (bind ?comp-score (* ?b-comp ?u-comp))
  (bind ?aff-score (* ?b-aff ?u-aff))
  (bind ?total-score (+ ?comp-score ?aff-score))

  (assert (possibilistic-score (board ?b) (score ?total-score)))
)

; ----------------  DEFUZZIFICATION ----------------
; Maps the crisp mathematical scores back into human-readable linguistic categories
(defrule defuzzify-excellent-match
  (declare (salience -5)) ; Runs after evaluation but before printing
  (possibilistic-score (board ?b) (score ?s))
  (test (>= ?s 1.0))
  =>
  (assert (fuzzy-category (board ?b) (rating "Excellent Fit")))
)

(defrule defuzzify-good-match
  (declare (salience -5))
  (possibilistic-score (board ?b) (score ?s))
  (test (>= ?s 0.0))
  (test (< ?s 1.0))
  =>
  (assert (fuzzy-category (board ?b) (rating "Good Fit")))
)

(defrule defuzzify-poor-match
  (declare (salience -5))
  (possibilistic-score (board ?b) (score ?s))
  (test (>= ?s -1.0))
  (test (< ?s 0.0))
  =>
  (assert (fuzzy-category (board ?b) (rating "Poor Fit")))
)

(defrule defuzzify-terrible-match
  (declare (salience -5))
  (possibilistic-score (board ?b) (score ?s))
  (test (< ?s -1.0))
  =>
  (assert (fuzzy-category (board ?b) (rating "Terrible Fit")))
)

; ---------------- 10. PRINT POSSIBILISTIC RESULTS ----------------
(defrule print-possibilistic-results
  (declare (salience -20))
  ?ph <- (phase (name possibilistic-eval))
  =>
  (printout t crlf "==========================================" crlf)
  (printout t " FINAL FUZZY MATCH SCORES " crlf)
  (printout t "==========================================" crlf)
  
  ; Joins the score and the linguistic rating together for output
  (do-for-all-facts ((?ps possibilistic-score) (?fc fuzzy-category)) (eq ?ps:board ?fc:board)
    (printout t "-> " ?ps:board " | Score: " ?ps:score " | Rating: " ?fc:rating crlf)
  )
  
  (printout t crlf "(Higher scores indicate a better fit for your subjective constraints.)" crlf)
  (printout t "Engineering assessment complete." crlf)
  (retract ?ph)
)