; =========================
; rules/deterministic-rules.clp
; =========================
;42 deterministic rules
; Normalize yes/no input
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
  (printout t crlf "microcontroller & sbc expert system" crlf)
  (printout t "answer using: yes / no" crlf crlf)
  (retract ?ph)
  (assert (phase (name ask-high-perf)))
)

; ---------------- QUESTIONS ----------------
; Chain: high-perf -> lora -> sigfox -> wifi -> ble -> audio -> battery -> sensors -> io -> smd -> ethernet -> baseboard -> decide

(defrule ask-high-perf
  ?ph <- (phase (name ask-high-perf))
  =>
  (assert (ask (slotname high-perf) (prompt "do you need high performance, AI capabilities, or a full Linux OS? (yes/no)")))
  (retract ?ph) (assert (phase (name wait-high-perf)))
)
(defrule store-high-perf
  ?ph <- (phase (name wait-high-perf))
  ?a <- (answer (slotname high-perf) (value ?val))
  ?n <- (need (item high-perf) (value unknown))
  =>
  (retract ?a ?n) (assert (need (item high-perf) (value ?val)))
  (retract ?ph) (assert (phase (name ask-lora)))
)

(defrule ask-lora
  ?ph <- (phase (name ask-lora))
  =>
  (assert (ask (slotname lora) (prompt "do you need long-range LoRa/LoRaWAN connectivity? (yes/no)")))
  (retract ?ph) (assert (phase (name wait-lora)))
)
(defrule store-lora
  ?ph <- (phase (name wait-lora))
  ?a <- (answer (slotname lora) (value ?val))
  ?n <- (need (item lora) (value unknown))
  =>
  (retract ?a ?n) (assert (need (item lora) (value ?val)))
  (retract ?ph) (assert (phase (name ask-sigfox)))
)

(defrule ask-sigfox
  ?ph <- (phase (name ask-sigfox))
  =>
  (assert (ask (slotname sigfox) (prompt "do you need European Sigfox network connectivity? (yes/no)")))
  (retract ?ph) (assert (phase (name wait-sigfox)))
)
(defrule store-sigfox
  ?ph <- (phase (name wait-sigfox))
  ?a <- (answer (slotname sigfox) (value ?val))
  ?n <- (need (item sigfox) (value unknown))
  =>
  (retract ?a ?n) (assert (need (item sigfox) (value ?val)))
  (retract ?ph) (assert (phase (name ask-wifi)))
)

(defrule ask-wifi
  ?ph <- (phase (name ask-wifi))
  =>
  (assert (ask (slotname wifi) (prompt "do you need wifi connectivity? (yes/no)")))
  (retract ?ph) (assert (phase (name wait-wifi)))
)
(defrule store-wifi
  ?ph <- (phase (name wait-wifi))
  ?a <- (answer (slotname wifi) (value ?val))
  ?n <- (need (item wifi) (value unknown))
  =>
  (retract ?a ?n) (assert (need (item wifi) (value ?val)))
  (retract ?ph) (assert (phase (name ask-ble)))
)

(defrule ask-ble
  ?ph <- (phase (name ask-ble))
  =>
  (assert (ask (slotname ble) (prompt "do you need Bluetooth/BLE connectivity? (yes/no)")))
  (retract ?ph) (assert (phase (name wait-ble)))
)
(defrule store-ble
  ?ph <- (phase (name wait-ble))
  ?a <- (answer (slotname ble) (value ?val))
  ?n <- (need (item ble) (value unknown))
  =>
  (retract ?a ?n) (assert (need (item ble) (value ?val)))
  (retract ?ph) (assert (phase (name ask-audio)))
)

(defrule ask-audio
  ?ph <- (phase (name ask-audio))
  =>
  (assert (ask (slotname audio) (prompt "do you need to play or process digital audio/music via I2S/SD? (yes/no)")))
  (retract ?ph) (assert (phase (name wait-audio)))
)
(defrule store-audio
  ?ph <- (phase (name wait-audio))
  ?a <- (answer (slotname audio) (value ?val))
  ?n <- (need (item audio) (value unknown))
  =>
  (retract ?a ?n) (assert (need (item audio) (value ?val)))
  (retract ?ph) (assert (phase (name ask-battery)))
)

