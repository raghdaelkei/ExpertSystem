; =========================
; main.clp
; =========================

(clear)
(chdir "C:/Users/raghd/ExpertSystem")

; Load deterministic system (start here)
(load "facts/deterministic-facts.clp")
(load "rules/deterministic-rules.clp")

; empty for now (safe placeholders)
(load "facts/possibilistic-facts.clp")
(load "rules/possibilistic-rules.clp")

(load "facts/probabilistic-facts.clp")
(load "rules/probabilistic-rules.clp")

(reset)

; Helpful for debugging 
(watch rules)
(watch facts)
(watch activations)

(run)
