% clc
% clear all
% 
% % Define constants
% R_e = 6371; % Earth radius in kilometers
% h_sat = 42164; % Geostationary satellite altitude in kilometers
% lat_assumed = 40; % Assumed latitude in degrees
% lon_assumed = -76; % Assumed longitude in degrees
% 
% % Define positions of the geostationary satellites
% lat_sat1 = 0; % Latitude of the first geostationary satellite in degrees (typically 0 for equatorial orbit)
% lon_sat1 = -115.2; % Longitude of the first geostationary satellite in degrees
% lat_sat2 = 0; % Latitude of the second geostationary satellite in degrees (typically 0 for equatorial orbit)
% lon_sat2 = -24.8; % Longitude of the second geostationary satellite in degrees
% 
% % Define observed azimuth and elevation angles to each satellite
% azimuth_measured1 = 231.4; % Measured azimuth angle to satellite 1 in degrees
% azimuth_measured2 = 116.2; % Measured azimuth angle to satellite 2 in degrees
% elevation_measured1 = 29.9; % Measured elevation angle to satellite 1 in degrees
% elevation_measured2 = 20.3; % Measured elevation angle to satellite 2 in degrees
% % Compute tangent of measured azimuth angles
% tangent_measured1 = tan(deg2rad(azimuth_measured1));
% tangent_measured2 = tan(deg2rad(azimuth_measured2));
% 
% 
% % Define function to compute tangent of azimuth angle given observer's position and satellite position
% tangent_azimuth = @(lat, lon, h_sat, lat_sat, lon_sat) ...
%     (sind(lon - lon_sat)) ./ (cosd(lon - lon_sat) * sind(lat - lat_sat));
% 
% % Define observed azimuth and elevation angles to each satellite
% azimuths_measured = [azimuth_measured1, azimuth_measured2]; % Measured azimuth angles to satellites in degrees
% 
% % Define objective function based on difference between computed and measured tangent of azimuth angle
% objective_function = @(lat, lon) ...
%     [tangent_azimuth(lat, lon, h_sat, lat_sat1, lon_sat1) - tangent_measured1;
%      tangent_azimuth(lat, lon, h_sat, lat_sat2, lon_sat2) - tangent_measured2];
% 
% % Define convergence criteria
% max_iterations = 10000;
% tolerance = 0;
% 
% % Initial guess for observer's position
% lat_guess = lat_assumed;
% lon_guess = lon_assumed;
% 
% % Iterate using Newton's method
% for i = 1:max_iterations
%     % Compute residual vector (difference between computed and measured azimuth angles)
%     residual = objective_function(lat_guess, lon_guess);
% 
%     % Check convergence
%     if norm(residual) < tolerance
%         disp('Converged');
%         break;
%     end
% 
% % Define Jacobian matrix
% J = [(1 / (cosd(lon_guess - lon_sat1) * sind(lat_guess - lat_sat1))^2) * ...
%     -cosd(lat_guess - lat_sat1) * cosd(lon_guess - lon_sat1), ...
%     -sind(lon_guess - lon_sat1) / (cosd(lon_guess - lon_sat1) * sind(lat_guess - lat_sat1))^2; ...
%     (1 / (cosd(lon_guess - lon_sat2) * sind(lat_guess - lat_sat2))^2) * ...
%     -cosd(lat_guess - lat_sat2) * cosd(lon_guess - lon_sat2), ...
%     -sind(lon_guess - lon_sat2) / (cosd(lon_guess - lon_sat2) * sind(lat_guess - lat_sat2))^2];
% 
%     % Update guess for observer's position using Newton's method
%     delta = -pinv(J) * residual; % Pseudo-inverse used in case J is singular
%     lat_guess = lat_guess + delta(1);
%     lon_guess = lon_guess + delta(2);
% end
% 
% % Display final position fix
% disp(['Latitude: ', num2str(lat_guess)]);
% disp(['Longitude: ', num2str(lon_guess)]);
clc
clear all

% Define constants
R_e = 6371; % Earth radius in kilometers
h_sat = 42164; % Geostationary satellite altitude in kilometers
lat_assumed = 40; % Assumed latitude in degrees
lon_assumed = -76; % Assumed longitude in degrees

% Define position of the geostationary satellite
lat_sat1 = 0; % Latitude of the geostationary satellite in degrees (typically 0 for equatorial orbit)
lon_sat1 = -115.2; % Longitude of the geostationary satellite in degrees

% Define observed azimuth and elevation angles to the satellite
azimuth_measured1 = 231.4; % Measured azimuth angle to the satellite in degrees
elevation_measured1 = 29.9; % Measured elevation angle to the satellite in degrees

% Compute tangent of measured azimuth angle
tangent_measured1 = tan(deg2rad(azimuth_measured1));

% Define function to compute tangent of azimuth angle given observer's position and satellite position
tangent_azimuth = @(lat, lon, h_sat, lat_sat, lon_sat) ...
    (sind(lon - lon_sat)) ./ (cosd(lon - lon_sat) * sind(lat - lat_sat));

% Define objective function based on difference between computed and measured tangent of azimuth angle
objective_function = @(lat, lon) tangent_azimuth(lat, lon, h_sat, lat_sat1, lon_sat1) - tangent_measured1;

% Define convergence criteria
max_iterations = 10000;
tolerance = 1e-6;

% Initial guess for observer's position
lat_guess = lat_assumed;
lon_guess = lon_assumed;

% Iterate using Newton's method
for i = 1:max_iterations
    % Compute residual (difference between computed and measured tangent of azimuth angle)
    residual = objective_function(lat_guess, lon_guess);
    
    % Check convergence
    if abs(residual) < tolerance
        disp('Converged');
        break;
    end
    
    % Compute Jacobian matrix (partial derivatives)
    J = [(1 / (cosd(lon_guess - lon_sat1) * sind(lat_guess - lat_sat1))^2) * ...
        -cosd(lat_guess - lat_sat1) * cosd(lon_guess - lon_sat1), ...
        -sind(lon_guess - lon_sat1) / (cosd(lon_guess - lon_sat1) * sind(lat_guess - lat_sat1))^2];
    
    % Update observer's position using Newton's method
    delta = -pinv(J) * residual; % Pseudo-inverse used in case J is singular
    lat_guess = lat_guess + delta(1);
    lon_guess = lon_guess + delta(2);
end

% Display final position fix
disp(['Latitude: ', num2str(lat_guess)]);
disp(['Longitude: ', num2str(lon_guess)]);
