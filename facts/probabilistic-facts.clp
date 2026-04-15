; =========================
; facts/probabilistic-facts.clp
; =========================

(deftemplate survival-probability
  (slot board)
  (slot prob (type FLOAT))) ; 1.0 = 100% chance to survive 1+ weeks on a standard LiPo

(deftemplate environmental-risk
  (slot type)
  (slot value))

(deftemplate probabilistic-warning
  (slot board)
  (slot text))

; --------- probabilistic knowledge ---------
(deffacts statistical-survival-rates
  ; =======================================
  ; ARDUINO PROBABILITIES
  ; =======================================
  ; 5V Linear Regulator Boards (Terrible for long-term battery)
  (survival-probability (board uno-q-4gb) (prob 0.05))
  (survival-probability (board uno-r3) (prob 0.15))
  (survival-probability (board uno-r3-smd) (prob 0.15))
  (survival-probability (board uno-r4-wifi) (prob 0.25))

  ; Wi-Fi Boards (Power hungry during TX/RX, but MKRs have sleep modes)
  (survival-probability (board mkr-1000-wifi) (prob 0.50))
  (survival-probability (board mkr-wifi-1010) (prob 0.60))

  ; Offline/Efficient Microcontrollers
  (survival-probability (board mkr-zero) (prob 0.85))

  ; LPWAN Boards (Engineered specifically for months/years on battery)
  (survival-probability (board mkr-wan-1310) (prob 0.95))
  (survival-probability (board mkr-fox-1200) (prob 0.98))

  ; =======================================
  ; RASPBERRY PI PROBABILITIES
  ; =======================================
  ; SBC Flagships (Massive current draw; will drain batteries in hours)
  (survival-probability (board raspi-5) (prob 0.01))
  (survival-probability (board raspi-4b) (prob 0.01))
  (survival-probability (board raspi-3b) (prob 0.02))

  ; Compute Modules (High performance, requires baseboard power management)
  (survival-probability (board raspi-cm4) (prob 0.02))
  (survival-probability (board raspi-cm3) (prob 0.03))
  (survival-probability (board raspi-cm1) (prob 0.04))

  ; Zero Series (Lower power consumption, but still runs a full OS)
  (survival-probability (board raspi-zero-2w) (prob 0.05))
  (survival-probability (board raspi-zero-w) (prob 0.06))
  (survival-probability (board raspi-zero) (prob 0.08))
)