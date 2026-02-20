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

; --------- fuzzy knowledge ---------
(deffacts fuzzy-board-data
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
)