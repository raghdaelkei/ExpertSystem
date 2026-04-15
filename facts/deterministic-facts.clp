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
  ; Registered Arduino Boards
  (board uno-r3)
  (board uno-r3-smd)
  (board uno-r4-wifi)
  (board mkr-wifi-1010)
  (board mkr-1000-wifi)
  (board mkr-zero)
  (board mkr-fox-1200)
  (board mkr-wan-1310)
  (board uno-q-4gb)

  ; Registered Raspberry Pi Boards
  (board raspi-3b)
  (board raspi-4b)
  (board raspi-5)
  (board raspi-zero)
  (board raspi-zero-w)
  (board raspi-zero-2w)
  (board raspi-cm1)
  (board raspi-cm3)
  (board raspi-cm4)

  ; =======================================
  ; ARDUINO FEATURE PROFILES
  ; =======================================

  ; UNO R3 Features
  (board-feature uno-r3 wifi no)
  (board-feature uno-r3 battery-friendly low)
  (board-feature uno-r3 audio no)
  (board-feature uno-r3 high-perf no)
  (board-feature uno-r3 ble no)
  (board-feature uno-r3 lora no)
  (board-feature uno-r3 sigfox no)
  (board-feature uno-r3 smd no)
  (board-feature uno-r3 ethernet no)
  (board-feature uno-r3 baseboard no)

  ; UNO R3 SMD Features
  (board-feature uno-r3-smd wifi no)
  (board-feature uno-r3-smd battery-friendly low)
  (board-feature uno-r3-smd audio no)
  (board-feature uno-r3-smd high-perf no)
  (board-feature uno-r3-smd ble no)
  (board-feature uno-r3-smd lora no)
  (board-feature uno-r3-smd sigfox no)
  (board-feature uno-r3-smd smd yes)
  (board-feature uno-r3-smd ethernet no)
  (board-feature uno-r3-smd baseboard no)

  ; UNO R4 WiFi Features
  (board-feature uno-r4-wifi wifi yes)
  (board-feature uno-r4-wifi battery-friendly low)
  (board-feature uno-r4-wifi audio no)
  (board-feature uno-r4-wifi high-perf no)
  (board-feature uno-r4-wifi ble yes)
  (board-feature uno-r4-wifi lora no)
  (board-feature uno-r4-wifi sigfox no)
  (board-feature uno-r4-wifi smd yes)
  (board-feature uno-r4-wifi ethernet no)
  (board-feature uno-r4-wifi baseboard no)

  ; MKR WiFi 1010 Features
  (board-feature mkr-wifi-1010 wifi yes)
  (board-feature mkr-wifi-1010 battery-friendly high)
  (board-feature mkr-wifi-1010 audio no)
  (board-feature mkr-wifi-1010 high-perf no)
  (board-feature mkr-wifi-1010 ble yes)
  (board-feature mkr-wifi-1010 lora no)
  (board-feature mkr-wifi-1010 sigfox no)
  (board-feature mkr-wifi-1010 smd yes)
  (board-feature mkr-wifi-1010 ethernet no)
  (board-feature mkr-wifi-1010 baseboard no)

  ; MKR 1000 WiFi Features
  (board-feature mkr-1000-wifi wifi yes)
  (board-feature mkr-1000-wifi battery-friendly high)
  (board-feature mkr-1000-wifi audio no)
  (board-feature mkr-1000-wifi high-perf no)
  (board-feature mkr-1000-wifi ble no)
  (board-feature mkr-1000-wifi lora no)
  (board-feature mkr-1000-wifi sigfox no)
  (board-feature mkr-1000-wifi smd yes)
  (board-feature mkr-1000-wifi ethernet no)
  (board-feature mkr-1000-wifi baseboard no)

  ; MKR ZERO Features
  (board-feature mkr-zero wifi no)
  (board-feature mkr-zero battery-friendly high)
  (board-feature mkr-zero audio yes)
  (board-feature mkr-zero high-perf no)
  (board-feature mkr-zero ble no)
  (board-feature mkr-zero lora no)
  (board-feature mkr-zero sigfox no)
  (board-feature mkr-zero smd yes)
  (board-feature mkr-zero ethernet no)
  (board-feature mkr-zero baseboard no)

  ; MKR FOX 1200 Features
  (board-feature mkr-fox-1200 wifi no)
  (board-feature mkr-fox-1200 battery-friendly high)
  (board-feature mkr-fox-1200 audio no)
  (board-feature mkr-fox-1200 high-perf no)
  (board-feature mkr-fox-1200 ble no)
  (board-feature mkr-fox-1200 lora no)
  (board-feature mkr-fox-1200 sigfox yes)
  (board-feature mkr-fox-1200 smd yes)
  (board-feature mkr-fox-1200 ethernet no)
  (board-feature mkr-fox-1200 baseboard no)

  ; MKR WAN 1310 Features
  (board-feature mkr-wan-1310 wifi no)
  (board-feature mkr-wan-1310 battery-friendly high)
  (board-feature mkr-wan-1310 audio no)
  (board-feature mkr-wan-1310 high-perf no)
  (board-feature mkr-wan-1310 ble no)
  (board-feature mkr-wan-1310 lora yes)
  (board-feature mkr-wan-1310 sigfox no)
  (board-feature mkr-wan-1310 smd yes)
  (board-feature mkr-wan-1310 ethernet no)
  (board-feature mkr-wan-1310 baseboard no)

  ; UNO Q 4GB Features
  (board-feature uno-q-4gb wifi yes)
  (board-feature uno-q-4gb battery-friendly low)
  (board-feature uno-q-4gb audio yes)
  (board-feature uno-q-4gb high-perf yes)
  (board-feature uno-q-4gb ble yes)
  (board-feature uno-q-4gb lora no)
  (board-feature uno-q-4gb sigfox no)
  (board-feature uno-q-4gb smd yes)
  (board-feature uno-q-4gb ethernet no)
  (board-feature uno-q-4gb baseboard no)

  ; =======================================
  ; RASPBERRY PI FEATURE PROFILES
  ; =======================================

  ; Raspberry Pi 3 Model B (Flagship)
  (board-feature raspi-3b wifi yes)
  (board-feature raspi-3b battery-friendly low)
  (board-feature raspi-3b audio yes)
  (board-feature raspi-3b high-perf yes)
  (board-feature raspi-3b ble yes)
  (board-feature raspi-3b lora no)
  (board-feature raspi-3b sigfox no)
  (board-feature raspi-3b smd yes)
  (board-feature raspi-3b ethernet yes)
  (board-feature raspi-3b baseboard no)

  ; Raspberry Pi 4 Model B (Flagship)
  (board-feature raspi-4b wifi yes)
  (board-feature raspi-4b battery-friendly low)
  (board-feature raspi-4b audio yes)
  (board-feature raspi-4b high-perf yes)
  (board-feature raspi-4b ble yes)
  (board-feature raspi-4b lora no)
  (board-feature raspi-4b sigfox no)
  (board-feature raspi-4b smd yes)
  (board-feature raspi-4b ethernet yes)
  (board-feature raspi-4b baseboard no)

  ; Raspberry Pi 5 (Flagship)
  (board-feature raspi-5 wifi yes)
  (board-feature raspi-5 battery-friendly low)
  (board-feature raspi-5 audio yes)
  (board-feature raspi-5 high-perf yes)
  (board-feature raspi-5 ble yes)
  (board-feature raspi-5 lora no)
  (board-feature raspi-5 sigfox no)
  (board-feature raspi-5 smd yes)
  (board-feature raspi-5 ethernet yes)
  (board-feature raspi-5 baseboard no)

  ; Raspberry Pi Zero (Zero Series)
  (board-feature raspi-zero wifi no)
  (board-feature raspi-zero battery-friendly high)
  (board-feature raspi-zero audio no)
  (board-feature raspi-zero high-perf yes)
  (board-feature raspi-zero ble no)
  (board-feature raspi-zero lora no)
  (board-feature raspi-zero sigfox no)
  (board-feature raspi-zero smd yes)
  (board-feature raspi-zero ethernet no)
  (board-feature raspi-zero baseboard no)

  ; Raspberry Pi Zero W (Zero Series)
  (board-feature raspi-zero-w wifi yes)
  (board-feature raspi-zero-w battery-friendly high)
  (board-feature raspi-zero-w audio no)
  (board-feature raspi-zero-w high-perf yes)
  (board-feature raspi-zero-w ble yes)
  (board-feature raspi-zero-w lora no)
  (board-feature raspi-zero-w sigfox no)
  (board-feature raspi-zero-w smd yes)
  (board-feature raspi-zero-w ethernet no)
  (board-feature raspi-zero-w baseboard no)

  ; Raspberry Pi Zero 2 W (Zero Series)
  (board-feature raspi-zero-2w wifi yes)
  (board-feature raspi-zero-2w battery-friendly high)
  (board-feature raspi-zero-2w audio no)
  (board-feature raspi-zero-2w high-perf yes)
  (board-feature raspi-zero-2w ble yes)
  (board-feature raspi-zero-2w lora no)
  (board-feature raspi-zero-2w sigfox no)
  (board-feature raspi-zero-2w smd yes)
  (board-feature raspi-zero-2w ethernet no)
  (board-feature raspi-zero-2w baseboard no)

  ; Raspberry Pi Compute Module 1 (CM Series)
  (board-feature raspi-cm1 wifi no)
  (board-feature raspi-cm1 battery-friendly low)
  (board-feature raspi-cm1 audio no)
  (board-feature raspi-cm1 high-perf yes)
  (board-feature raspi-cm1 ble no)
  (board-feature raspi-cm1 lora no)
  (board-feature raspi-cm1 sigfox no)
  (board-feature raspi-cm1 smd yes)
  (board-feature raspi-cm1 ethernet no)
  (board-feature raspi-cm1 baseboard yes)

  ; Raspberry Pi Compute Module 3 (CM Series)
  (board-feature raspi-cm3 wifi no)
  (board-feature raspi-cm3 battery-friendly low)
  (board-feature raspi-cm3 audio no)
  (board-feature raspi-cm3 high-perf yes)
  (board-feature raspi-cm3 ble no)
  (board-feature raspi-cm3 lora no)
  (board-feature raspi-cm3 sigfox no)
  (board-feature raspi-cm3 smd yes)
  (board-feature raspi-cm3 ethernet no)
  (board-feature raspi-cm3 baseboard yes)

  ; Raspberry Pi Compute Module 4 (CM Series)
  (board-feature raspi-cm4 wifi yes)
  (board-feature raspi-cm4 battery-friendly low)
  (board-feature raspi-cm4 audio no)
  (board-feature raspi-cm4 high-perf yes)
  (board-feature raspi-cm4 ble yes)
  (board-feature raspi-cm4 lora no)
  (board-feature raspi-cm4 sigfox no)
  (board-feature raspi-cm4 smd yes)
  (board-feature raspi-cm4 ethernet no)
  (board-feature raspi-cm4 baseboard yes)

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
  (need (item ethernet)  (value unknown))
  (need (item baseboard) (value unknown))
)