(defrule ask-battery
  ?ph <- (phase (name ask-battery))
  =>
  (assert (ask (slotname battery) (prompt "does your project need to be battery powered / low power? (yes/no)")))
  (retract ?ph) (assert (phase (name wait-battery)))
)
(defrule store-battery
  ?ph <- (phase (name wait-battery))
  ?a <- (answer (slotname battery) (value ?val))
  ?n <- (need (item battery) (value unknown))
  =>
  (retract ?a ?n) (assert (need (item battery) (value ?val)))
  (retract ?ph) (assert (phase (name ask-sensors)))
)

(defrule ask-sensors
  ?ph <- (phase (name ask-sensors))
  =>
  (assert (ask (slotname sensors) (prompt "will you interact with sensors (ex: temperature, motion)? (yes/no)")))
  (retract ?ph) (assert (phase (name wait-sensors)))
)
(defrule store-sensors
  ?ph <- (phase (name wait-sensors))
  ?a <- (answer (slotname sensors) (value ?val))
  ?n <- (need (item sensors) (value unknown))
  =>
  (retract ?a ?n) (assert (need (item sensors) (value ?val)))
  (retract ?ph) (assert (phase (name ask-io)))
)

(defrule ask-io
  ?ph <- (phase (name ask-io))
  =>
  (assert (ask (slotname many-io) (prompt "do you need many input/output pins? (yes/no)")))
  (retract ?ph) (assert (phase (name wait-io)))
)
(defrule store-io
  ?ph <- (phase (name wait-io))
  ?a <- (answer (slotname many-io) (value ?val))
  ?n <- (need (item many-io) (value unknown))
  =>
  (retract ?a ?n) (assert (need (item many-io) (value ?val)))
  (retract ?ph) (assert (phase (name ask-smd)))
)

(defrule ask-smd
  ?ph <- (phase (name ask-smd))
  =>
  (assert (ask (slotname smd) (prompt "do you specifically want an SMD (Surface Mount) chip instead of a removable DIP chip? (yes/no)")))
  (retract ?ph) (assert (phase (name wait-smd)))
)
(defrule store-smd
  ?ph <- (phase (name wait-smd))
  ?a <- (answer (slotname smd) (value ?val))
  ?n <- (need (item smd) (value unknown))
  =>
  (retract ?a ?n) (assert (need (item smd) (value ?val)))
  (retract ?ph) (assert (phase (name ask-ethernet)))
)

; --- RASPBERRY PI QUESTIONS ---

(defrule ask-ethernet
  ?ph <- (phase (name ask-ethernet))
  =>
  (assert (ask (slotname ethernet) (prompt "do you need a built-in hardware Ethernet port? (yes/no)")))
  (retract ?ph) (assert (phase (name wait-ethernet)))
)
(defrule store-ethernet
  ?ph <- (phase (name wait-ethernet))
  ?a <- (answer (slotname ethernet) (value ?val))
  ?n <- (need (item ethernet) (value unknown))
  =>
  (retract ?a ?n) (assert (need (item ethernet) (value ?val)))
  (retract ?ph) (assert (phase (name ask-baseboard)))
)

(defrule ask-baseboard
  ?ph <- (phase (name ask-baseboard))
  =>
  (assert (ask (slotname baseboard) (prompt "are you designing a custom industrial baseboard to host a compute module? (yes/no)")))
  (retract ?ph) (assert (phase (name wait-baseboard)))
)
(defrule store-baseboard
  ?ph <- (phase (name wait-baseboard))
  ?a <- (answer (slotname baseboard) (value ?val))
  ?n <- (need (item baseboard) (value unknown))
  =>
  (retract ?a ?n) (assert (need (item baseboard) (value ?val)))
  (retract ?ph) (assert (phase (name decide)))
)

; =========================
; DECISION RULES (Strict Constraints)
; =========================

; --- ARDUINO DECISION RULES ---

(defrule recommend-uno-q
  (phase (name decide))
  (need (item high-perf) (value yes))
  (need (item lora) (value no))
  (need (item sigfox) (value no))
  (need (item ethernet) (value no))
  (need (item baseboard) (value no))
  =>
  (assert (recommendation (board uno-q-4gb)))
  (assert (reason (text "high performance Linux is required without ethernet or LPWAN; the uno q 4gb handles complex processing in an arduino form factor")))
)

