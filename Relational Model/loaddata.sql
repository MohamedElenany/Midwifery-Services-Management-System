-- Include your INSERT SQL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the INSERT statements for the tables with foreign key references
--    ONLY AFTER the parent tables!

INSERT INTO Mother (qchc,name,birthdate,address,phone,email,profession,bloodtype) VALUES
    ('xxxx12341234','Victoria Gutierrez',DATE'1985-02-24','124 Mcgill','4388888888','vgutierrez@mcgill.com','teacher','O'),
('zzzz12341234','Stephanie Joe',DATE'1995-07-24','126 Mcgill','4388888988','stephanie@mcgill.com','doctor','B'),
('yyyy12341234','Melissa May',DATE'2001-11-01','128 Mcgill','4387788898','mmay@mcgill.com','student','B'),
('wwww12341234','Dorris Jane',DATE'1973-04-15','130 Mcgill','4388881122','DJane1973@mcgill.com','accountant','AB'),
('cccc12341234','Perry Jack',DATE'1995-02-24','180 Mcgill','4384568888','jack_perry@mcgill.com','Lawyer','AB')
;

INSERT INTO Father (fatherID,qchc,name,birthdate,address,phone,email,profession,bloodtype) VALUES
('1','ccyy11222211','John Doe', DATE'1970-03-24',NULL,'4387777070',NULL,'Software Developer',NULL),
('2',NULL,'James Micheal', DATE'1983-12-30','1212 Avenue','4386677070',NULL,'Writer',NULL),
('3','zzwz11222211','Max Max', DATE'1999-06-22','1240 Avenue Peel','4386678888','mm1999@gmail.com','Athlete','AB'),
('4','zzwz11000211','WatsonJoe', DATE'1991-08-03',NULL,'4386678800','wjoeart@wj.com','Artist','O'),
('5',NULL,'Joey Bing', DATE'2000-03-03',NULL,'4336008888',NULL,'Student',NULL)
;

INSERT INTO Couple (coupleID,QCHC,fatherid) VALUES
    ('1','xxxx12341234','1'),
    ('2','zzzz12341234',NULL),
    ('3','yyyy12341234','2'),
    ('4','yyyy12341234','3'),
    ('5','wwww12341234','1')
;

INSERT INTO HCinstitute (instituteID,name,address,phone,email,website) VALUES
('1','Lac-Saint-Louis','1212 Avenue prince','4381212127','help@lacsaintlouis.ca','LacSaintLouis.ca'),
('2','Baby Home','111 Avenue prince','4381212097','babyhome@gmail.com',NULL),
('3','Best Birth Centre','111 Avenue lambert','4381313097','bestbc@gmail.com',NULL),
('4','Wisdom Centre','111 Sherbrooke','4381010100','wisdomcentre@gmail.com','wisdomcentre-qc.ca'),
('5','MTL Community Clinic','1260 Peel','4381212000','desk@mtlclinic.ca','mtlclinic.ca'),
('6','Quebec Centre','111 rene leveque','4381111000','qc-centre@gmail.com',NULL),
('7','Quebec Centre 2','1678 Place des arts','4382222000','qc-centre2@gmail.com',NULL)
;

INSERT INTO BirthCentre(instituteID) Values
('1'),('2'),('3'),('6'),('7')
;

INSERT INTO CommunityClinic(instituteID) Values
('2'),('4'),('5'),('6'),('7')
;

INSERT INTO midwife(practitionerID,name,phone,email,instituteID) VALUES
('1','Marion Girard','4339999000','mgrirard@lacsaintlouis.ca','1'),
('2','Melissa Blake','4339999111','mblake@lacsaintlouis.ca','1'),
('3','Miley Morales','4561212777','mileymorales@gmail.com','5'),
('4','Emily Emily','4561233777','emilyemily@gmail.com','5'),
('5','Tracey Tracey','4553333555','traceytracey@gmail.com','6'),
('6','Lama Lama','4553322444','lamalama@gmail.com','6')
;


INSERT INTO technician (techID,name,phone) VALUES
('1','Mandy Marc','4383311331'),
('2','Bob Doe','4384545455'),
('3','Marco Joe','4387771711'),
('4','Mario Clarke','4384665455'),
('5','Patricia Joe','4387709711')
;

