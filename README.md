# Arduino Board Expert System

An intelligent recommendation system built using CLIPS (C Language Integrated Production System) that helps users select the appropriate Arduino board for their project based on their specific requirements.

##  Project Overview

This expert system guides users through a series of questions about their project needs and provides personalized Arduino board recommendations. The system uses rule-based reasoning to match user requirements with board capabilities.

**Current Version**: Currently supports Arduino Uno and Arduino MKR WiFi 1010 as a proof of concept. **Additional boards will be added in future iterations.**

**Developed for**: COMP 474/6741 - Intelligent Systems, Concordia University  
**Inspired by**: [How to Choose the Right Arduino Board for Your Project](https://predictabledesigns.com) by Predictable Designs

##  Features

- **Interactive Question-Based Interface**: Guides users through key decision factors
- **Deterministic Rule-Based Reasoning**: Uses logical rules to match requirements with boards
- **Modular Architecture**: Separates facts, rules, and main logic for maintainability
- **Extensible Design**: Framework supports future integration of possibilistic and probabilistic reasoning
- **Scalable Board Database**: Designed to easily accommodate additional Arduino boards
- **Detailed Explanations**: Provides reasons for each recommendation
- **Warning System**: Alerts users when their requirements may need consideration

##  Roadmap

### Current Status (v1.0)
- ✅ Core expert system framework
- ✅ Deterministic reasoning engine
- ✅ Two board profiles (Uno, MKR WiFi 1010)
- ✅ Four decision criteria (WiFi, sensors, I/O, battery)

### Coming Soon
- 🔄 **Expanding Board Database** - Adding popular boards including:
  - Arduino Mega (for high I/O requirements)
  - Arduino Nano (compact general-purpose)
  - Arduino Leonardo (USB HID capabilities)
  - Arduino Due (32-bit processing power)
  - Arduino Nano 33 series (BLE, IoT variants)
- 🔄 Additional decision criteria
- 🔄 Possibilistic reasoning for uncertain requirements
- 🔄 Probabilistic reasoning with confidence levels

## 🗂️ Project Structure
EXPERTSYSTEM/
├── main.clp # Entry point - loads all modules
├── facts/
│ ├── deterministic-facts.clp # Board features and templates
│ ├── possibilistic-facts.clp # [Placeholder for future work]
│ └── probabilistic-facts.clp # [Placeholder for future work]
└── rules/
├── deterministic-rules.clp # Decision rules and logic
├── possibilistic-rules.clp # [Placeholder for future work]
└── probabilistic-rules.clp # [Placeholder for future work]

Extensibility
The modular design allows easy expansion:

Add boards: Simply extend the board-knowledge deffacts in deterministic-facts.clp

Add criteria: Extend templates and add corresponding rules

Add reasoning types: Implement possibilistic/probabilistic modules
