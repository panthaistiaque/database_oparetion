-- hstore, which is used to store the key-value pair in the unit value. Basically, the keys and values are the text strings.

-- must first allow the hstore extension, which loads the contrib module for our PostgreSQL illustration.
CREATE EXTENSION hstore;  

-- -- dummy table 
CREATE TABLE Movie (  
    Movie_id serial primary key,  
    Movie_name VARCHAR,  
    Movie_Attr hstore  
);


-- -- dummy data, hstore column are a list of comma-separated key => value pairs. And both keys and values are quoted using double quotes (").
INSERT INTO Movie (Movie_name, Movie_attr)  
VALUES  
(       'Avengers Endgame',  
        '"rating" => "8.4",  
        "movie_genres" => "Action/Sci-fi",  
        "language" => "English",  
        "release_year" => "2019",  
        "running_time" => "181 Minutes"'   
),    
        (   'US',  
            '"rating" => "6.9",  
           "movie_genres" => "Horror/Thriller",  
           "language"  => "English",  
           "release_year" => "2019",  
            "running_time"  => "116 Minutes"'  
        ),  
     (  'Dolittle',  
            '"rating" => "5.6",  
           "movie_genres" => "Adventure/Family ",  
           "language" => "English",  
           "release_year" => "2020",  
            "running_time" => "101 Minutes"'  
    );  
	


SELECT Movie_attr -> 'running_time' AS Time_duration  FROM Movie;  

-- Retrieve all values from an hstore column
SELECT avals (Movie_attr)   FROM Movie;

-- or

SELECT svals (Movie_attr)  FROM Movie;


-- Retrieve all keys from an hstore column
SELECT akeys (Movie_attr)  FROM Movie; 
-- or
SELECT skeys (Movie_attr)  FROM Movie;


-- Modify hstore data to sets
SELECT Movie_name, EACH(Movie_attr)).* FROM Movie;  

-- Modifying the hstore data to JSON
SELECT Movie_name,  hstore_to_json (Movie_attr) json  FROM Movie;

-- add a new key-value pair
UPDATE Movie  SET Movie_attrMovie_attr = Movie_attr || '"Country"=>"United States"':: hstore;  

-- Update 
UPDATE Movie SET Movie_attrMovie_attr = Movie_attr || '"Country"=> "USA"' ::hstore;

-- delete
UPDATE Movie SET Movie_attr = delete(Movie_attr, 'Country');


-- Check for an explicit key
SELECT Movie_name,   Movie_attr->'movie_genres' as genres,  Movie_attr  
FROM Movie  
WHERE Movie_attr ? 'movie_genres';

-- Check for a key-value pair
SELECT Movie_name  
FROM Movie  
WHERE Movie_attr @> '"language"=>"English"' :: hstore;  

--  rows which having various specified keys (We can also use ?| operator in the ?& operator's place)
SELECT Movie_name  
FROM Movie  
WHERE Movie_attr ?& ARRAY [ 'running_time', 'rating' ];
