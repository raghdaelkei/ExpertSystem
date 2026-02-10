; =========================
; rules/deterministic-rules.clp
; =========================

; Normalize yes/no input (reads from user, asserts an answer fact)
(defrule read-yes-no
  ?q <- (ask (slotname ?s) (prompt ?p))
  =>
  (printout t ?p crlf "> ")
  (bind ?ans (read))

  (if (or (eq ?ans yes) (eq ?ans y) (eq ?ans YES) (eq ?ans Y))
    then (assert (answer (slotname ?s) (value yes)))
    else (assert (answer (slotname ?s) (value no)))
  )

  (retract ?q)
)

; ---------------- START ----------------
(defrule start-system
  ?ph <- (phase (name start))
  =>
  (printout t crlf "arduino board expert system" crlf)
  (printout t "answer using: yes / no" crlf crlf)

  (retract ?ph)
  (assert (phase (name ask-wifi)))
)

; ---------------- ASK WIFI ----------------
(defrule ask-wifi
  ?ph <- (phase (name ask-wifi))
  =>
  (assert (ask (slotname wifi)
               (prompt "do you need wifi connectivity? (yes/no)")))
  (retract ?ph)
  (assert (phase (name wait-wifi)))
)

(defrule store-wifi
  ?ph <- (phase (name wait-wifi))
  ?a  <- (answer (slotname wifi) (value ?val))
  ?n  <- (need (item wifi) (value unknown))
  =>
  (retract ?a)
  (retract ?n)
  (assert (need (item wifi) (value ?val)))

  (retract ?ph)
  (assert (phase (name ask-sensors)))
)

; ---------------- ASK SENSORS ----------------
(defrule ask-sensors
  ?ph <- (phase (name ask-sensors))
  =>
  (assert (ask (slotname sensors)
               (prompt "will you interact with sensors (ex: temperature, light, motion)? (yes/no)")))
  (retract ?ph)
  (assert (phase (name wait-sensors)))
)

(defrule store-sensors
  ?ph <- (phase (name wait-sensors))
  ?a  <- (answer (slotname sensors) (value ?val))
  ?n  <- (need (item sensors) (value unknown))
  =>
  (retract ?a)
  (retract ?n)
  (assert (need (item sensors) (value ?val)))

  (retract ?ph)
  (assert (phase (name ask-io)))
)

; ---------------- ASK MANY IO ----------------
(defrule ask-io
  ?ph <- (phase (name ask-io))
  =>
  (assert (ask (slotname many-io)
               (prompt "do you need many input/output pins? (yes/no)")))
  (retract ?ph)
  (assert (phase (name wait-io)))
)

(defrule store-io
  ?ph <- (phase (name wait-io))
  ?a  <- (answer (slotname many-io) (value ?val))
  ?n  <- (need (item many-io) (value unknown))
  =>
  (retract ?a)
  (retract ?n)
  (assert (need (item many-io) (value ?val)))

  (retract ?ph)
  (assert (phase (name ask-battery)))
)

; ---------------- ASK BATTERY ----------------
(defrule ask-battery
  ?ph <- (phase (name ask-battery))
  =>
  (assert (ask (slotname battery)
               (prompt "does your project need to be battery powered / low power? (yes/no)")))
  (retract ?ph)
  (assert (phase (name wait-battery)))
)

(defrule store-battery
  ?ph <- (phase (name wait-battery))
  ?a  <- (answer (slotname battery) (value ?val))
  ?n  <- (need (item battery) (value unknown))
  =>
  (retract ?a)
  (retract ?n)
  (assert (need (item battery) (value ?val)))

  (retract ?ph)
  (assert (phase (name decide)))
)

; =========================
; DECISION RULES (2 boards)
; =========================

(defrule recommend-mkr-for-wifi
  (phase (name decide))
  (need (item wifi) (value yes))
  =>
  (assert (recommendation (board mkr-wifi-1010)))
  (assert (reason (text "wifi is required, and the mkr wifi 1010 has built-in wifi")))
)

(defrule recommend-mkr-for-battery
  (phase (name decide))
  (need (item wifi) (value no))
  (need (item battery) (value yes))
  =>
  (assert (recommendation (board mkr-wifi-1010)))
  (assert (reason (text "battery/low power matters; mkr boards are more battery-friendly and run at 3.3v")))
)

(defrule recommend-uno-default
  (phase (name decide))
  (need (item wifi) (value no))
  (need (item battery) (value no))
  =>
  (assert (recommendation (board uno)))
  (assert (reason (text "no wifi needed and no battery focus; uno is a general-purpose beginner-friendly choice")))
)

(defrule warn-many-io
  (phase (name decide))
  (need (item many-io) (value yes))
  =>
  (assert (warning (text "you need many i/o pins; with only two boards in this version, neither is ideal (a mega usually fits better)")))
)

; =========================
; OUTPUT
; =========================

(defrule print-result
  ?ph <- (phase (name decide))
  ?rec <- (recommendation (board ?b))
  =>
  (printout t crlf "recommendation: " ?b crlf)

  (do-for-all-facts ((?r reason)) TRUE
    (printout t "- reason: " ?r:text crlf))

  (do-for-all-facts ((?w warning)) TRUE
    (printout t "- note: " ?w:text crlf))

  (printout t crlf "done." crlf)

  (retract ?ph)
)
