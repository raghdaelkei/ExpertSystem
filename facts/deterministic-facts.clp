; =========================
; facts/deterministic-facts.clp
; =========================

; --------- templates ---------
(deftemplate phase
  (slot name))

(deftemplate need
  (slot item)
  (slot value))

(deftemplate ask
  (slot slotname)
  (slot prompt))

(deftemplate answer
  (slot slotname)
  (slot value))

(deftemplate recommendation
  (slot board))

(deftemplate reason
  (slot text))

(deftemplate warning
  (slot text))

; (board-feature <board> <feature> <value>) stays as ordered fact (fine)
; (board <name>) stays as ordered fact (fine)

; --------- initial knowledge ---------
(deffacts board-knowledge
  (board uno)
  (board mkr-wifi-1010)

  (board-feature uno wifi no)
  (board-feature uno voltage 5v)
  (board-feature uno size standard)
  (board-feature uno io-level low)
  (board-feature uno battery-friendly medium)
  (board-feature uno sensors yes)

  (board-feature mkr-wifi-1010 wifi yes)
  (board-feature mkr-wifi-1010 voltage 3v3)
  (board-feature mkr-wifi-1010 size compact)
  (board-feature mkr-wifi-1010 io-level medium)
  (board-feature mkr-wifi-1010 battery-friendly high)
  (board-feature mkr-wifi-1010 sensors yes)

  (phase (name start))

  (need (item wifi)      (value unknown))
  (need (item sensors)   (value unknown))
  (need (item many-io)   (value unknown))
  (need (item battery)   (value unknown))
)
