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

; --------- initial knowledge ---------
(deffacts board-knowledge
  ; Registered Boards
  (board uno-r3)
  (board uno-r3-smd)
  (board uno-r4-wifi)
  (board mkr-wifi-1010)
  (board mkr-1000-wifi)
  (board mkr-zero)
  (board mkr-fox-1200)
  (board mkr-wan-1310)
  (board uno-q-4gb)

  ; UNO R3 Features
  (board-feature uno-r3 wifi no)
  (board-feature uno-r3 battery-friendly low)
  (board-feature uno-r3 audio no)
  (board-feature uno-r3 high-perf no)
  (board-feature uno-r3 ble no)
  (board-feature uno-r3 lora no)
  (board-feature uno-r3 sigfox no)
  (board-feature uno-r3 smd no)

  ; UNO R3 SMD Features
  (board-feature uno-r3-smd wifi no)
  (board-feature uno-r3-smd battery-friendly low)
  (board-feature uno-r3-smd audio no)
  (board-feature uno-r3-smd high-perf no)
  (board-feature uno-r3-smd ble no)
  (board-feature uno-r3-smd lora no)
  (board-feature uno-r3-smd sigfox no)
  (board-feature uno-r3-smd smd yes)

  ; UNO R4 WiFi Features
  (board-feature uno-r4-wifi wifi yes)
  (board-feature uno-r4-wifi battery-friendly low)
  (board-feature uno-r4-wifi audio no)
  (board-feature uno-r4-wifi high-perf no)
  (board-feature uno-r4-wifi ble yes)
  (board-feature uno-r4-wifi lora no)
  (board-feature uno-r4-wifi sigfox no)
  (board-feature uno-r4-wifi smd yes)

  ; MKR WiFi 1010 Features
  (board-feature mkr-wifi-1010 wifi yes)
  (board-feature mkr-wifi-1010 battery-friendly high)
  (board-feature mkr-wifi-1010 audio no)
  (board-feature mkr-wifi-1010 high-perf no)
  (board-feature mkr-wifi-1010 ble yes)
  (board-feature mkr-wifi-1010 lora no)
  (board-feature mkr-wifi-1010 sigfox no)
  (board-feature mkr-wifi-1010 smd yes)

  ; MKR 1000 WiFi Features
  (board-feature mkr-1000-wifi wifi yes)
  (board-feature mkr-1000-wifi battery-friendly high)
  (board-feature mkr-1000-wifi audio no)
  (board-feature mkr-1000-wifi high-perf no)
  (board-feature mkr-1000-wifi ble no)
  (board-feature mkr-1000-wifi lora no)
  (board-feature mkr-1000-wifi sigfox no)
  (board-feature mkr-1000-wifi smd yes)

  ; MKR ZERO Features
  (board-feature mkr-zero wifi no)
  (board-feature mkr-zero battery-friendly high)
  (board-feature mkr-zero audio yes)
  (board-feature mkr-zero high-perf no)
  (board-feature mkr-zero ble no)
  (board-feature mkr-zero lora no)
  (board-feature mkr-zero sigfox no)
  (board-feature mkr-zero smd yes)

  ; MKR FOX 1200 Features
  (board-feature mkr-fox-1200 wifi no)
  (board-feature mkr-fox-1200 battery-friendly high)
  (board-feature mkr-fox-1200 audio no)
  (board-feature mkr-fox-1200 high-perf no)
  (board-feature mkr-fox-1200 ble no)
  (board-feature mkr-fox-1200 lora no)
  (board-feature mkr-fox-1200 sigfox yes)
  (board-feature mkr-fox-1200 smd yes)

  ; MKR WAN 1310 Features
  (board-feature mkr-wan-1310 wifi no)
  (board-feature mkr-wan-1310 battery-friendly high)
  (board-feature mkr-wan-1310 audio no)
  (board-feature mkr-wan-1310 high-perf no)
  (board-feature mkr-wan-1310 ble no)
  (board-feature mkr-wan-1310 lora yes)
  (board-feature mkr-wan-1310 sigfox no)
  (board-feature mkr-wan-1310 smd yes)

  ; UNO Q 4GB Features
  (board-feature uno-q-4gb wifi yes)
  (board-feature uno-q-4gb battery-friendly low)
  (board-feature uno-q-4gb audio yes)
  (board-feature uno-q-4gb high-perf yes)
  (board-feature uno-q-4gb ble yes)
  (board-feature uno-q-4gb lora no)
  (board-feature uno-q-4gb sigfox no)
  (board-feature uno-q-4gb smd yes)

  (phase (name start))

  ; Unknown Needs
  (need (item wifi)      (value unknown))
  (need (item ble)       (value unknown))
  (need (item lora)      (value unknown))
  (need (item sigfox)    (value unknown))
  (need (item sensors)   (value unknown))
  (need (item many-io)   (value unknown))
  (need (item battery)   (value unknown))
  (need (item audio)     (value unknown))
  (need (item high-perf) (value unknown))
  (need (item smd)       (value unknown))
)