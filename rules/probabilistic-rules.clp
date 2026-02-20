; =========================
; rules/probabilistic-rules.clp
; =========================

; ---------------- START PROBABILISTIC PHASE ----------------
(defrule start-probabilistic-phase
  (declare (salience -25))
  =>
  (printout t crlf "==========================================" crlf)
  (printout t " PHASE 3: PROBABILISTIC RISK ASSESSMENT " crlf)
  (printout t "==========================================" crlf)
  (printout t "Let's assess environmental deployment risks." crlf crlf)
  
  (printout t "Will this system be deployed remotely on battery power for an extended period (1+ weeks)? (yes/no): ")
  (bind ?ans (read))
  
  (if (or (eq ?ans yes) (eq ?ans y) (eq ?ans YES) (eq ?ans Y))
    then (assert (environmental-risk (type extended-battery) (value yes)))
    else (assert (environmental-risk (type extended-battery) (value no)))
  )
  
  (assert (phase (name probabilistic-eval)))
)

; ---------------- EVALUATE HIGH RISK ----------------
; Triggers if the user wants extended battery life but the board's survival probability is under 70%
(defrule evaluate-battery-survival-risk
  (phase (name probabilistic-eval))
  (environmental-risk (type extended-battery) (value yes))
  (recommendation (board ?b))
  (survival-probability (board ?b) (prob ?p))
  (test (< ?p 0.70)) 
  =>
  (bind ?percent (* ?p 100))
  (assert (probabilistic-warning (board ?b) (text (str-cat "HIGH RISK: Statistical probability of surviving 1+ weeks on a standard battery is only " ?percent "%. Consider a larger power source or aggressive deep-sleep programming."))))
)

; ---------------- EVALUATE LOW RISK ----------------
; Triggers if the user wants extended battery life and the board is well-suited for it
(defrule evaluate-battery-survival-success
  (phase (name probabilistic-eval))
  (environmental-risk (type extended-battery) (value yes))
  (recommendation (board ?b))
  (survival-probability (board ?b) (prob ?p))
  (test (>= ?p 0.70))
  =>
  (bind ?percent (* ?p 100))
  (assert (probabilistic-warning (board ?b) (text (str-cat "LOW RISK: This board has a " ?percent "% statistical probability of surviving extended battery deployment without issues."))))
)

; ---------------- PRINT PROBABILISTIC RESULTS ----------------
(defrule print-probabilistic-results
  (declare (salience -30))
  ?ph <- (phase (name probabilistic-eval))
  =>
  (printout t crlf "==========================================" crlf)
  (printout t " FINAL RISK REPORT " crlf)
  (printout t "==========================================" crlf)
  
  (bind ?warnings-found FALSE)
  (do-for-all-facts ((?w probabilistic-warning)) TRUE
    (printout t "-> [" ?w:board "] " ?w:text crlf)
    (bind ?warnings-found TRUE)
  )
  
  (if (not ?warnings-found)
    then (printout t "-> No critical probabilistic risks detected for your deployment scenario." crlf)
  )
  
  (printout t crlf "==========================================" crlf)
  (printout t " Expert System Analysis Complete." crlf)
  (printout t "==========================================" crlf)
  (retract ?ph)
)