# Geolocation Estimation from Geostationary Satellite Data

## Overview

This MATLAB script estimates the geographical position (latitude and longitude) of an observer on Earth based on azimuth and elevation measurements to a known geostationary satellite. Using **Newton's Method** for optimization, it iterates to find the best estimate for the observer’s position based on the difference between the computed and measured azimuth angles.

### Purpose:
The script is designed for scenarios where an observer (such as a ground station) has measurements of the azimuth and elevation angles to a geostationary satellite. These measurements can be used to estimate the position of the observer on Earth.

## Features

- **Geostationary Satellite Tracking**: Calculates the observer's position (latitude, longitude) using satellite data.
- **Newton's Method**: Iteratively refines the position estimate based on residuals from computed and measured azimuth values.
- **Customization**: Allows for easy modification of satellite positions, observed angles, and initial guesses.

## Constants and Parameters

- **Earth Radius (R_e)**: 6371 km
- **Geostationary Satellite Altitude (h_sat)**: 42164 km
- **Assumed Position**: Default starting guess of 40°N latitude, -76°W longitude
- **Satellite Position**: The script uses the first geostationary satellite at 0° latitude and -115.2° longitude.
- **Measured Azimuth and Elevation Angles**: Default values for azimuth (231.4°) and elevation (29.9°) to the first satellite.

## Functionality

1. **Objective Function**: The core function calculates the difference between the measured and computed azimuth tangents. This is used as the residual to guide the optimization.
2. **Newton's Method**: The optimization iteratively updates the observer’s latitude and longitude guess until the residual is sufficiently small (tolerance of 1e-6).
3. **Convergence Check**: The script stops when the residual is less than the specified tolerance, signaling that the position has been determined.

## Usage

1. **Modify Satellite Position**: You can change the `lat_sat1` and `lon_sat1` values to match the positions of the satellites you are observing.
2. **Update Measured Angles**: If you have different azimuth and elevation angles, you can update the `azimuth_measured1` and `elevation_measured1` values.
3. **Run the Script**: Once you have set your desired values, simply run the script to estimate the observer’s latitude and longitude.

## Example

```matlab
% Example with custom satellite position and measured angles
lat_sat1 = 0; % Latitude of satellite 1
lon_sat1 = -100; % Longitude of satellite 1
azimuth_measured1 = 210; % Measured azimuth angle
elevation_measured1 = 25; % Measured elevation angle
