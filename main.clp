; =========================
; main.clp
; =========================

(clear)

; project directory path
(chdir "C:/Users/raghd/ExpertSystem")

; 1. Load Deterministic Knowledge Base
(load "facts/deterministic-facts.clp")
(load "rules/deterministic-rules.clp")

; 2. Load Possibilistic Knowledge Base
(load "facts/possibilistic-facts.clp")
(load "rules/possibilistic-rules.clp")

; 3. Load Probabilistic Knowledge Base
(load "facts/probabilistic-facts.clp")
(load "rules/probabilistic-rules.clp")

; Reset the environment (asserts all initial facts)
(reset)

; Helpful for debugging
;(watch rules);
;(watch facts
;(watch activations)

; Start the inference engine
(run)