-- Sample Table
-- name	continent	area	population	gdp
-- Afghanistan  Asia  652230  25500100  20343000000
-- Albania  Europe  28748  2831741  12960000000
-- Algeria  Africa  2381741  37100000  188681000000
-- Andorra  Europe  468  78115  3712000000
-- Angola  Africa  1246700  20609294  100990000000
-- ... rest of the world


-- Select Tutorial
  /* Show the population of Germany */
  SELECT population FROM world
    WHERE name = 'Germany'

  /* Show the per capita gdp: gdp/population for each country where the area is over 5,000,000 km2 */
  SELECT name, gdp/population FROM world
    WHERE area > 5000000

  /* Show the name and continent where the area is less then 2000 and the gdp is more than 5000000000 */
  SELECT name , continent
    FROM world
    WHERE area < 2000
      AND gdp > 5000000000

  /* Show the name and the population for 'Denmark', 'Finland', 'Norway', 'Sweden' */
  SELECT name, population FROM world
    WHERE name IN ('Denmark', 'Finland', 'Norway', 'Sweden')

  /* Show each country that begins with G */
  SELECT name FROM world
    WHERE name LIKE 'G%'

  /* Show the area in 1000 square km. Show area/1000 instead of area */
  SELECT name, area/1000 FROM world
    WHERE area BETWEEN 207600 AND 244820


-- Select..Where Tutorial
  /* Show the name for the countries that have a population of at least 200
  million. (200 million is 200000000, there are eight zeros) */
  SELECT name FROM world
  WHERE population>200000000

  /* Give the name and the per capita GDP for those countries with a population
   of at least 200 million. */
  SELECT name, gdp/population FROM world
  WHERE population >= 200000000

  /* Show the name and population in millions for the countries of
  'South America' Divide the population by 1000000 to get population
  in millions */
  SELECT name, population/1000000 FROM world
  WHERE continent IN ('South America')

  /* Show the name and population for 'France', 'Germany', 'Italy' */
  SELECT name, population FROM world
  WHERE name in ('France', 'Germany', 'Italy')

  /* Identify the countries which have names including the word 'United' */
  SELECT name FROM world
  WHERE name like '%United%'


-- Select Tutorial 3

  /* Change the query shown so that it displays Nobel prizes for 1950. */
  SELECT yr, subject, winner
  FROM nobel
  WHERE yr = 1950

  /* Show who won the 1962 prize for Literature. */
  SELECT winner FROM nobel
  WHERE yr = 1962 AND subject = 'Literature'

  /* Show the year and subject that won 'Albert Einstein' his prize. */
  SELECT yr, subject FROM nobel
  WHERE winner = 'Albert Einstein'

  /* Give the name of the 'Peace' winners since the year 2000, including 2000. */
  SELECT winner FROM nobel
  WHERE subject ='Peace' AND yr >= 2000

  /* Show all details (yr, subject, winner) of the Literature prize winners
  for 1980 to 1989 inclusive. */
  SELECT * FROM nobel
  WHERE subject = 'Literature' AND yr BETWEEN 1980 AND 1989

  /* Show all details of the presidential winners:
  ('Theodore Roosevelt', 'Woodrow Wilson', 'Jed Bartlet', 'Jimmy Carter') */
  SELECT * FROM nobel
  WHERE winner IN  ('Theodore Roosevelt', 'Woodrow Wilson', 'Jed Bartlet',
  'Jimmy Carter')

  /* Show the winners with first name John */
  SELECT winner FROM nobel
  WHERE winner LIKE 'John%'

  /* In which years was the Physics prize awarded but no Chemistry prize. */
  SELECT DISTINCT yr FROM nobel
  WHERE subject = 'Physics' AND yr NOT IN
    (SELECT yr FROM nobel
    WHERE subject = 'Chemistry')