(defrule recommend-mkr-wan
  (phase (name decide))
  (need (item high-perf) (value no))
  (need (item lora) (value yes))
  (need (item sigfox) (value no))
  (need (item ethernet) (value no))
  (need (item baseboard) (value no))
  =>
  (assert (recommendation (board mkr-wan-1310)))
  (assert (reason (text "lora/lorawan connectivity is required for long range communication")))
)

(defrule recommend-mkr-fox
  (phase (name decide))
  (need (item high-perf) (value no))
  (need (item lora) (value no))
  (need (item sigfox) (value yes))
  (need (item ethernet) (value no))
  (need (item baseboard) (value no))
  =>
  (assert (recommendation (board mkr-fox-1200)))
  (assert (reason (text "sigfox connectivity is needed for european network infrastructure")))
)

(defrule recommend-mkr-zero
  (phase (name decide))
  (need (item high-perf) (value no))
  (need (item lora) (value no))
  (need (item sigfox) (value no))
  (need (item audio) (value yes))
  (need (item ethernet) (value no))
  (need (item baseboard) (value no))
  =>
  (assert (recommendation (board mkr-zero)))
  (assert (reason (text "audio/music processing is needed; the mkr zero features an I2S bus and SD card slot")))
)

(defrule recommend-mkr-wifi-1010
  (phase (name decide))
  (need (item high-perf) (value no)) 
  (need (item lora) (value no)) 
  (need (item sigfox) (value no)) 
  (need (item audio) (value no))
  (need (item wifi) (value yes))
  (need (item ble) (value yes))
  (need (item battery) (value yes)) 
  (need (item ethernet) (value no))
  (need (item baseboard) (value no))
  =>
  (assert (recommendation (board mkr-wifi-1010)))
  (assert (reason (text "wifi, bluetooth, and battery efficiency are required; the mkr wifi 1010 handles all three perfectly")))
)

(defrule recommend-mkr-1000-wifi
  (phase (name decide))
  (need (item high-perf) (value no)) 
  (need (item lora) (value no)) 
  (need (item sigfox) (value no)) 
  (need (item audio) (value no))
  (need (item wifi) (value yes))
  (need (item ble) (value no))
  (need (item battery) (value yes)) 
  (need (item ethernet) (value no))
  (need (item baseboard) (value no))
  =>
  (assert (recommendation (board mkr-1000-wifi)))
  (assert (reason (text "wifi and battery efficiency are needed without bluetooth; the mkr 1000 wifi provides basic iot connectivity")))
)

(defrule recommend-uno-r4-wifi
  (phase (name decide))
  (need (item high-perf) (value no)) 
  (need (item lora) (value no)) 
  (need (item sigfox) (value no)) 
  (need (item audio) (value no))
  (need (item wifi) (value yes))
  (need (item battery) (value no)) 
  (need (item ethernet) (value no))
  (need (item baseboard) (value no))
  =>
  (assert (recommendation (board uno-r4-wifi)))
  (assert (reason (text "wifi is needed but not battery power; the uno r4 wifi provides wireless connectivity in a standard 5v form factor")))
)

(defrule recommend-uno-r3-smd
  (phase (name decide))
  (need (item high-perf) (value no)) 
  (need (item lora) (value no)) 
  (need (item sigfox) (value no)) 
  (need (item audio) (value no))
  (need (item wifi) (value no))
  (need (item smd) (value yes))
  (need (item ethernet) (value no))
  (need (item baseboard) (value no))
  =>
  (assert (recommendation (board uno-r3-smd)))
  (assert (reason (text "a general-purpose board with an integrated SMD microcontroller chip was requested")))
)

(defrule recommend-uno-r3-default
  (phase (name decide))
  (need (item high-perf) (value no)) 
  (need (item lora) (value no)) 
  (need (item sigfox) (value no)) 
  (need (item audio) (value no))
  (need (item wifi) (value no))
  (need (item smd) (value no))
  (need (item ethernet) (value no))
  (need (item baseboard) (value no))
  =>
  (assert (recommendation (board uno-r3)))
  (assert (reason (text "no special communication or performance requirements; the classic uno r3 with the removable dip chip is the standard choice")))
)

(defrule warn-many-io
  (phase (name decide))
  (need (item many-io) (value yes))
  (need (item high-perf) (value no))
  =>
  (assert (warning (text "you need many i/o pins; consider adding an arduino mega in the future, as the basic uno and mkr boards have limited pins")))
)

