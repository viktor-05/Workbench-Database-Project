CREATE SCHEMA `swimdb` ;

USE swimdb;

-- Table Course
CREATE TABLE  Course (
	CourseID INT,
	Level VARCHAR(12) NOT NULL,
	Sessions INT NOT NULL,
	Instructor VARCHAR(50) NOT NULL,
	startDate DATE  NOT NULL,
	LessonTime VARCHAR(6) NOT NULL,
	PRIMARY KEY (`CourseID`),
	UNIQUE INDEX `CourseID_UNIQUE` (`CourseID` ASC) VISIBLE);
    
    explain course;
   select * from course;

insert into Course (CourseID, Level, Sessions, Instructor, startDate, LessonTime) values (1, 'Advanced', 40, 'Serene Meldon', '2019-06-29', '45min');
insert into Course (CourseID, Level, Sessions, Instructor, startDate, LessonTime) values (2, 'Expert', 50, 'Aurelie Caurah', '2019-10-12', '1h');
insert into Course (CourseID, Level, Sessions, Instructor, startDate, LessonTime) values (3, 'Intermediate', 30, 'Land Ferrone', '2020-02-05', '30min');
insert into Course (CourseID, Level, Sessions, Instructor, startDate, LessonTime) values (4, 'Intermediate', 30, 'Annabel Kilshaw', '2022-08-21', '30min');
insert into Course (CourseID, Level, Sessions, Instructor, startDate, LessonTime) values (5, 'Intermediate', 30, 'Horatio Corish', '2019-03-02', '30min');
insert into Course (CourseID, Level, Sessions, Instructor, startDate, LessonTime) values (6, 'Junior', 20, 'Christiane Linforth', '2019-02-26', '30min');
insert into Course (CourseID, Level, Sessions, Instructor, startDate, LessonTime) values (7, 'Advanced', 40, 'Keene Peter', '2020-01-06', '45min');
insert into Course (CourseID, Level, Sessions, Instructor, startDate, LessonTime) values (8, 'Intermediate', 30, 'Amata Endicott', '2019-01-05', '30min');
insert into Course (CourseID, Level, Sessions, Instructor, startDate, LessonTime) values (9, 'Expert', 50, 'Gerri Handley', '2021-03-23', '1h');
insert into Course (CourseID, Level, Sessions, Instructor, startDate, LessonTime) values (10, 'Junior', 20, 'Pincus Farnes', '2021-07-04', '30min');
insert into Course (CourseID, Level, Sessions, Instructor, startDate, LessonTime) values (11, 'Intermediate', 30, 'Suzie Jostan', '2019-04-08', '30min');
insert into Course (CourseID, Level, Sessions, Instructor, startDate, LessonTime) values (12, 'Intermediate', 30, 'Yuri Blazynski', '2021-01-14', '30min');
insert into Course (CourseID, Level, Sessions, Instructor, startDate, LessonTime) values (13, 'Advanced', 40, 'Lynn Mitchall', '2020-04-11', '45min');
insert into Course (CourseID, Level, Sessions, Instructor, startDate, LessonTime) values (14, 'Junior', 20, 'Paola Faloon', '2019-07-20', '30min');
insert into Course (CourseID, Level, Sessions, Instructor, startDate, LessonTime) values (15, 'Intermediate', 30, 'Lyon Bertrand', '2019-07-25', '30min');
insert into Course (CourseID, Level, Sessions, Instructor, startDate, LessonTime) values (16, 'Intermediate', 30, 'Bette-ann Brick', '2022-10-18', '30min');
insert into Course (CourseID, Level, Sessions, Instructor, startDate, LessonTime) values (17, 'Expert', 50, 'Sheena Cumesky', '2020-08-21', '1h');
insert into Course (CourseID, Level, Sessions, Instructor, startDate, LessonTime) values (18, 'Intermediate', 30, 'Marilyn Plaistowe', '2020-07-01', '30min');
insert into Course (CourseID, Level, Sessions, Instructor, startDate, LessonTime) values (19, 'Intermediate', 30, 'Kermie Nind', '2019-11-27', '30min');
insert into Course (CourseID, Level, Sessions, Instructor, startDate, LessonTime) values (20, 'Advanced', 40, 'Gasper Malzard', '2021-06-08', '45min');

-- Table Members
CREATE TABLE Members (
	MemberID INT NOT NULL,
	Firstname VARCHAR(50) NOT NULL,
	Surname VARCHAR(50) NOT NULL,
	DOB DATE NOT NULL,
	Address VARCHAR(50) NOT NULL,
	City VARCHAR(50) NOT NULL,
    PRIMARY KEY (`MemberID`),
	UNIQUE INDEX `MemberID_UNIQUE` (`MemberID` ASC) VISIBLE);
    
    explain members;
    
