CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;


-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT name, size
    FROM dogs, sizes
      WHERE dogs.height > sizes.min AND dogs.height <= sizes.max;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT child
    FROM dogs, parents
      WHERE dogs.name = parents.parent
        ORDER BY -dogs.height;

-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT a.child AS first, b.child AS second
    FROM parents AS a, parents AS b
        WHERE a.parent = b.parent AND a.child < b.child;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT first||' and '||second||' are '||a.size||' siblings'
    FROM siblings, size_of_dogs as a, size_of_dogs as b
     WHERE first = a.name and second = b.name and a.size = b.size;

-- Ways to stack 4 dogs to a height of at least 170, ordered by total height
CREATE TABLE stacks_helper1(dog, stack_height, last_height);
CREATE TABLE stacks_helper2(dog1, dog2, stack_height, last_height);
CREATE TABLE stacks_helper3(dog1, dog2, dog3, stack_height, last_height);
CREATE TABLE stacks_helper4(dog1, dog2, dog3, dog4, stack_height, last_height);
-- Add your INSERT INTOs here
INSERT INTO stacks_helper1 SELECT name, height, height FROM dogs;
INSERT INTO stacks_helper2 SELECT a.dog, b.dog, a.stack_height + b.stack_height, b.stack_height
  FROM stacks_helper1 AS a, stacks_helper1 AS b
    WHERE a.dog <> b.dog AND a.stack_height <= b.stack_height;
INSERT INTO stacks_helper3 SELECT a.dog1, a.dog2, b.dog,  a.stack_height + b.stack_height, b.stack_height
 FROM stacks_helper2 AS a, stacks_helper1 AS b
  WHERE a.dog1 <> b.dog AND a.dog2 <> b.dog AND b.last_height >= a.last_height;
INSERT INTO stacks_helper4 SELECT a.dog1, a.dog2, a.dog3, b.dog, a.stack_height + b.stack_height, b.last_height
  FROM stacks_helper3 AS a, stacks_helper1 AS b
    WHERE a.dog1 <> b.dog AND a.dog2 <> b.dog AND a.dog3 <> b.dog AND b.last_height >= a.last_height;


CREATE TABLE stacks AS
  SELECT dog1||', '||dog2||', '||dog3||', '|| dog4, stack_height
    FROM stacks_helper4
      WHERE stack_height >= 170
      ORDER BY stack_height;
