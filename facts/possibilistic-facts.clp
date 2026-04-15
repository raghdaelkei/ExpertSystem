; =========================
; facts/possibilistic-facts.clp
; =========================

; --------- templates ---------
(deftemplate board-fuzziness
  (slot board)
  (slot compactness-cf (type FLOAT))   ; 1.0 = extremely compact, -1.0 = massive
  (slot affordability-cf (type FLOAT))) ; 1.0 = extremely cheap, -1.0 = very expensive

(deftemplate fuzzy-need
  (slot item)
  (slot importance-cf (type FLOAT)))

(deftemplate possibilistic-score
  (slot board)
  (slot score (type FLOAT)))
  
(deftemplate fuzzy-category
  (slot board)
  (slot rating))

; --------- fuzzy knowledge ---------
(deffacts fuzzy-board-data
  ; =======================================
  ; ARDUINO FUZZY PROFILES
  ; =======================================
  ; UNO Family (Bulky but generally affordable, except the Q 4GB)
  (board-fuzziness (board uno-r3) (compactness-cf -0.5) (affordability-cf 0.6))
  (board-fuzziness (board uno-r3-smd) (compactness-cf -0.5) (affordability-cf 0.6))
  (board-fuzziness (board uno-r4-wifi) (compactness-cf -0.5) (affordability-cf 0.5))
  (board-fuzziness (board uno-q-4gb) (compactness-cf -0.5) (affordability-cf -0.8))

  ; MKR Family (Highly compact, varying price points)
  (board-fuzziness (board mkr-wifi-1010) (compactness-cf 0.8) (affordability-cf 0.2))
  (board-fuzziness (board mkr-1000-wifi) (compactness-cf 0.8) (affordability-cf 0.3))
  (board-fuzziness (board mkr-zero) (compactness-cf 0.8) (affordability-cf 0.4))
  (board-fuzziness (board mkr-fox-1200) (compactness-cf 0.8) (affordability-cf 0.1))
  (board-fuzziness (board mkr-wan-1310) (compactness-cf 0.8) (affordability-cf -0.1))

  ; =======================================
  ; RASPBERRY PI FUZZY PROFILES
  ; =======================================
  ; Flagship Series (Credit card sized, thicker due to ports, getting more expensive)
  (board-fuzziness (board raspi-3b) (compactness-cf -0.4) (affordability-cf 0.1))
  (board-fuzziness (board raspi-4b) (compactness-cf -0.4) (affordability-cf -0.2))
  (board-fuzziness (board raspi-5) (compactness-cf -0.4) (affordability-cf -0.5))

  ; Zero Series (Extremely minimal form factor, highly affordable)
  (board-fuzziness (board raspi-zero) (compactness-cf 0.9) (affordability-cf 0.9))
  (board-fuzziness (board raspi-zero-w) (compactness-cf 0.9) (affordability-cf 0.8))
  (board-fuzziness (board raspi-zero-2w) (compactness-cf 0.9) (affordability-cf 0.7))

  ; Compute Module Series (Very compact core modules, moderate pricing)
  (board-fuzziness (board raspi-cm1) (compactness-cf 0.8) (affordability-cf 0.3))
  (board-fuzziness (board raspi-cm3) (compactness-cf 0.8) (affordability-cf 0.1))
  (board-fuzziness (board raspi-cm4) (compactness-cf 0.8) (affordability-cf -0.2))
)