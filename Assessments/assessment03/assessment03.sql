7. 
SELECT actor.name
JOIN casting
ON actor.id=actorid
JOIN movie
FROM actor
on movie.id=movieid
WHERE movie.title="Casablanca";

8. 
SELECT actor.name
JOIN casting
ON actor.id=actorid
JOIN movie
FROM actor
on movie.id=movieid
WHERE movie.title="Alien";

9. 
SELECT movie.title
FROM movie
JOIN casting
ON movie.id = movieid
JOIN actor
ON actorid = actor.id
WHERE actor.name = "Harrison Ford";

10.
SELECT movie.title
FROM movie
JOIN casting
ON movie.id = movieid
JOIN actor
ON actorid = actor.id
WHERE actor.name = "Harrison Ford" AND ord != 1;

11.
SELECT movie.title, actor.name
FROM movie
JOIN casting
ON movie.id = movieid
JOIN actor
ON actorid = actor.id
WHERE yr = 1962 AND ord = 1;

12.
SELECT title, name
FROM (movie JOIN casting ON movie.id=movieid) JOIN actor ON actor.id=actorid
WHERE ord = 1 AND movie.id IN
(SELECT movieid
FROM actor JOIN casting ON id=actorid
WHERE name = 'Julie Andrews');


13.
SELECT yr,COUNT(title)
FROM movie 
JOIN casting 
ON movie.id=movieid 
JOIN actor 
ON actorid=actor.id
WHERE name='John Travolta'
GROUP BY yr
HAVING COUNT(title)=
  (SELECT MAX(c) FROM
    (SELECT yr,COUNT(title) AS c FROM
       movie JOIN casting ON movie.id=movieid
             JOIN actor   ON actorid=actor.id
     WHERE name='John Travolta'
     GROUP BY yr) AS t
    );

14.
SELECT name
FROM actor 
JOIN casting 
ON actorid=id
WHERE ord = 1
GROUP BY actorid
HAVING COUNT(movieid) >=30
ORDER BY name;

