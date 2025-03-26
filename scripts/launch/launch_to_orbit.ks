// Launch to Orbit Script
// This script launches a vessel to a specified orbit height and inclination
// Stage separation is MANUAL, and it calls circularize_orbit.ks after reaching apoapsis

CLEARSCREEN.
PRINT "=================================".
PRINT "      LAUNCH TO ORBIT SCRIPT     ".
PRINT "=================================".
PRINT " ".

// Get user input for orbit parameters with defaults
PRINT "Enter target orbit altitude (km) [default: 100]: ".
SET input TO TERMINAL:INPUT.
SET target_altitude TO 100. // Default value
IF input:LENGTH > 0 {
    SET target_altitude TO input:TONUMBER(100).
    IF target_altitude <= 0 {
        PRINT "Invalid input. Using default: 100 km.".
        SET target_altitude TO 100.
    }
}
SET target_apoapsis TO target_altitude * 1000. // Convert to meters

PRINT "Enter target orbit inclination (degrees) [default: 0]: ".
SET input TO TERMINAL:INPUT.
SET target_inclination TO 0. // Default value
IF input:LENGTH > 0 {
    SET target_inclination TO input:TONUMBER(0).
    IF target_inclination < 0 OR target_inclination > 180 {
        PRINT "Invalid input. Using default: 0 degrees.".
        SET target_inclination TO 0.
    }
}

// Display mission parameters
PRINT " ".
PRINT "Mission parameters:".
PRINT "Target altitude: " + target_altitude + " km".
PRINT "Target inclination: " + target_inclination + " degrees".
PRINT " ".

// Countdown
PRINT "Launch sequence initiated.".
FROM {local countdown is 5.} UNTIL countdown = 0 STEP {SET countdown to countdown - 1.} DO {
    PRINT "T-" + countdown + "...".
    WAIT 1.
}
PRINT "LIFTOFF!".

// Initial launch setup
LOCK THROTTLE TO 1.0.
LOCK STEERING TO HEADING(90, 90). // Initial vertical ascent
STAGE. // Ignite engines

// Gravity turn parameters
LOCAL turn_start_altitude TO 1000. // Meters
LOCAL turn_end_altitude TO 45000.  // Meters
LOCAL turn_angle TO 0.

// Main ascent loop
UNTIL APOAPSIS > target_apoapsis {
    // Calculate gravity turn angle
    IF ALTITUDE > turn_start_altitude AND ALTITUDE < turn_end_altitude {
        SET turn_angle TO 90 * (1 - (ALTITUDE - turn_start_altitude) / (turn_end_altitude - turn_start_altitude)).
    } ELSE IF ALTITUDE >= turn_end_altitude {
        SET turn_angle TO 0.
    } ELSE {
        SET turn_angle TO 90.
    }
    
    // Calculate heading based on desired inclination
    LOCAL launch_heading TO 90.
    IF target_inclination <= 90 {
        SET launch_heading TO 90 - target_inclination.
    } ELSE {
        SET launch_heading TO 270 - (180 - target_inclination).
    }
    
    // Update steering
    LOCK STEERING TO HEADING(launch_heading, turn_angle).
    
    // Display flight information
    PRINT "Altitude: " + ROUND(ALTITUDE/1000, 1) + " km    " AT (0, 15).
    PRINT "Apoapsis: " + ROUND(APOAPSIS/1000, 1) + " km    " AT (0, 16).
    PRINT "Target: " + ROUND(target_apoapsis/1000, 1) + " km    " AT (0, 17).
    
    // Cut throttle when approaching target apoapsis
    IF APOAPSIS > target_apoapsis * 0.95 {
        LOCK THROTTLE TO 0.1.
    }
    
    WAIT 0.1.
}

// Cut engines once target apoapsis is reached
LOCK THROTTLE TO 0.
PRINT " ".
PRINT "Target apoapsis reached!".
PRINT "Coasting to space...".

// Wait until we're in space
WAIT UNTIL ALTITUDE > 80000.
PRINT "Space achieved! Waiting for apoapsis...".

// Run the circularization script
PRINT "Running circularization script...".
RUNPATH("scripts/orbital/circularize_orbit.ks").

PRINT "Launch to orbit sequence complete!".

