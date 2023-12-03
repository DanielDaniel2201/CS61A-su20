.read data.sql


CREATE TABLE bluedog AS
  SELECT color, pet FROM students
    WHERE color = 'blue' AND pet = 'dog';

CREATE TABLE bluedog_songs AS
  SELECT color, pet, song FROM students          
    WHERE color = 'blue' AND pet = 'dog';


CREATE TABLE matchmaker AS
  SELECT a.pet, a.song, a.color, b.color
    FROM students AS a, students AS b
      WHERE a.song = b.song AND a.pet = b.pet AND a.time < b.time; 


CREATE TABLE sevens AS
  SELECT seven FROM students, numbers
    WHERE students.time = numbers.time AND students.number = 7 AND numbers.'7' is 'True';


CREATE TABLE favpet AS
  SELECT pet AS favpet, COUNT(*)
    FROM students
      GROUP BY pet
        ORDER BY -COUNT(*);

CREATE TABLE favpets AS
  SELECT * FROM favpet LIMIT 10;

CREATE TABLE dog AS
  SELECT pet, COUNT(*)
    FROM students
      WHERE pet = 'dog';


CREATE TABLE bluedog_agg AS
  SELECT song, COUNT(*)
    FROM bluedog_songs
      GROUP BY song
       ORDER BY -COUNT(*);


CREATE TABLE instructor_obedience AS
  SELECT seven ||'|'||instructor||'|'|| COUNT(*)
    FROM students
      WHERE seven = '7'
      GROUP BY instructor;

