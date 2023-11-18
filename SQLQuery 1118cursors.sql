--USE master

--IF EXISTS (SELECT name FROM master.sys.databases WHERE name='University')
--DROP DATABASE University
--GO

--CREATE DATABASE University
--GO

USE University
GO

---- Створення таблиці Students (студенти) 
--CREATE TABLE Students ( 
--	StudentID INT PRIMARY KEY IDENTITY(1,1), 
--	FirstName NVARCHAR(50), 
--	LastName NVARCHAR(50), 
--	DateOfBirth DATE 
--);
--GO

---- Створення таблиці Professors (викладачі)
--CREATE TABLE Professors (
--	ProfessorID INT PRIMARY KEY IDENTITY(1,1),
--    FirstName NVARCHAR(50),
--    LastName NVARCHAR(50)
--);
--GO

---- Створення таблиці Courses (курси) 
--CREATE TABLE Courses ( 
--	CourseID INT PRIMARY KEY IDENTITY(1,1), 
--	CourseName NVARCHAR(100), 
--	ProfessorID INT FOREIGN KEY REFERENCES Professors(ProfessorID) 
--);
--GO

---- Створення таблиці Enrollments (записи на курси) 
--CREATE TABLE Enrollments ( 
--	EnrollmentID INT PRIMARY KEY IDENTITY(1,1), 
--	StudentID INT FOREIGN KEY REFERENCES Students(StudentID), 
--	CourseID INT FOREIGN KEY REFERENCES Courses(CourseID), 
--	EnrollmentDate DATE 
--);
--GO

----Створення таблиці Grades (оцінки) 
--CREATE TABLE Grades ( 
--	GradeID INT PRIMARY KEY IDENTITY(1,1), 
--	EnrollmentID INT FOREIGN KEY REFERENCES Enrollments(EnrollmentID), 
--	Grade INT 
--);

--INSERT INTO Students
--VALUES ('Julia','Pott','2003-04-04'),('Doug','Rattmann','2004-07-11'),('Lydia','Allen','2002-10-02')
--GO

--INSERT INTO Professors
--VALUES ('Cave','Johnson')
--GO

--INSERT INTO Courses
--VALUES ('Math',1),('Physics',1)
--GO

--INSERT INTO Enrollments
--VALUES (1,1,GETDATE()), (2,2,GETDATE()), (3,1,GETDATE())
--GO

--INSERT INTO Grades
--VALUES (1,10),(1,12),(1,10),(2,6),(2,11),(2,9),(3,11),(1,9)
--GO

--Курсор для виведення другого та передостанього студента


  BEGIN
  DECLARE @firstname nvarchar(50)
  DECLARE @lastname nvarchar(50)
  DECLARE cur_students CURSOR SCROLL
  FOR SELECT FirstName,LastName FROM Students

  OPEN cur_students
  FETCH FIRST FROM cur_students INTO @firstname, @lastname
  BEGIN 
    FETCH RELATIVE 1 FROM cur_students INTO @firstname, @lastname
    PRINT @firstname + ' ' + @lastname
	FETCH LAST FROM cur_students INTO @firstname, @lastname
	FETCH RELATIVE -1 FROM cur_students INTO @firstname, @lastname
	PRINT @firstname + ' ' + @lastname
  END
  
  CLOSE cur_students
  DEALLOCATE cur_students
END

--Курсор для виведення студентів з парних рядків таблиці
PRINT('-------------------------------------------------------------');

  BEGIN
  DECLARE cur_students CURSOR SCROLL
  FOR SELECT FirstName,LastName FROM Students
  OPEN cur_students
  FETCH FIRST FROM cur_students INTO @firstname, @lastname
  FETCH RELATIVE 1 FROM cur_students INTO @firstname, @lastname
  PRINT @firstname + ' ' + @lastname 
  WHILE @@FETCH_STATUS=0
  BEGIN 
    FETCH RELATIVE 2 FROM cur_students INTO @firstname, @lastname
	IF (@@FETCH_STATUS=0)
	BEGIN
    PRINT @firstname + ' ' + @lastname
	END
  END
  
  CLOSE cur_students
  DEALLOCATE cur_students
END