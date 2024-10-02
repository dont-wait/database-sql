CREATE TABLE Major (
  MajorID   char(2) NOT NULL, 
  MajorName varchar(40) NOT NULL, 
  PRIMARY KEY (MajorID));
CREATE TABLE Student (
  StudentID char(8) NOT NULL, 
  FirstName varchar(10) NULL, 
  LastName  varchar(40) NOT NULL, 
  MajorID   char(2) NULL, 
  MID       char(2) NOT NULL, 
  PRIMARY KEY (StudentID)
);

ALTER TABLE Student ADD CONSTRAINT FKStudent633026 
					FOREIGN KEY (MID) REFERENCES Major (MajorID) 
					ON UPDATE Cascade 
					ON DELETE Set null;
