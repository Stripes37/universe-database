-- Connect to PostgreSQL
\c postgres;

-- Drop the existing database if it exists
DROP DATABASE IF EXISTS universe;

-- Create a new database
CREATE DATABASE universe;

-- Connect to the new database
\c universe;

-- Create the galaxy table
CREATE TABLE galaxy (
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(60) UNIQUE NOT NULL,
    galaxy_types VARCHAR(60),
    distance_from_earth INT,
    age_in_millions_of_years NUMERIC,
    has_life BOOLEAN NOT NULL
);

-- Insert rows into the galaxy table
INSERT INTO galaxy (name, galaxy_types, distance_from_earth, age_in_millions_of_years, has_life) VALUES
('Milky Way', 'Spiral', 0, 13600, TRUE),
('Andromeda', 'Spiral', 2537000, 10000, FALSE),
('Triangulum', 'Spiral', 3000000, 10000, FALSE),
('Sombrero', 'Elliptical', 29000000, 11000, FALSE),
('Whirlpool', 'Spiral', 23000000, 500, FALSE),
('Cartwheel', 'Ring', 500000000, 1500, FALSE);

-- Create the star table with a foreign key constraint to galaxy
CREATE TABLE star (
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(60) UNIQUE NOT NULL,
    galaxy_id INT NOT NULL,
    age_in_millions_of_years NUMERIC,
    is_spherical BOOLEAN NOT NULL,
    CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES galaxy(galaxy_id)
);

-- Insert rows into the star table
INSERT INTO star (name, galaxy_id, age_in_millions_of_years, is_spherical) VALUES
('Sun', 1, 4500, TRUE),
('Proxima Centauri', 2, 4500, TRUE),
('Betelgeuse', 1, 8000, TRUE),
('Sirius', 3, 200, TRUE),
('Vega', 1, 455, TRUE),
('Rigel', 4, 8500, TRUE);

-- Create the planet table with a foreign key constraint to star
CREATE TABLE planet (
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(60) UNIQUE NOT NULL,
    star_id INT NOT NULL,
    distance_from_star INT,
    has_life BOOLEAN NOT NULL,
    planet_types VARCHAR(60),
    CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES star(star_id)
);

-- Insert rows into the planet table
INSERT INTO planet (name, star_id, distance_from_star, has_life, planet_types) VALUES
('Earth', 1, 1, TRUE, 'Terrestrial'),
('Mars', 1, 1, FALSE, 'Terrestrial'),
('Jupiter', 1, 5, FALSE, 'Gas Giant'),
('Saturn', 1, 10, FALSE, 'Gas Giant'),
('Uranus', 1, 19, FALSE, 'Ice Giant'),
('Neptune', 1, 30, FALSE, 'Ice Giant'),
('Proxima b', 2, 0.05, FALSE, 'Terrestrial'),
('Betelgeuse b', 3, 300, FALSE, 'Gas Giant'),
('Sirius b', 4, 0.5, FALSE, 'White Dwarf'),
('Vega b', 5, 0.13, FALSE, 'Terrestrial'),
('Rigel b', 6, 50, FALSE, 'Gas Giant'),
('Rigel c', 6, 200, FALSE, 'Ice Giant');

-- Create the moon table with a foreign key constraint to planet
CREATE TABLE moon (
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(60) UNIQUE NOT NULL,
    planet_id INT NOT NULL,
    num_of_craters INT,
    population NUMERIC,
    description TEXT,
    haspeople BOOLEAN NOT NULL,
    CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES planet(planet_id)
);

-- Insert rows into the moon table
INSERT INTO moon (name, planet_id, num_of_craters, population, description, haspeople) VALUES
('Moon', 1, 10000, 0, 'Earths natural satellite', FALSE),
('Phobos', 2, 5000, 0, 'One of Mars moons', FALSE),
('Deimos', 2, 500, 0, 'One of Mars moons', FALSE),
('Europa', 3, 0, 0, 'One of Jupiter moons', FALSE),
('Ganymede', 3, 0, 0, 'One of Jupiter moons', FALSE),
('Callisto', 3, 0, 0, 'One of Jupiter moons', FALSE),
('Titan', 4, 0, 0, 'One of Saturn moons', FALSE),
('Rhea', 4, 0, 0, 'One of Saturn moons', FALSE),
('Iapetus', 4, 0, 0, 'One of Saturn moons', FALSE),
('Oberon', 5, 0, 0, 'One of Uranus moons', FALSE),
('Titania', 5, 0, 0, 'One of Uranus moons', FALSE),
('Ariel', 5, 0, 0, 'One of Uranus moons', FALSE),
('Triton', 6, 0, 0, 'One of Neptunes moons', FALSE),
('Nereid', 6, 0, 0, 'One of Neptunes moons', FALSE),
('Proteus', 6, 0, 0, 'One of Neptunes moons', FALSE),
('Larissa', 6, 0, 0, 'One of Neptunes moons', FALSE),
('Hippocamp', 6, 0, 0, 'One of Neptunes moons', FALSE),
('Proxima Centauri c', 7, 0, 0, 'One of Proxima Centauris moons', FALSE),
('Betelgeuse c', 8, 0, 0, 'One of Betelgeuses moons', FALSE),
('Sirius c', 9, 0, 0, 'One of Siriuss moons', FALSE);

-- Create an additional table for creativity
CREATE TABLE comet (
    comet_id SERIAL PRIMARY KEY,
    name VARCHAR(60) UNIQUE NOT NULL,
    has_tail BOOLEAN NOT NULL,
    speed_km_per_s NUMERIC NOT NULL,
    description TEXT
);

-- Insert rows into the comet table
INSERT INTO comet (name, has_tail, speed_km_per_s, description) VALUES
('Halleys Comet', TRUE, 70.56, 'Famous short-period comet visible from Earth every 75-76 years.'),
('Comet Encke', TRUE, 69.9, 'A periodic comet that completes an orbit of the sun once every 3.3 years.'),
('Comet Hale-Bopp', TRUE, 45.0, 'One of the most widely observed comets of the 20th century.');
