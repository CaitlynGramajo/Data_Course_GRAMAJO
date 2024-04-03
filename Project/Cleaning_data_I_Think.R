#02/26/2024

## Library YE####

library(tidyverse)
library(readxl)
library(janitor)
library(asteRisk)

#install.packages("asteRisk")

## Clean The Terrible Name ####

dat<-read_xlsx("C:\\Users\\caitl\\Downloads\\UCS-Satellite-Database 5-1-2023.xlsx")
dat1<-clean_names(dat)
colnames(dat1)

## Dropping everything past comments because I don't know what it is and it is mostly NA ####

selected_columns <- colnames(select(dat1, c(1:26)))

dat2<-
  dat1 %>% 
  select(all_of(selected_columns))

colnames(dat2)

## I only want orbit stuff ####
selected_columns2 <- colnames(select(dat2, c("current_official_name_of_satellite","country_org_of_un_registry","country_of_operator_owner","operator_owner" ,"users","purpose","class_of_orbit","type_of_orbit","longitude_of_geo_degrees","perigee_km","apogee_km","eccentricity","inclination_degrees","period_minutes")))

dat3<-
  dat2 %>% 
  select(all_of(selected_columns2))

#with satellite package 

install.packages("satellite")
library(satellite)

# Define the satellite orbital parameters
sat_data <- data.frame(
  longitude_of_geo_degrees = c(0, 0, 0),  # Example longitude values
  perigee_km = c(400, 500, 600),          # Example perigee values
  apogee_km = c(400, 500, 600),            # Example apogee values
  eccentricity = c(0, 0, 0),               # Example eccentricity values
  inclination_degrees = c(45, 50, 55),     # Example inclination values
  period_minutes = c(90, 100, 110)         # Example period values
)

# Create satellite objects
satellites <- lapply(1:nrow(sat_data), function(i) {
  satellite(
    epoch = as.POSIXct("2024-03-15"),  # Example epoch time
    a = (sat_data$perigee_km[i] + sat_data$apogee_km[i]) / 2,
    e = sat_data$eccentricity[i],
    i = sat_data$inclination_degrees[i],
    Omega = 0,
    omega = 0,
    anom = 0,
    n = 0,
    ndot = 0,
    nddot = 0,
    bstar = 0,
    period = sat_data$period_minutes[i]
  )
})

# Compute satellite positions
positions <- lapply(satellites, function(sat) {
  predict(sat, times = seq(0, 24*60*60, by = 60))  # Predict positions for 24 hours
})

# Plot satellite orbits
plot(0, type = "n", xlim = c(-10000, 10000), ylim = c(-10000, 10000), xlab = "Longitude (km)", ylab = "Latitude (km)")
for (pos in positions) {
  lines(pos$position[ ,1], pos$position[ ,2], col = "blue")
}

# Load required libraries
install.packages("geosphere")
installed.packages("rayshader")

library(geosphere)

library(rayshader)

# Function to calculate satellite position
calculate_satellite_position <- function(longitude_of_geo_degrees, perigee_km, apogee_km, eccentricity, inclination_degrees, period_minutes) {
  # Constants
  R_earth <- 6371  # Earth radius in km
  
  # Semi-major axis (average of perigee and apogee)
  semi_major_axis <- (perigee_km + apogee_km) / 2
  
  # Orbital period in seconds
  period_seconds <- period_minutes * 60
  
  # Eccentric anomaly
  M <- 2 * pi * (seq(0, period_seconds, by = 60) / period_seconds)
  E <- sapply(M, function(m) uniroot(function(x) x - eccentricity * sin(x) - m, lower = 0, upper = 2 * pi)[1])
  
  # True anomaly
  theta <- 2 * atan(sqrt((1 + eccentricity) / (1 - eccentricity)) * tan(E / 2))
  
  # Distance from center to focus
  r <- semi_major_axis * (1 - eccentricity * cos(E))
  
  # Convert orbital elements to 3D coordinates
  x <- r * (cos(longitude_of_geo_degrees) * cos(inclination_degrees) * cos(theta) - sin(longitude_of_geo_degrees) * sin(theta))
  y <- r * (sin(longitude_of_geo_degrees) * cos(inclination_degrees) * cos(theta) + cos(longitude_of_geo_degrees) * sin(theta))
  z <- r * sin(inclination_degrees) * sin(theta)
  
  return(data.frame(x = x, y = y, z = z))
}

# Satellite parameters
longitude_of_geo_degrees <- 0
perigee_km <- 200
apogee_km <- 200
eccentricity <- 0
inclination_degrees <- 45
period_minutes <- 90

# Calculate satellite position
satellite_position <- calculate_satellite_position(longitude_of_geo_degrees, perigee_km, apogee_km, eccentricity, inclination_degrees, period_minutes)

# Plot the globe with satellite positions
globe <- globe_shade(ray_shade(ray_sphere(texture = "water")), texture = "world")
plot_globe(globe)
rgl::points3d(satellite_position$x, satellite_position$y, satellite_position$z, col = "red", size = 5)

