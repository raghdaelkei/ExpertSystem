# Arduino Board Expert System

An intelligent recommendation system built using CLIPS (C Language Integrated Production System) that helps engineers and makers select the perfect Microcontroller or Single Board Computer (SBC) for their project by evaluating hard constraints, subjective trade-offs, and environmental deployment risks.

##  Project Overview

Selecting the correct hardware for an embedded system involves navigating complex data sheets, subjective budget constraints, and physical deployment realities. This expert system guides users through a three-phase interactive interview, utilizing a robust rule-based engine to guarantee optimal hardware selection.

**Current Version**: The knowledge base currently evaluates 18 distinct hardware profiles spanning the Arduino ecosystem (microcontrollers) and the Raspberry Pi ecosystem (Linux SBCs and industrial compute modules).

**Developed for**: COMP 474/6741 - Intelligent Systems, Concordia University  
**Inspired by**: [https://predictabledesigns.com/how-to-choose-the-right-arduino-board-for-your-project/] by Predictable Designs

##  Features

- **Deterministic Logic**: Filters out incompatible boards based on strict hardware requirements (e.g., LoRa, Sigfox, Ethernet, I/O needs).
- **Possibilistic Uncertainty (Fuzzy Logic)**: Evaluates subjective user constraints like "Compactness" and "Affordability" against intrinsic board capabilities, complete with mathematical defuzzification to generate human-readable suitability ratings.
- **Probabilistic Uncertainty (Certainty Factors)**: Calculates the statistical probability of hardware failure by cross-referencing environmental hazards (extreme temperatures, high vibration, remote battery deployment) with physical board architectures (SMD vs. DIP, processor heat generation).
- **Interactive State-Machine**: Safely guides users through a branching question-chain, gracefully halting if impossible constraints are requested.
- **Explainable AI (XAI)**: Dynamically generates transparent reasoning logs and warning reports explaining exactly why a board was chosen or flagged for risk.
- **Modular Architecture**: Strictly separates Knowledge (Facts) from Inference (Rules) across specialized .clp files.
- **Warning System**: Alerts users when their requirements may need consideration

##  Knowledge Base (Supported Hardware)
### Arduino Ecosystem: 
Uno R3, Uno R3 SMD, Uno R4 WiFi, Uno Q 4GB,
MKR 1000 WiFi, MKR WiFi 1010, MKR Zero,
MKR FOX 1200, MKR WAN 1310
### Raspberry Pi Ecosystem:
Flagship Series (3B, 4B, 5),
Zero Series (Zero, Zero W, Zero 2 W),
Compute Module Series (CM1, CM3, CM4)

### System Architecture
The inference engine runs in three strictly controlled salience phases:

- **Phase 1 (Deterministic Filtering)**: Gathers binary user constraints and queries the 18-board matrix to find technically viable candidates.
- **Phase 2 (Hardware Engineering Trade-offs)**: Refines the viable candidates using Fuzzy logic math, outputting an aggregate Suitability Score. Catches conflicting engineering constraints (e.g., demanding extreme miniaturization and extreme affordability simultaneously).
- **Phase 3 (Probabilistic Risk Assessment)**: Calculates statistical failure percentages based on compound environmental deployment risks.

    ### Extensibility

The modular design allows easy expansion:

Add boards: Simply extend the board-knowledge deffacts in deterministic-facts.clp

Add criteria: Extend templates and add corresponding rules

Add reasoning types: Implement possibilistic/probabilistic modules

## 💻 Getting Started

### Prerequisites
- CLIPS 6.4.x installed on your machine.

### Execution
1. Clone the repository:
   ```bash
   git clone [https://github.com/raghdaelkei/ExpertSystem.git](https://github.com/raghdaelkei/ExpertSystem.git)
2. Open your CLIPS terminal.

3. Batch the main execution script (update the path to match your local directory):  (batch "C:/Path/To/ExpertSystem/main.clp")
   
5.  (run)
   
6. Follow the on-screen prompts using yes, no, or numerical float values (-1.0 to 1.0) as requested.
   