; --- RASPBERRY PI DECISION RULES ---

(defrule recommend-raspi-flagship
  (phase (name decide))
  (need (item high-perf) (value yes))
  (need (item ethernet) (value yes))
  (need (item baseboard) (value no))
  (need (item lora) (value no))
  (need (item sigfox) (value no))
  =>
  (assert (recommendation (board raspi-5)))
  (assert (recommendation (board raspi-4b)))
  (assert (recommendation (board raspi-3b)))
  (assert (reason (text "high performance Linux processing and an ethernet port are required; the Raspberry Pi Flagship series provides these capabilities")))
)

(defrule recommend-raspi-zero-wifi
  (phase (name decide))
  (need (item high-perf) (value yes))
  (need (item ethernet) (value no))
  (need (item baseboard) (value no))
  (need (item battery) (value yes))
  (need (item wifi) (value yes))
  (need (item lora) (value no))
  (need (item sigfox) (value no))
  =>
  (assert (recommendation (board raspi-zero-2w)))
  (assert (recommendation (board raspi-zero-w)))
  (assert (reason (text "a compact, low-power Linux system with wifi is needed; the Raspberry Pi Zero W and Zero 2 W fit perfectly")))
)

(defrule recommend-raspi-zero-offline
  (phase (name decide))
  (need (item high-perf) (value yes))
  (need (item ethernet) (value no))
  (need (item baseboard) (value no))
  (need (item battery) (value yes))
  (need (item wifi) (value no))
  (need (item lora) (value no))
  (need (item sigfox) (value no))
  =>
  (assert (recommendation (board raspi-zero)))
  (assert (reason (text "a compact Linux system is needed without wireless connectivity; the classic offline Raspberry Pi Zero is the most efficient choice")))
)

(defrule recommend-raspi-cm4
  (phase (name decide))
  (need (item high-perf) (value yes))
  (need (item baseboard) (value yes))
  (need (item wifi) (value yes))
  (need (item lora) (value no))    
  (need (item sigfox) (value no))  
  =>
  (assert (recommendation (board raspi-cm4)))
  (assert (reason (text "an industrial compute module with wifi is required for a custom baseboard; the Raspberry Pi CM4 is highly recommended")))
)

(defrule recommend-raspi-cm-basic
  (phase (name decide))
  (need (item high-perf) (value yes))
  (need (item baseboard) (value yes))
  (need (item wifi) (value no))
  (need (item lora) (value no))    
  (need (item sigfox) (value no))  
  =>
  (assert (recommendation (board raspi-cm3)))
  (assert (recommendation (board raspi-cm1)))
  (assert (reason (text "an industrial compute module without wireless is required for a custom baseboard; the Raspberry Pi CM1 or CM3 is recommended")))
)
; ---------------- NO MATCH ERROR HANDLING ----------------
(defrule no-match-found
  (declare (salience -5)) ; Runs right before the standard print-result (which is -10)
  (phase (name decide))
  (not (recommendation (board ?))) ; Checks if NO recommendations were asserted
  =>
  (printout t crlf "==========================================" crlf)
  (printout t " RECOMMENDED BOARDS " crlf)
  (printout t "==========================================" crlf)
  (printout t "-> No board has all these requirements natively." crlf)
  (printout t "-> System terminating. Please run (reset) and (run) to try again with fewer constraints." crlf)
  (printout t "==========================================" crlf crlf)
  (halt) ; Instantly kills the inference engine, preventing Phase 2 and 3
)
; =========================
; OUTPUT
; =========================

(defrule print-result
  (declare (salience -10))
  ?ph <- (phase (name decide))
  =>
  (printout t crlf "==========================================" crlf)
  (printout t " RECOMMENDED BOARDS " crlf)
  (printout t "==========================================" crlf)
  
  (do-for-all-facts ((?rec recommendation)) TRUE
    (printout t "-> " ?rec:board crlf))

  (printout t crlf "--- REASONS ---" crlf)
  (do-for-all-facts ((?r reason)) TRUE
    (printout t "- " ?r:text crlf))

  (do-for-all-facts ((?w warning)) TRUE
    (printout t "- note: " ?w:text crlf))

  (printout t crlf "done." crlf)

  (retract ?ph)
)