-- Select..Within Tutorial

  /* List each country name where the population is larger than 'Russia'. */
  SELECT name FROM world
    WHERE population >
       (SELECT population FROM world
        WHERE name='Russia')

  /* List the name and continent of countries in the continents
  containing 'Belize', 'Belgium'. */
  SELECT name, continent FROM world
  WHERE continent IN
    (SELECT continent FROM world
    WHERE name IN ('Belize', 'Belgium'))

  /* Show the countries in Europe with a per capita GDP greater than
  'United Kingdom'. */
  SELECT name FROM world
  WHERE continent = 'Europe' AND gdp/population >
    (SELECT gdp/population FROM world
    WHERE name = 'United Kingdom')

  /* Which country has a population that is more than Canada
  but less than Poland? Show the name and the population. */
  SELECT name, population FROM world
  WHERE population >
    (SELECT population FROM world
    WHERE name = 'Canada')
  AND population <
    (SELECT population FROM world
    WHERE name = 'Poland')

  /* Which countries have a GDP greater than any country in Europe?
   [Give the name only.] */
  SELECT name FROM world
  WHERE gdp >
    (SELECT MAX(gdp) FROM world
    WHERE continent = 'Europe')

  /* Find the largest country (by area) in each continent,
  show the continent, the name and the area: */
  SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
    WHERE y.continent = x.continent
    AND area > 0)

  /* Find each country that belongs to a continent where all populations are
  less than 25000000. Show name, continent and population. */
  SELECT name, continent, population FROM world
  WHERE continent NOT IN
    (SELECT continent FROM world
    WHERE population > 25000000)

  /* Some countries have populations more than three times that of any of their
 neighbours (in the same continent). Give the countries and continents. */
  SELECT name, continent FROM world x
  WHERE population/3 >= ALL
    (SELECT population from world y
    WHERE y.continent = x.continent and y.name != x.name)


-- SUM and COUNT Tutorial
  /* Show the total population of the world. */
  SELECT SUM(population)
  FROM world

  /* List all the continents - just once each. */
  SELECT DISTINCT continent FROM world

  /* Give the total GDP of Africa */
  SELECT SUM(gdp) FROM world
  WHERE continent = 'Africa'

  /* How many countries have an area of at least 1000000 */
  SELECT COUNT(name) FROM world
  WHERE area >= 1000000

  /* What is the total population of ('France','Germany','Spain') */
  SELECT SUM(population) FROM world
  WHERE name IN ('France', 'Germany', 'Spain')

  /* For each continent show the continent and number of countries. */
  SELECT continent, COUNT(name) FROM world
  GROUP BY continent

  /* For each continent show the continent and number of countries
   with populations of at least 10 million. */
  SELECT continent, COUNT(name) FROM world
  WHERE population >= 10000000
  GROUP BY continent

  /* List the continents with total populations of at least 100 million. */
  SELECT continent FROM world
  GROUP BY continent
  HAVING SUM(population) >= 100000000

