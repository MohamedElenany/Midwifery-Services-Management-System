-- Include your create table DDL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the create table ddls for the tables with foreign key references
--    ONLY AFTER the parent tables has already been created.

-- This is only an example of how you add create table ddls to this file.
--   You may remove it.


CREATE TABLE Mother
(
	qchc CHAR(12) NOT NULL,
	name VARCHAR(50) NOT NULL,
	birthdate DATE NOT NULL,
	address VARCHAR(100) NOT NULL,
	phone CHAR(10) NOT NULL,
	email VARCHAR(75) NOT NULL UNIQUE,
	profession VARCHAR(50) NOT NULL,
	bloodType VARCHAR(10),
	PRIMARY KEY(qchc)
);

CREATE TABLE Father
(
	fatherID INTEGER NOT NULL,
	qchc CHAR(12),
	name VARCHAR(50) NOT NULL,
	birthdate DATE NOT NULL,
	address VARCHAR(100),
	phone CHAR(10) NOT NULL,
	email VARCHAR(75),
	profession VARCHAR(50) NOT NULL,
	bloodType VARCHAR(10),
	PRIMARY KEY(fatherID)
);

CREATE TABLE Couple
(
	coupleID INTEGER NOT NULL,
	qchc CHAR(12) NOT NULL,
	fatherID INTEGER,
	PRIMARY KEY(coupleID),
	FOREIGN KEY (qchc) REFERENCES Mother,
	FOREIGN KEY (fatherID) REFERENCES Father
);


CREATE TABLE HCinstitute
(
	instituteID INTEGER NOT NULL,
	name VARCHAR(50) NOT NULL,
	address VARCHAR(100) NOT NULL,
	phone CHAR(10) NOT NULL,
	email VARCHAR(75) NOT NULL UNIQUE,
	website VARCHAR(75),
	PRIMARY KEY(instituteID)
);

CREATE TABLE BirthCentre
(
	instituteID INTEGER NOT NULL,
	PRIMARY KEY(instituteID),
	FOREIGN KEY (instituteID) REFERENCES HCInstitute
);

CREATE TABLE CommunityClinic
(
	instituteID INTEGER NOT NULL,
	PRIMARY KEY(instituteID),
	FOREIGN KEY (instituteID) REFERENCES HCInstitute
);


CREATE TABLE Midwife
(
	practitionerID INTEGER NOT NULL,
	name VARCHAR(50) NOT NULL,
	phone CHAR(10) NOT NULL,
	email VARCHAR(75) NOT NULL UNIQUE,
	instituteID INTEGER NOT NULL,
	PRIMARY KEY(practitionerID),
	FOREIGN KEY (instituteID) REFERENCES HCInstitute
);

CREATE TABLE Technician
(
	techID INTEGER NOT NULL,
	name VARCHAR(50) NOT NULL,
	phone CHAR(10) NOT NULL,
	PRIMARY KEY(techID)
);

CREATE TABLE InfoSession
(
    sessionID INTEGER NOT NULL,
    date DATE NOT NULL,
    time TIME NOT NULL,
    language VARCHAR(75) NOT NULL,
    practitionerID INTEGER NOT NULL,
    PRIMARY KEY(sessionID),
    FOREIGN KEY (practitionerID) REFERENCES Midwife
);

CREATE TABLE Invited
(
    sessionID INTEGER NOT NULL,
    coupleID INTEGER NOT NULL,
    attended CHAR(1) NOT NULL CONSTRAINT bool CHECK
(attended = 'T' OR attended = 'F'),
    PRIMARY KEY(sessionID, coupleID),
    FOREIGN KEY (sessionID) REFERENCES InfoSession,
    FOREIGN KEY (coupleID) REFERENCES Couple
);

CREATE TABLE Pregnancy
(
    coupleID INTEGER NOT NULL,
    pregnancyNo INTEGER NOT NULL,
    expDueDate DATE NOT NULL,
    finalDueDate DATE,
    menstDueDate DATE,
    usoundDueDate DATE,
    interested CHAR(1) NOT NULL CONSTRAINT bool CHECK
(interested = 'T' OR interested = 'F'),
    primaryMidwife INTEGER,
    backupMidwife INTEGER,
    birthplace INTEGER,
    PRIMARY KEY(coupleID, pregnancyNo),
    FOREIGN KEY (coupleID) REFERENCES Couple,
    FOREIGN KEY (primaryMidwife) REFERENCES Midwife(practitionerID),
    FOREIGN KEY (backupMidwife) REFERENCES Midwife(practitionerID),
    FOREIGN KEY (birthplace) REFERENCES HCinstitute(instituteID)
);


CREATE TABLE Baby
(
    babyID INTEGER NOT NULL,
    coupleID INTEGER NOT NULL,
    pregnancyNo INTEGER NOT NULL,
    name VARCHAR(50),
    birthDate DATE,
    birthTime TIME,
    gender CHAR(1) CONSTRAINT bool CHECK
(gender = 'M' OR gender = 'F'),
    bloodType VARCHAR(10),
    PRIMARY KEY(babyID),
    FOREIGN KEY (coupleID, pregnancyNo) REFERENCES Pregnancy
);

CREATE TABLE Appointment
(
    appointID INTEGER NOT NULL,
    coupleID INTEGER NOT NULL,
    pregnancyNo INTEGER NOT NULL,
    practitionerID INTEGER NOT NULL,
    date DATE NOT NULL,
    time TIME NOT NULL,
    PRIMARY KEY (appointID),
    FOREIGN KEY (coupleID, pregnancyNo) REFERENCES Pregnancy,
    FOREIGN KEY (practitionerID) REFERENCES Midwife
);

CREATE TABLE Note
(
    noteID INTEGER NOT NULL,
    appointID INTEGER NOT NULL,
    date DATE NOT NULL,
    time TIME NOT NULL,
    content VARCHAR(1000) NOT NULL,
    PRIMARY KEY (noteID, appointID),
    FOREIGN KEY (appointID) REFERENCES Appointment
);

CREATE TABLE Test
(
    testID INTEGER NOT NULL,
    coupleID INTEGER NOT NULL,
    pregnancyNo INTEGER NOT NULL,
    practitionerID INTEGER NOT NULL,
    babyID INTEGER,
    techID INTEGER,
    type VARCHAR(50) NOT NULL,
    prescribedDate DATE NOT NULL,
    sampleDate DATE,
    labDate DATE,
    result VARCHAR(200),
    PRIMARY KEY (testID),
    FOREIGN KEY (coupleID, pregnancyNo) REFERENCES Pregnancy,
    FOREIGN KEY (practitionerID) REFERENCES Midwife,
    FOREIGN KEY (babyID) REFERENCES Baby,
    FOREIGN KEY (techID) REFERENCES Technician,
	CONSTRAINT sampleCheck CHECK (sampleDate >= prescribedDate AND sampleDate <= labDate)
);








