; =========================
; rules/probabilistic-rules.clp
; =========================

; ---------------- 1. START PROBABILISTIC PHASE ----------------
(defrule start-probabilistic-phase
  (declare (salience -25))
  =>
  (printout t crlf "==========================================" crlf)
  (printout t " PHASE 3: PROBABILISTIC RISK ASSESSMENT " crlf)
  (printout t "==========================================" crlf)
  (printout t "Let's assess environmental deployment risks." crlf crlf)
  
  (printout t "Will this system be deployed remotely on battery power for an extended period (1+ weeks)? (yes/no): ")
  (bind ?ans1 (read))
  (if (or (eq ?ans1 yes) (eq ?ans1 y) (eq ?ans1 YES) (eq ?ans1 Y))
    then (assert (environmental-risk (type extended-battery) (value yes)))
    else (assert (environmental-risk (type extended-battery) (value no)))
  )

  (printout t "Will this system be deployed in a high-vibration environment (e.g., machinery, rockets, drones)? (yes/no): ")
  (bind ?ans2 (read))
  (if (or (eq ?ans2 yes) (eq ?ans2 y) (eq ?ans2 YES) (eq ?ans2 Y))
    then (assert (environmental-risk (type high-vibration) (value yes)))
    else (assert (environmental-risk (type high-vibration) (value no)))
  )

  (printout t "Will this system be exposed to extreme outdoor temperatures? (yes/no): ")
  (bind ?ans3 (read))
  (if (or (eq ?ans3 yes) (eq ?ans3 y) (eq ?ans3 YES) (eq ?ans3 Y))
    then (assert (environmental-risk (type extreme-temp) (value yes)))
    else (assert (environmental-risk (type extreme-temp) (value no)))
  )
  
  (assert (phase (name probabilistic-eval)))
)

; ---------------- 2. EVALUATE HIGH BATTERY RISK ----------------
(defrule evaluate-battery-survival-risk
  (phase (name probabilistic-eval))
  (environmental-risk (type extended-battery) (value yes))
  (recommendation (board ?b))
  (survival-probability (board ?b) (prob ?p))
  (test (< ?p 0.70)) 
  =>
  (bind ?percent (* ?p 100))
  (assert (probabilistic-warning (board ?b) (text (str-cat "HIGH RISK: Statistical probability of surviving 1+ weeks on a standard battery is only " ?percent "%. Consider a larger power source."))))
)

; ---------------- 3. EVALUATE LOW BATTERY RISK ----------------
(defrule evaluate-battery-survival-success
  (phase (name probabilistic-eval))
  (environmental-risk (type extended-battery) (value yes))
  (recommendation (board ?b))
  (survival-probability (board ?b) (prob ?p))
  (test (>= ?p 0.70))
  =>
  (bind ?percent (* ?p 100))
  (assert (probabilistic-warning (board ?b) (text (str-cat "LOW RISK: This board has a " ?percent "% statistical probability of surviving extended battery deployment."))))
)

; ---------------- 4. EVALUATE VIBRATION RISK (DIP CHIPS) ----------------
(defrule evaluate-vibration-risk-dip
  (phase (name probabilistic-eval))
  (environmental-risk (type high-vibration) (value yes))
  (recommendation (board ?b))
  (board-feature ?b smd no) ; Cross-referencing Phase 1 facts!
  =>
  (assert (probabilistic-warning (board ?b) (text "HIGH RISK (60% Failure Probability): High vibration can cause socketed DIP chips to unseat. Consider an SMD variant.")))
)

; ---------------- 5. EVALUATE VIBRATION SUCCESS (SMD CHIPS) ----------------
(defrule evaluate-vibration-success-smd
  (phase (name probabilistic-eval))
  (environmental-risk (type high-vibration) (value yes))
  (recommendation (board ?b))
  (board-feature ?b smd yes)
  =>
  (assert (probabilistic-warning (board ?b) (text "LOW RISK (95% Survival Probability): Soldered SMD components are highly resistant to vibration-induced disconnections.")))
)

; ---------------- 6. EVALUATE TEMPERATURE RISK (SBCs) ----------------
(defrule evaluate-temperature-risk-sbc
  (phase (name probabilistic-eval))
  (environmental-risk (type extreme-temp) (value yes))
  (recommendation (board ?b))
  (board-feature ?b high-perf yes) ; High-perf boards (like Raspberry Pi) run hot
  =>
  (assert (probabilistic-warning (board ?b) (text "HIGH RISK (75% Thermal Failure): High-performance Linux SBCs generate significant heat. Extreme ambient temperatures drastically increase thermal throttling and failure probabilities.")))
)

; ---------------- 7. EVALUATE TEMPERATURE SUCCESS (MCUs) ----------------
(defrule evaluate-temperature-success-mcu
  (phase (name probabilistic-eval))
  (environmental-risk (type extreme-temp) (value yes))
  (recommendation (board ?b))
  (board-feature ?b high-perf no)
  =>
  (assert (probabilistic-warning (board ?b) (text "LOW RISK (90% Survival Probability): Standard microcontrollers lack complex OS overhead and operate reliably across wide industrial temperature ranges.")))
)

; --------------   8. EVALUATE COMPOUND EXTREME RISK ----------------
(defrule evaluate-combined-extreme-risk
  (phase (name probabilistic-eval))
  (environmental-risk (type high-vibration) (value yes))
  (environmental-risk (type extreme-temp) (value yes))
  (recommendation (board ?b))
  =>
  (assert (probabilistic-warning (board ?b) (text "CRITICAL COMPOUND RISK: Combining extreme temperatures with high vibrations exponentially increases solder joint degradation (approx. 45% cumulative lifespan reduction).")))
)

; -------------- 9 EVALUATE BASELINE SAFETY ----------------
(defrule evaluate-baseline-safety
  (phase (name probabilistic-eval))
  (environmental-risk (type extended-battery) (value no))
  (environmental-risk (type high-vibration) (value no))
  (environmental-risk (type extreme-temp) (value no))
  (recommendation (board ?b))
  =>
  (assert (probabilistic-warning (board ?b) (text "BASELINE RELIABILITY (99% Success Probability): Standard indoor/lab deployment parameters detected. Environmental hardware failure risk is negligible.")))
)

; ---------------- 10. PRINT PROBABILISTIC RESULTS   ---------------
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