-- JOIN Tutorial
  /* Show matchid and player name for all goals scored by Germany.
    teamid = 'GER' */
  SELECT matchid, player FROM goal
  WHERE teamid = 'GER'

  /* From the previous query you can see that Lars Bender's goal was scored
  in game 1012. Notice that the column matchid in the goal table corresponds
  to the id column in the game table.
  Show id, stadium, team1, team2 for game 1012 */

  SELECT id,stadium,team1,team2
  FROM game
  WHERE id = 1012

  /* Show the player, teamid and mdate and for every German goal.
  teamid='GER' */
  SELECT player,teamid,mdate
  FROM game JOIN goal ON (id=matchid)
  WHERE teamid = 'GER'

  /* Show the team1, team2 and player for every goal scored by a player
   called Mario player LIKE 'Mario%' */
  SELECT team1, team2, player
  FROM game JOIN goal ON (id=matchid)
  WHERE player LIKE 'Mario%'

  /* Show player, teamid, coach, gtime for all goals scored in the first
  10 minutes gtime<=10 */
  SELECT player, teamid, coach ,gtime
  FROM goal JOIN eteam on (teamid=id)
  WHERE gtime<=10

  /* List the the dates of the matches and the name of the team in which
  'Fernando Santos' was the team1 coach. */
  SELECT mdate, teamname FROM game
  JOIN eteam ON (eteam.id = game.team1)
  WHERE coach = 'Fernando Santos'

  /* List the player for every goal scored in a game where the staium was
  'National Stadium, Warsaw' */
  SELECT player
  FROM goal JOIN game ON (matchid=id)
  WHERE stadium = "National Stadium, Warsaw"

  /* Show names of all players who scored a goal against Germany. */
  SELECT DISTINCT player
  FROM game JOIN goal ON matchid = id
  WHERE (team1='GER' OR team2='GER')
  AND teamid != 'GER'

  /* Show teamname and the total number of goals scored. */
  SELECT teamname, COUNT(player)
  FROM eteam JOIN goal ON id=teamid
  GROUP BY teamname

  /* Show the stadium and the number of goals scored in each stadium. */
  SELECT stadium, COUNT(matchid)
  FROM game JOIN goal ON id = matchid
  GROUP BY stadium

  /* For every match involving 'POL', show the matchid, date and the
  number of goals scored. */
  SELECT matchid, mdate, COUNT(matchid)
  FROM game JOIN goal ON matchid = id
  WHERE (team1 = 'POL' OR team2 = 'POL')
  GROUP BY matchid

  /* For every match where 'GER' scored, show matchid, match date
  and the number of goals scored by 'GER' */
  SELECT matchid, mdate, count(matchid)
  FROM goal JOIN game ON id = matchid
  WHERE teamid = 'GER'
  GROUP BY matchid

  /* List every match with the goals scored by each team as shown. */
  SELECT mdate,
    team1,
    sum(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1,
    team2,
    sum(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
    FROM game JOIN goal ON matchid = id
  GROUP BY matchid
  ORDER BY mdate,matchid,team1,team2


-- Advanced JOIN Tutorial
  /* List all of the Star Trek movies, include the id, title and yr
  (all of these movies include the words Star Trek in the title). Order
  results by year. */
  SELECT id, title, yr
  FROM movie
  WHERE title LIKE '%Star Trek%'
  ORDER BY yr

  /* What are the titles of the films with id 11768, 11955, 21191 */
  SELECT title FROM movie
  WHERE id IN (11768, 11955, 21191)

  /* Obtain the cast list for 'Casablanca'. Use the id value that you
   obtained in the previous question. */
  SELECT name
  FROM actor JOIN casting on actorid = id
  WHERE movieid =
    (SELECT id FROM movie
    WHERE title = 'Casablanca')

  /* List the films in which 'Harrison Ford' has appeared */
  SELECT title FROM movie
  WHERE id IN
    (SELECT movieid
    FROM actor JOIN casting ON actorid=id
    WHERE name='Harrison Ford')

  /* List the films where 'Harrison Ford' has appeared - but not in the
  star role. [Note: the ord field of casting gives the position of the actor.
   If ord=1 then this actor is in the starring role] */
  SELECT title FROM movie
  WHERE id IN
    (SELECT movieid
    FROM actor JOIN casting ON actorid=id
    WHERE name='Harrison Ford' and ord != 1)

  /* List the films together with the leading star for all 1962 films. */
  SELECT title, name
  FROM (movie JOIN casting ON movie.id=movieid) JOIN actor ON actor.id=actorid
  WHERE ord = 1 AND yr = 1962

  /* Select John Travolta's busiest year */
  SELECT yr,COUNT(title)
  FROM movie JOIN casting ON movie.id=movieid JOIN actor ON actorid=actor.id
  WHERE name='John Travolta'
  GROUP BY yr
  HAVING COUNT(title)=
    (SELECT MAX(c) FROM
      (SELECT yr,COUNT(title) AS c FROM
         movie JOIN casting ON movie.id=movieid
               JOIN actor   ON actorid=actor.id
       WHERE name='John Travolta'
       GROUP BY yr) AS t
      )

  /* List the film title and the leading actor for all of the films
  'Julie Andrews' played in. */
  SELECT title, name
  FROM (movie JOIN casting ON movie.id=movieid) JOIN actor ON actor.id=actorid
  WHERE ord = 1 AND movie.id IN
  (SELECT movieid
  FROM actor JOIN casting ON id=actorid
  WHERE name = 'Julie Andrews')

  /* Obtain a list in alphabetical order of actors who've had at least
  30 starring roles. */
  SELECT name
  FROM actor JOIN casting ON actorid=id
  WHERE ord = 1
  GROUP BY actorid
  HAVING COUNT(movieid) >=30
  ORDER BY name

  /* List the 1978 films by order of cast list size. */
  SELECT title, count(actorid)
  FROM movie JOIN casting ON id = movieid
  WHERE yr = 1978
  GROUP BY movieid
  ORDER BY count(actorid) DESC

  /* List all the people who have worked with 'Art Garfunkel'. */
  SELECT DISTINCT name
  FROM casting JOIN
    (SELECT movieid
    FROM actor JOIN casting ON id=actorid
    WHERE name = 'Art Garfunkel') as m ON m.movieid = casting.movieid
    JOIN actor ON actor.id = actorid
  WHERE name != 'Art Garfunkel'

-- NULL Tutorial
  /* List the teachers who have NULL for their department. */
  SELECT name FROM teacher
  WHERE dept IS NULL

  /* Use a different JOIN so that all teachers are listed. */
  SELECT teacher.name, dept.name
   FROM teacher LEFT JOIN dept ON (teacher.dept=dept.id)

  /* Use a different JOIN so that all departments are listed. */
  SELECT teacher.name, dept.name
  FROM teacher RIGHT JOIN dept
  ON (teacher.dept = dept.id)

  /* Use COALESCE to print the mobile number. Use the number '07986 444 2266'
   there is no number given. Show teacher name and mobile number or
   '07986 444 2266' */
  SELECT name,
  COALESCE(mobile, '07986 444 2266') AS mobile --as mobile names column 'mobile'
  FROM teacher

  /* Use the COALESCE function and a LEFT JOIN to print the name and
  department name. Use the string 'None' where there is no department. */
  SELECT teacher.name, COALESCE(dept.name, 'None') AS dept
  FROM teacher LEFT JOIN dept ON (dept=dept.id)

  /* Use COUNT to show the number of teachers and the number of mobile phones. */
  SELECT count(name), count(mobile)
  FROM teacher

  /* Use COUNT and GROUP BY dept.name to show each department and the number of
  staff. Use a RIGHT JOIN to ensure that the Engineering department is listed. */
  SELECT dept.name, count(dept) as staff
  FROM teacher RIGHT JOIN dept ON (teacher.dept=dept.id)
  GROUP BY dept.name

  /* Use CASE to show the name of each teacher followed by 'Sci' if the the
   teacher is in dept 1 or 2 and 'Art' otherwise */
  SELECT name,
  CASE WHEN dept IN (1,2) THEN 'Sci' ELSE 'Art' END dept
  FROM teacher

  /* Use CASE to show the name of each teacher followed by 'Sci' if the
  teacher is in dept 1 or 2 show 'Art' if the dept is 3 and 'None' otherwise. */
  SELECT name,
  CASE WHEN dept IN (1,2) THEN 'Sci'
  WHEN dept = 3 THEN 'Art'
  ELSE 'None' END dept
  FROM teacher

-- Self JOIN Tutorial
  /* The query shown gives the number of routes that visit either London Road
  (149) or Craiglockhart (53). Run the query and notice the two services
  that link these stops have a count of 2. Add a HAVING clause to restrict
  the output to these two routes. */
  SELECT company, num, COUNT(*)
  FROM route WHERE stop=149 OR stop=53
  GROUP BY company, num
  HAVING COUNT(*) = 2

  /* Execute the self join shown and observe that b.stop gives all the places
  you can get to from Craiglockhart, without changing routes. Change the
  query so that it shows the services from Craiglockhart to London Road. */
  SELECT a.company, a.num, a.stop, b.stop
  FROM route a JOIN route b ON
    (a.company=b.company AND a.num=b.num)
  WHERE a.stop=53 AND b.stop = 149

  /* The query shown is similar to the previous one, however by joining two
  copies of the stops table we can refer to stops by name rather than by
  number. Change the query so that the services between 'Craiglockhart' and
  'London Road' are shown. If you are tired of these places try 'Fairmilehead'
  against 'Tollcross' */
  SELECT a.company, a.num, stopa.name, stopb.name
  FROM route a JOIN route b ON
    (a.company=b.company AND a.num=b.num)
    JOIN stops stopa ON (a.stop=stopa.id)
    JOIN stops stopb ON (b.stop=stopb.id)
  WHERE stopa.name='Craiglockhart' AND stopb.name='London Road'

  /* Give a list of the services which connect the stops
   'Craiglockhart' and 'Tollcross' */

  SELECT a.company, a.num
  FROM route a JOIN route b ON
    (a.company=b.company AND a.num=b.num)
    JOIN stops stopa ON (a.stop=stopa.id)
    JOIN stops stopb ON (b.stop=stopb.id)
  WHERE stopa.name='Craiglockhart' AND stopb.name='Tollcross'

  /* Give a distinct list of the stops which may be reached from
  'Craiglockhart' by taking one bus. Include the company and bus no.
  of the relevant services. */

  SELECT stopa.name, a.company, a.num
    FROM route a JOIN route b ON
      (a.company=b.company AND a.num=b.num)
      JOIN stops stopa ON (a.stop=stopa.id)
      JOIN stops stopb ON (b.stop=stopb.id)
    WHERE stopb.name='Craiglockhart'


  /* Show that it's possible to get from Craiglockhart to Sighthill using
  2 buses. (this DB doesn't make this easy!) */