select * from course;

-- Table leesons
CREATE TABLE `swimdb`.`lessons` (
  `LessonID` INT NOT NULL,
  `CourseID` INT NOT NULL,
  `MemberID` INT NOT NULL,
  PRIMARY KEY (`LessonID`),
  INDEX `CourseID_idx` (`CourseID` ASC) VISIBLE,
  INDEX `MemberID_idx` (`MemberID` ASC) VISIBLE,
  CONSTRAINT `CourseID`
    FOREIGN KEY (`CourseID`)
    REFERENCES `swimdb`.`course` (`CourseID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `MemberID`
    FOREIGN KEY (`MemberID`)
    REFERENCES `swimdb`.`members` (`MemberID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

SELECT * FROM members;
SELECT * FROM lessons;
SELECT * FROM course;

-- Where courseID is equals to a number below 5 and the first name of any of the instructors  
SELECT CourseID ,LEFT(instructor,locate(' ',instructor)-1) AS InstructorFirstName FROM course 
WHERE CourseID < 5;

-- Where courseID is equals to a number above 5 and the lesson time is in the morning or afternoon.  
SELECT CourseID, LessonTime  FROM course 
WHERE CourseID > 5 AND (LessonTime = "45min" OR LessonTime = "1h");


-- Order by the above results by: startDate in “course” table 
SELECT CourseID ,LEFT(instructor,locate(' ',instructor)-1) AS InstructorFirstName, startDate FROM course 
WHERE CourseID < 5 
ORDER BY startDate DESC;

-- Order by the above results by: MemberID in the members table
SELECT * FROM members m WHERE m.MemberID IN(SELECT l.MemberID FROM lessons l) ORDER BY m.Firstname;

-- UPDATE the Members table, change the addresses of any three members.
UPDATE members SET 
Address = CASE WHEN MemberID = 143 THEN '110 London Road' 
WHEN MemberID  = 158 THEN '15 Thorne Close' 
WHEN MemberID = 204 THEN '43 Oxford Street'
END
WHERE MemberID IN (143, 158, 204);
select Address from members where MemberID IN (143, 158, 204);

-- Update Course table, change the startDate and lesson time for three of the sessions.
UPDATE course SET LessonTime = 'afternoon', startDate = '2022-10-15'  Where Sessions = 50;
SELECT * FROM course WHERE Sessions = 50;

-- Return the smallest and largest value  Of the LessonID column in the “lesson” table 
SELECT MIN(LessonID) AS "Smallest Id", MAX(LessonID) AS 'Bigger ID' from lessons;
SELECT MIN(MemberID) AS 'Smallest Member Id', MAX(MemberID) AS 'Bigger Member Id' from members;

-- Count the total number of members in the “members” table 
SELECT COUNT(MemberID) AS ' Total number of members' FROM members;


-- Sum the total number of sessions in the” members” table 
SELECT SUM(c.Sessions) AS "Total number of member's sessions" 
FROM  lessons l, course c, members m
WHERE l.MemberID = m.MemberID AND l.CourseID = c.CourseID;

-- Find the average session time for all “sessions” in course table  960
SELECT AVG(Sessions) AS 'Average number of sessions' FROM course;

-- Find all the people from the “members” table whose last name starts with A. 
SELECT Firstname, Surname FROM members WHERE Surname  like 'A%';

-- Find all the people from the “members” table whose last name ends with A. 
SELECT Firstname, Surname FROM members WHERE Surname  like '%D';

-- Find all the people from the “members” table that have "ab" in any position in the last name. 
SELECT Firstname, Surname FROM members WHERE Surname  like '%ac%';

-- Find all the people from the “members” table that that have "b" in the second position in their first name.
SELECT Firstname, Surname FROM members WHERE Firstname  like '_a%';

-- Find all the people from the “members” table whose last name starts with "a" and are at least 3 characters in length: 
SELECT Firstname, Surname FROM members WHERE Surname  like 'a__%';

-- Find all the people from the “members” table whose last name starts with "a" and ends with "y" 
SELECT Firstname, Surname FROM members WHERE Surname  like 'a%y';

-- Find all the people from the “members” table whose last name does not starts with "a" and ends with "y" 
SELECT Firstname, Surname  FROM members WHERE Surname like '%y' AND Surname NOT like 'a%';

-- Right Join
SELECT * FROM members
RIGHT JOIN lessons  
USING(MemberID);

SELECT * FROM members 
LEFT JOIN lessons  
USING(MemberID);