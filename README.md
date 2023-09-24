Character Life Simulator in Godot
Overview

This repository contains a Character Life Simulator built using the Godot game engine. The simulator models the needs and activities of a character living in a modern city. The character's behavior is determined by a utility-based AI system that selects activities to fulfill various needs such as sleep, food, entertainment, etc.

Note: This is designed to be a component that you can incorporate into your own Godot games to simulate character needs and behaviors.
Features

    Utility-based AI: Selects the best activity for the character based on a utility function.
    Dynamic Needs: Character's needs decay over time and are replenished by performing activities.
    GUI: Displays current state of the character's needs.
    Time-based Activities: Some activities are available only during certain times.
    Character-specific Activities: Some activities are unique to specific characters.

Code Structure
Character_Class.gd

    Contains the main character class with the following functionalities:
        Initializes character with a set of initial needs and decay rates.
        Calculates the utility of each activity based on current needs.
        Updates the character's needs based on selected activities.
        Decays the character's needs over time.

Main.gd

    Initializes the character and GUI.
    Updates the GUI to reflect the character's current state.
    Contains a timer to simulate time passing and trigger activity selection.
