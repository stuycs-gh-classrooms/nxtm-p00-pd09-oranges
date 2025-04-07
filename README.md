[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/rXX1_Uiw)
## Project 00
### NeXTCS
### Period: 9
## Name0: Asna Rahman
## Name1: Aahan Shah    
## Name2: Dickson Jiang 
---

This project will be completed in phases. The first phase will be to work on this document. Use github-flavoured markdown. (For more markdown help [click here](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) or [here](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax) )

All projects will require the following:
- Researching new forces to implement.
- Method for each new force, returning a `PVector`  -- similar to `getGravity` and `getSpring` (using whatever parameters are necessary).
- A distinct demonstration for each individual force (including gravity and the spring force).
- A visual menu at the top providing information about which simulation is currently active and indicating whether movement is on or off.
- The ability to toggle movement on/off
- The ability to toggle bouncing on/off
- The user should be able to switch _between_ simluations using the number keys as follows:
  - `1`: Gravity
  - `2`: Spring Force
  - `3`: Drag
  - `4`: Custom Force
  - `5`: Combination


## Phase 0: Force Selection, Analysis & Plan
---------- 

#### Custom Force: Magentic force
### Forumla
What is the formula for your force? Including descriptions/definitions for the symbols. (You may include a picture of the formula if it is not easily typed.)
F = qvBsin(theta)
-𝐹 = Force exerted on the charged orb
-q = Charge of the orb
-𝑣 = Velocity of the orb
-B = Magnetic field strength
-θ = Angle between velocity and magnetic field

### Custom Force
- What information that is already present in the `Orb` or `OrbNode` classes does this force use?
  - Velocity: The force depends on the velocity of the orb.
  - applyForce(): The calculated force will be applied to the orb using this method.

- Does this force require any new constants, if so what are they and what values will you try initially?
  - Yes, we will need q for charge, B for magentic field strength, and angle.
  - (q): Each orb will have a charge in a set range, e.g,. -5 to 5
  - (B): A constant set by the simulation, e.g., 0.1
  - θ: Derived from the orb’s velocity direction relative to the field.

- Does this force require any new information to be added to the `Orb` class? If so, what is it and what data type will you use?
  - Yes, we will need a charge for each orb, the angle at which each orb is moving, and the magnetic field strength of the fixedOrb.
  - Charge: (float charge) to store the charge of each orb.
  - Magnetic Field Strength: (float B) representing environmental magnetic field strength.
    
- Does this force interact with other `Orbs`, or is it applied based on the environment?
  - This force does not require interactions between orbs but depends on their velocity and the ambient magnetic field.

  - In order to calculate this force, do you need to perform extra intermediary calculations? If so, what?
  - The angle θ must be computed using PVector.angleBetween().
  - The force direction follows the right-hand rule (perpendicular to velocity and field direction).
--- 

### Simulation 1: Gravity
Describe how you will attempt to simulate orbital motion.

--- Create a fixed orb that all the other orbs will orbit. The formula will have the fixed orb as one object and the orb doing the orbiting as the other. According to the formula, if the distance between the orb and the fixed orb is smaller, it will orbit closer because the force is stronger.

--A fixed "earth" orb exerts gravity on moving orbs.
--The force follows Newton’s law of universal gravitation.
--Orbs will orbit if initial velocity is properly set.
--Expected behavior: Orbs accelerate towards the fixed orb, creating elliptical orbits if initial conditions are right.

### Simulation 2: Spring
Describe what your spring simulation will look like. Explain how it will be setup, and how it should behave while running.

  -A series of connected orbs mimic a spring-like motion.
  -Each orb applies a restoring force proportional to its displacement from an equilibrium distance.
  -Expected behavior: Orbs oscillate back and forth like a mass-spring system.
--- 

### Simulation 3: Drag
Describe what your drag simulation will look like. Explain how it will be setup, and how it should behave while running.

-Orbs experience a force opposing their motion, proportional to velocity squared.
-The simulation applies the drag force to slow down moving orbs.
-Expected behavior: Fast-moving orbs decelerate more, and eventually, all stop moving.

--- 

### Simulation 4: Custom force
Describe what your Custom force simulation will look like. Explain how it will be setup, and how it should behave while running.
-Orbs with charge interact with a uniform magnetic field using the formula mentioned above
-The force is perpendicular to velocity, causing circular or helical motion.
-Add charge property to orbs.
-Use PVector.cross() to compute the correct force direction
-If the velocity is perpendicular to the field, orbs move in circles.
-If there is a velocity component parallel to the field, motion is helical.

--- 

### Simulation 5: Combination
Describe what your combination simulation will look like. Explain how it will be setup, and how it should behave while running.

- There will be multiple orbs and one fixed orb.
- Gravity, drag, and spring will be utilized.
- We expect orbs to move towards the fixed orb while oscillating back and forth between orbs and slowly decelerate. Once the optimal velocity is reached, the orbs will begin orbiting the fixed orb.

