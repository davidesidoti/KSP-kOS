// Circularize Orbit Script
// This script performs a circularization burn at apoapsis
// to create a circular orbit

// Print initial information
CLEARSCREEN.
PRINT "=================================".
PRINT "   ORBIT CIRCULARIZATION SCRIPT  ".
PRINT "=================================".
PRINT " ".

// Lock throttle to 0 initially
LOCK THROTTLE TO 0.

// Calculate the delta-v needed for circularization at apoapsis
FUNCTION calc_circularize_dv {
    LOCAL mu IS CONSTANT:G * BODY:MASS.
    LOCAL r IS BODY:RADIUS + APOAPSIS.
    LOCAL v1 IS SQRT(mu * (2/(BODY:RADIUS + APOAPSIS) - 1/ORBIT:SEMIMAJORAXIS)).
    LOCAL v2 IS SQRT(mu/r).
    RETURN v2 - v1.
}

// Calculate burn time based on available thrust and delta-v
FUNCTION calc_burn_time {
    PARAMETER delta_v.
    LOCAL f IS SHIP:AVAILABLETHRUST.
    IF f = 0 { RETURN 0. } // Avoid division by zero
    LOCAL m IS SHIP:MASS * 1000. // Convert to kg
    RETURN m * (1 - CONSTANT:E^(-delta_v/SHIP:ISP)) / f.
}

// Main execution
PRINT "Calculating circularization parameters...".
LOCAL dv IS calc_circularize_dv().
LOCAL burn_time IS calc_burn_time(dv).
LOCAL half_burn IS burn_time / 2.

PRINT "Delta-V required: " + ROUND(dv, 2) + " m/s".
PRINT "Estimated burn time: " + ROUND(burn_time, 2) + " seconds".
PRINT " ".

// Wait until approaching apoapsis
PRINT "Waiting for apoapsis approach...".
WAIT UNTIL ETA:APOAPSIS <= half_burn + 60.

// Orient ship for the burn (prograde)
PRINT "Orienting ship prograde...".
LOCK STEERING TO PROGRADE.
WAIT UNTIL VANG(SHIP:FACING:VECTOR, PROGRADE:VECTOR) < 2.

// Fine-tune the approach to apoapsis
PRINT "Fine-tuning approach to apoapsis...".
WAIT UNTIL ETA:APOAPSIS <= half_burn.

// Execute the burn
PRINT "Executing circularization burn...".
LOCAL start_time IS TIME:SECONDS.
LOCAL stop_time IS start_time + burn_time.
LOCAL throttle_value IS 1.0.

LOCK THROTTLE TO throttle_value.

// Continue until orbit is nearly circular or burn time is exceeded
UNTIL (ORBIT:ECCENTRICITY < 0.01) OR (TIME:SECONDS >= stop_time) {
    // Reduce throttle for fine control as we approach circular orbit
    IF ORBIT:ECCENTRICITY < 0.03 {
        SET throttle_value TO 0.2.
    }
    
    // Update status
    PRINT "Current eccentricity: " + ROUND(ORBIT:ECCENTRICITY, 4) + "   " AT (0, 15).
    PRINT "Time remaining: " + ROUND(stop_time - TIME:SECONDS, 1) + " s   " AT (0, 16).
    
    WAIT 0.1.
}

// End the burn
LOCK THROTTLE TO 0.
PRINT " ".
PRINT "Circularization complete!".
PRINT "Final orbit: " + ROUND(PERIAPSIS, 0) + " x " + ROUND(APOAPSIS, 0) + " m".
PRINT "Eccentricity: " + ROUND(ORBIT:ECCENTRICITY, 4).

// Release the steering lock
UNLOCK STEERING.
