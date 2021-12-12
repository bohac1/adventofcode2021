CREATE TYPE direction_2a AS ENUM ('forward', 'down', 'up');
CREATE TABLE aoc2a_input (id SERIAL, direction direction_2a NOT NULL, val INT NOT NULL);