INSERT INTO pregnancy (coupleID, pregnancyNo, expDueDate, finalDueDate,menstDueDate, usoundDueDate, interested, primaryMidwife,backupMidwife, birthplace) VALUES
('1','1',DATE'2020-06-21',DATE'2020-06-25',DATE'2020-05-29',DATE'2020-06-25','T','5','6','7'),
('1','2',DATE'2022-06-21',DATE'2022-06-25',DATE'2022-05-29',DATE'2022-06-25','T','1','2','1'),
('2','1',DATE'2022-06-05',NULL,DATE'2022-06-01',DATE'2022-06-25','T','6','5',NULL),
('3','2',DATE'2022-04-05',NULL,DATE'2022-04-01',DATE'2022-04-25','T','2','1','1'),
('4','1',DATE'2021-04-05',NULL,NULL,NULL,'F',NULL,NULL,NULL),
('3','1',DATE'2019-06-21',DATE'2019-06-25',DATE'2019-05-29',DATE'2019-06-25','T','1','2',NULL),
('4','2',DATE'2022-06-21',DATE'2022-06-25',DATE'2022-05-29',DATE'2022-06-25','T','1','2','1')
;

INSERT INTO infosession(sessionid,date,time,language,practitionerid) VALUES
('1',DATE'2018-12-20',TIME'15:30:00','French','5'),
('2',DATE'2020-02-22',TIME'17:37:00','English','1'),
('3',DATE'2020-08-05',TIME'12:30:00','French','4'),
('4',DATE'2022-01-20',TIME'09:30:00','French','6'),
('5',DATE'2022-02-05',TIME'13:00:00','French','2'),
('6',DATE'2022-04-15',TIME'09:45:00','English','3')
;

INSERT INTO invited (sessionid,coupleid,attended) VALUES
('1','3','T'),('2','1','T'),('3','4','T'),('4','2','F'),('5','2','T');

INSERT INTO appointment (appointid,coupleid,pregnancyno,practitionerid,date,time) VALUES
('1','3','1','1',DATE'2019-05-29',TIME'11:00:01'),
('2','1','1','5',DATE'2020-02-15',TIME'13:30:00'),
('3','1','2','1',DATE'2022-03-21',TIME'15:50:11'),
('4','3','2','1',DATE'2022-03-23',TIME'09:00:00'),
('5','1','2','1',DATE'2022-03-25',TIME'18:15:20')
;

INSERT INTO note (noteid,appointid,date,time,content) VALUES
('1','1',DATE'2019-05-29',TIME'11:20:01','Patient is anxious'),
('2','2',DATE'2020-02-15',TIME'13:40:00','Patient is feeling naucious'),
('3','3',DATE'2022-03-21',TIME'16:00:11','Patient is feeling dizzy'),
('4','3',DATE'2022-03-21',TIME'16:07:32','Patient needs tests'),
('5','4',DATE'2022-03-29',TIME'09:15:00','No comments')
;

INSERT INTO baby (babyid,coupleid,pregnancyno,name,birthdate,birthtime,gender,bloodtype) VALUES
('1','3','1','John',DATE'2019-06-25',TIME'16:00:11','M','O'),
('2','1','2',NULL,NULL,NULL,'M',NULL),
('3','1','2','Melissa',NULL,NULL,'F',NULL),
('4','1','1','Tamara',DATE'2020-06-25',TIME'23:59:55','F',NULL),
('5','1','1','Judy',DATE'2020-06-26',TIME'00:01:33','F',NULL),
('6','3','2',NULL,NULL,NULL,NULL,NULL),
('7','3','2',NULL,NULL,NULL,NULL,NULL),
('8','4','2',NULL,NULL,NULL,NULL,NULL)
;

INSERT INTO test (testid,coupleid,pregnancyno,practitionerid,babyid,techid,type,prescribeddate,sampledate,labdate,result) VALUES
('1','1','2','1',NULL,'1','blood iron',DATE'2022-01-05',DATE'2022-01-05',DATE'2022-01-08','Low Levels'),
('2','1','2','1',NULL,'3','blood iron',DATE'2022-05-05',DATE'2022-05-06',DATE'2022-05-09','Meduim Levels'),
('3','3','1','2',NULL,NULL,'diabetes',DATE'2019-05-05',DATE'2019-05-05',DATE'2019-05-05','Low-Meduim level'),
('4','3','1','2','1','2','cholestrol',DATE'2019-07-05',DATE'2019-07-07',DATE'2019-07-08','Low level'),
('5','2','1','5',NULL,NULL,'insulin resistence',DATE'2022-02-18',DATE'2022-02-19',NULL,NULL);











