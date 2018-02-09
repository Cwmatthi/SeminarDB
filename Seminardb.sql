USE MASTER;
if (select count(*) 
    from sys.databases where name = 'SeminarDB') > 0
BEGIN
    DROP DATABASE SeminarDB;
END

CREATE DATABASE SeminarDB;
GO

USE SeminarDB

CREATE TABLE Member
(
	MemberID INT IDENTITY (1,1),
	Firstname varchar(20) NOT NULL,
	MiddleName varchar(20) NOT NULL,
	LastName varchar(20) NOT NULL,
	Gender varchar(2) NOT NULL,
	Birthdate date NOT NULL,
	Email varchar(50) NOT NULL,
	Phone varchar(12)NOT NULL

	Primary Key (MemberID)
)

CREATE TABLE MemberPass
(
	MemberPassID INT Identity,
	MemberID int NOT NULL,
	Password varbinary(150) NOT NULL,
	Promptpass bit NOT NULL,
	PassSet DATE NOT NULL,

	PRIMARY KEY (MemberPassID),
	Constraint fk_Pass_MemberID foreign key (MemberID) References Member(MemberID)
)


CREATE TABLE MemberMail
(
	AddressID INT Identity(1,1),
	MemberID INT NOT NULL,
	AddressLine1 varchar(50) NOT NULL,
	BillAddress varchar(50) NULL,
	City varchar(20) NOT NULL,
	State varchar(20) NOT NULL,
	PostalCode varchar(9) NOT NULL,
	MailBill varchar(3) NOT NULL

	Primary Key (AddressID),
	Constraint Fk_Mail_MemberID Foreign Key (MemberID) References Member(MemberID)
)

CREATE TABLE MemberNotes
(
	NoteID INT Identity (1,1) ,
	MemberID INT NOT NULL,
	Notes varchar(255) NULL,

	Primary Key (NoteID),
	Constraint Fk_Notes_MemberID Foreign Key (MemberID) References Member(MemberID)
)

CREATE TABLE MemberIntrests
(
	MemInt INT Identity(1,1),
	MemberID INT NOT NULL,
	Intrests1 varchar(25),
	Intrests2 varchar(25),
	Intrests3 varchar(25),

	Primary Key (MemINT),
	Constraint Fk_Intrests_MemberID Foreign Key (MemberID) References Member(MemberID)
)

CREATE TABLE Subscription
(
	SubscriptionID INT Identity(1,1),
	MemberID INT NOT NULL,
	SubPlan nvarchar(25) NOT NULL,
	Pricing smallmoney NOT NULL,
	Joined date NOT NULL,
	CurrentSub varchar(8) NOT NULL,

	Primary Key (SubscriptionID),
	Constraint Fk_Subs_MemberID Foreign Key (MemberID) References Member(MemberID)
)

CREATE TABLE MemberTransaction
(
	TransID INT Identity(1,1),
	MemberID INT NOT NULL,
	TransDate date NOT NULL,
	Charge smallmoney NOT NULL,
	Result varchar(15)NOT NULL,
	SubExpires date NOT NULL,

	Primary Key (TransID),
	Constraint fk_memtrans_MemberID Foreign Key(MemberID) references Member(MemberID)	
)


CREATE TABLE PaymentMethods
(
	PaymentID INT Identity(1,1),
	MemberID INT NOT NULL,
	TransID INT NOT NULL,
	CardType varchar(50) NOT NULL,
	Cardnumber nvarchar(25) NOT NULL,
	CardExp Date NOT NULL

	Primary Key (PaymentID),
	Constraint Fk_Paymethods_MemberID Foreign Key (MemberID) References Member(MemberID),
	Constraint Fk_Paymethods_TransID Foreign Key (TransID) References MemberTransaction(TransID)
)

CREATE TABLE [Events]
(
	EventID INT Identity(1,1),
	EventTitle varchar(60),
	Presentor varchar(40),
	EventDate date,
	EventTime nvarchar(10)

	Primary Key (EventID)
)

CREATE TABLE MemberEvents
(
	MemberEventsID INT Identity(1,1),
	MemberID INT NOT NULL,
	EventID INT NOT NULL,
	MemberAttend Bit NOT NULL

	Primary Key (MemberEventsID),
	Constraint Fk_MemberEvents_MemberID Foreign Key (MemberID) References Member(MemberID),
	Constraint Fk_Memberevents_EventID Foreign Key (EventID) References Events(EventID)
)

Insert into Member ([Firstname],[MiddleName],[LastName],[Gender],[Birthdate],[Email],[Phone])
Values
('Otis',	'Brooke','Fallon','M','6/29/1971','bfallon0@artisteer.com',	'818-873-3863'),
('Katee',	'Virgie','Gepp','F','6/30/1971','vgepp1@nih.gov','503-689-8066'),
('Lilla',	'Charmion',	'Eatttok',	'F',	'7/1/1971',	'ceatttok2@google.com.br',	'210-426-7426'),
('Ddene',	'Shelba',	'Clapperton',	'F',	'7/2/1971',	'sclapperton3@mapquest.com',	'716-674-1640'),
('Audrye',	'Agathe',	'Dawks',	'F',	'7/3/1971',	'adawks4@mlb.com',	'305-415-9419'),
('Fredi',	'Melisandra',	'Burgyn',	'F',	'7/4/1971',	'mburgyn5@cbslocal.com',	'214-650-9837'),
('Dimitri',	'Francisco',	'Bellino',	'M',	'7/5/1971',	'fbellino6@devhub.com',	'937-971-1026'),
('Enrico',	'Cleve',	'Seeney',	'M',	'7/6/1971',	'cseeney7@macromedia.com',	'407-445-6895'),
('Marylinda',	'Jenine',	'OSiaghail',	'F',	'7/7/1971',	'josiaghail8@tuttocitta.it',	'206-484-6850'),
('Luce',	'Codi',	'Kovalski',	'M',	'7/8/1971',	'ckovalski9@facebook.com',	'253-159-6773'),
('Claiborn',	'Shadow',	'Baldinotti',	'M',	'7/9/1971',	'sbaldinottia@discuz.net',	'253-141-4314'),
('Isabelle',	'Betty',	'Glossop',	'F',	'7/10/1971',	'bglossopb@msu.edu',	'412-646-5145'),
('Davina',	'Lira',	'Wither',	'F',	'7/11/1971',	'lwitherc@smugmug.com',	'404-495-3676'),
('Panchito',	'Hashim',	'De Gregorio',	'M',	'7/12/1971',	'hdegregoriod@a8.net',	'484-717-6750'),
('Rowen',	'Arvin',	'Birdfield',	'M',	'7/13/1971',	'abirdfielde@over-blog.com',	'915-299-3451')

Insert into MemberMail ([MemberID],[AddressLine1],[BillAddress],[City],[State],[PostalCode],[MailBill])
Values
(1,'020 New Castle Way',Null ,'Port Washington','New York',	'11054','Yes'),
(2,'8 Corry Parkway',	'P.O. Box 7088','Newton','Massachusetts','2458','No'),
(3,'39426 Stone Corner Drive',Null ,'Peoria','Illinois','61605','Yes'),
(4,'921 Granby Junction',Null ,'Oklahoma City','Oklahoma',	'73173','Yes'),
(5,'77 Butternut Parkway',Null ,'Saint Paul','Minnesota','55146','Yes'),
(6,'821 Ilene Drive',Null ,'Odessa','Texas','79764','Yes'),
(7,'1110 Johnson Court',Null ,'Rochester','New York','14624','Yes'),
(8,'6 Canary Hill',	'P.O. Box 255',	'Tallahassee',	'Florida','32309','No'),
(9,'9 Buhler Lane',Null ,'Bismarck','North Dakota',	'58505','Yes'),
(10,'99 Northwestern Pass',Null ,'Midland',	'Texas','79710','Yes'),
(11,'69 Spenser Hill',Null ,'Provo','Utah',	'84605','Yes'),
(12,'3234 Kings Court','P.O. Box 1233','Tacoma','Washington','98424','No'),
(13,'3 Lakewood Gardens Circle',Null ,'Columbia','South Carolina','29225','Yes'),
(14,'198 Muir Parkway',Null ,'Fairfax','Virginia','22036','Yes'),
(15,'258 Jenna Drive',Null ,'Pensacola','Florida','32520','Yes')

Insert into MemberPass([MemberID],[Password],[Promptpass],[PassSet])
Values
(1,HASHBYTES('SHA2_512', 'Password1'),0,'2017-04-07'),
(2,HASHBYTES('SHA2_512', 'Password2'),0,'2017-11-29'),
(3,HASHBYTES('SHA2_512', 'Password3'),0,'2017-02-26'),
(4,HASHBYTES('SHA2_512', 'Password4'),0,'2017-11-05'),
(5,HASHBYTES('SHA2_512', 'Password5'),0,'2016-01-15'),
(6,HASHBYTES('SHA2_512', 'Password6'),0,'2017-03-13'),
(7,HASHBYTES('SHA2_512', 'Password7'),0,'2017-08-09'),
(8,HASHBYTES('SHA2_512', 'Password8'),0,'2017-09-09'),
(9,HASHBYTES('SHA2_512', 'Password9'),0,'2016-11-21'),
(10,HASHBYTES('SHA2_512', 'Password10'),0,'2017-12-02'),
(11,HASHBYTES('SHA2_512', 'Password11'),0,'2017-03-19'),
(12,HASHBYTES('SHA2_512', 'Password12'),0,'2016-04-21'),
(13,HASHBYTES('SHA2_512', 'Password13'),0,'2016-03-21'),
(14,HASHBYTES('SHA2_512', 'Password14'),0,'2017-11-21'),
(15,HASHBYTES('SHA2_512', 'Password15'),0,'2017-10-06')




Insert into MemberNotes ([MemberID],[Notes])
Values
(1,'nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id'),
(2,'a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus'),
(3,'porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit amet sem fusce consequat nulla nisl nunc nisl'),
(4,'morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis'),
(5,'nisi at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer'),
(6,'congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien'),
(7,'eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium'),
(8,'dapibus duis at velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum'),
(9,'curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam'),
(10,'magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus'),
(11,'lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo'),
(12,'magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus'),
(13,'bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa donec dapibus duis at'),
(14,'imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in hac habitasse'),
(15,'etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius')


Insert into MemberIntrests ([MemberID],[Intrests1],[Intrests2],[Intrests3])
Values
(1,'Acting',	'Video Games',	'Crossword Puzzles'),
(2,'Calligraphy',Null,Null),
(3,'Movies',	'Restaurants',	'Woodworking'),
(4,'Juggling',	'Quilting',	Null),
(5,'Electronics',Null,Null),
(6,'Sewing',	'Cooking',	'Movies'),
(7,'Botany',	'Skating',Null),
(8,'Dancing',	'Coffee',	'Foreign Languages'),
(9,'Fashion',Null,Null),
(10,'Woodworking',Null,Null),
(11,'Homebrewing',	'Geneology',	'Movies, Scrapbooking'),
(12,'Surfing',	'Amateur Radio',Null),
(13,'Computers',Null,Null),
(14,'Writing',	'Singing',Null),
(15,'Reading',	'Pottery',Null)

Insert into Subscription ([MemberID],[SubPlan],[Pricing],[Joined],[CurrentSub])
Values
(1,'Monthly',9.99,'04/07/2017','Yes'),
(2,'Monthly',9.99,'11/29/2017','Yes'),
(3,'3 Month',27.99,'02/26/2017','Yes'),
(4,'3 Month',27.99,'11/05/2017','Yes'),
(5,'Monthly',9.99,'01/15/2016','Yes'),
(6,'Free',99.00,'03/13/2017','Free'),
(7,'Monthly',9.99,'08/09/2017','Yes'),
(8,'Yearly',99.00,'09/09/2017','Yes'),
(9,'Yearly',99.00,'11/21/2016','Free'),
(10,'Monthly',9.99,'12/2/2017','Yes'),
(11,'Monthly',9.99,'03/19/2017','Yes'),
(12,'Free',27.99,'04/21/2016','Free'),
(13,'Free',99.99,'03/21/2016','Free'),
(14,'Monthly',9.99,'11/21/2017','Yes'),
(15,'Monthly',9.99,'10/06/2017','Free')

Insert into MemberTransaction ([MemberID],[TransDate],[Charge],[Result],SubExpires)
Values
(5,'1/15/2016','9.99','Approved','2/15/2016'),
(5,'2/15/2016','9.99','Approved','3/15/2016'),
(5,'3/15/2016','9.99','Approved','4/15/2016'),
(13,'3/21/2016','99.99','Approved','3/21/2017'),
(5,'4/15/2016','9.99','Approved','5/15/2016'),
(13,'4/21/2016','99.00','Approved','4/21/2017'),
(12,'4/25/2016','27.00','Approved','7/25/2016'),
(5,'5/15/2016','9.99','Approved','6/15/2016'),
(5,'6/15/2016','9.99','Approved','7/15/2016'),
(5,'7/15/2016','9.99','Approved','8/15/2016'),
(12,'7/25/2016','27.00','Approved','10/25/2016'),
(5,'8/15/2016','9.99','Approved','9/15/2016'),
(8,'9/9/2016','99.00','Approved','9/9/2017'),
(5,'9/15/2016','9.99','Approved','10/15/2016'),
(5,'10/15/2016','9.99','Approved','11/15/2016'),
(12,'10/25/2016','27.00','Approved','1/25/2017'),
(5,'11/15/2016','9.99','Approved','12/15/2016'),
(9,'11/21/2016','99.00','Approved','11/21/2017'),
(5,'12/15/2016','9.99','Approved','1/15/2017'),
(5,'1/15/2017','9.99','Approved','2/15/2017'),
(12,'1/25/2017','27.00','Approved','4/25/2017'),
(14,'1/27/2017','9.99','Approved','2/27/2017'),
(5,'2/15/2017','9.99','Approved','3/15/2017'),
(3,'2/26/2017','27.00','Approved','5/26/2017'),
(14,'2/27/2017','9.99','Approved','3/27/2017'),
(6,'3/13/2017','99.00','Approved','3/13/2018'),
(5,'3/15/2017','9.99','Approved','4/15/2017'),
(11,'3/19/2017','9.99','Approved','4/19/2017'),
(14,'3/27/2017','9.99','Approved','4/27/2017'),
(1,'4/7/2017','9.99',	'Approved','5/15/2017'),
(5,'4/15/2017','9.99','Approved','5/15/2017'),
(11,'4/19/2017','9.99','Approved','5/19/2017'),
(12,'4/25/2017','27.00','Approved','7/25/2017'),
(14,'4/27/2017','9.99','Approved','5/27/2017'),
(1,'5/7/2017','9.99',	'Approved','6/7/2017'),
(5,'5/15/2017','9.99','Approved','6/15/2017'),
(11,'5/19/2017','9.99','Approved','6/19/2017'),
(3,'5/26/2017','27.00','Approved','8/26/2017'),
(14,'5/27/2017','9.99','Approved','6/27/2017'),
(1,'6/7/2017','9.99','Declined','7/7/2017'),
(1,'6/8/2017','9.99','Approved','7/7/2017'),
(5,'6/15/2017','9.99','Approved','7/15/2017'),
(11,'6/19/2017','9.99','Approved','7/19/2017'),
(14,'6/27/2017','9.99','Approved','7/27/2017'),
(1,'7/7/2017','9.99',	'Approved','8/7/2017'),
(5,'7/15/2017','9.99','Approved','8/15/2017'),
(11,'7/19/2017','9.99','Declined','8/19/2017'),
(11,'7/20/2017','9.99','Approved','8/20/2017'),
(12,'7/25/2017','27.00','Approved','10/25/2017'),
(14,'7/27/2017','9.99','Approved','8/27/2017'),
(1,'8/7/2017','9.99','Approved','9/7/2017'),
(7,'8/9/2017','9.99','Approved','9/9/2017'),
(5,'8/15/2017','9.99','Approved','9/15/2017'),
(11,'8/19/2017','9.99','Approved','9/19/2017'),
(3,'8/26/2017','27.00','Approved','11/26/2017'),
(14,'8/27/2017','9.99','Approved','9/27/2017'),
(1,'9/7/2017','9.99','Approved','10/7/2017'),
(7,'9/9/2017','9.99','Approved','10/9/2017'),
(8,'9/9/2017','99.99','Approved','9/9/2018'),
(5,'9/15/2017','9.99','Approved','10/15/2017'),
(11,'9/19/2017','9.99','Approved','10/19/2017'),
(14,'9/27/2017','9.99','Approved','10/27/2017'),
(15,'10/6/2017','9.99','Invalid Card','11/6/2017'),
(1,'10/7/2017','9.99','Approved','11/7/2017'),
(7,'10/9/2017','9.99','Approved','11/9/2017'),
(5,'10/15/2017','9.99','Approved','11/15/2017'),
(11,'10/19/2017','9.99','Approved','11/19/2017'),
(12,'10/25/2017','27.00','Approved','1/25/2018'),
(14,'10/27/2017','9.99','Approved','11/27/2017'),
(4,'11/5/2017','27.00','Approved','2/5/2018'),
(1,'11/7/2017','9.99','Approved','12/7/2017'),
(7,'11/9/2017','9.99','Approved','12/9/2017'),
(5,'11/15/2017','9.99','Approved','12/15/2017'),
(11,'11/19/2017','9.99','Approved','12/19/2017'),
(3,'11/26/2017','27.00','Declined','2/26/2018'),
(3,'11/27/2017','27.00','Approved','2/27/2018'),
(14,'11/27/2017','9.99','Approved','12/27/2017'),
(2,'11/29/2017','9.99','Approved','12/29/2017'),
(1,'12/7/2017','9.99','Approved','1/7/2018'),
(7,'12/9/2017','9.99','Approved','1/9/2018'),
(5,'12/15/2017','9.99','Approved','1/15/2018'),
(11,'12/19/2017','9.99','Approved','1/19/2018'),
(10,'12/22/2017','9.99','Approved','1/22/2018'),
(14,'12/27/2017','9.99','Approved','1/27/2018'),
(2,'12/29/2017','9.99','Approved','1/29/2018'),
(1,'1/7/2018','9.99','Approved','2/7/2018'),
(7,'1/9/2018','9.99','Approved','2/9/2018'),
(5,'1/15/2018','9.99','Approved','2/15/2018'),
(11,'1/19/2018','9.99','Approved','2/19/2018'),
(10,'1/22/2018','9.99','Approved','2/22/2018'),
(12,'1/25/2018','27.00','Approved','4/25/2018'),
(14,'1/27/2018','9.99','Approved','2/27/2018')

Insert into PaymentMethods ([MemberID],[TransID],[CardType],[Cardnumber],CardExp)
Values
(1,1,'American Express',337941553240515,'07/01/2019'),
(2,78,'Visa',4041372553875903,'01/01/20'),
(3,24,'Visa',4041593962566,'03/01/19'),
(4,70,'JCB',3559478087149594,'04/01/2019'),
(5,1,'JCB',3571066026049076,'07/01/2018'),
(6,26,'Diners Club Carte Blanche',30423652701879,'05/01/2018'),
(7,52,'JCB',3532950215393858,'02/01/2019'),
(8,13,'JCB',3569709859937370,'03/01/2019'),
(9,18,'JCB',3529188090740670,'05/01/2019'),
(10,83,'JCB',3530142576111598,'11/01/2019'),
(11,28,'Mastercard',5108756299877313,'07/01/2018'),
(12,7,'JCB',3543168150106220,'06/01/2018'),
(13,4,'JCB',3559166521684728,'10/01/2019'),
(14,22,'Diners Club Carte Blanche',30414677064054,'05/01/2018'),
(15,63,'JCB',3542828093985763,'03/01/2020')


Insert into Events ([EventTitle],[Presentor],[EventDate],[EventTime])
Values
('The History of Human Emotions','Tiffany Watt Smith','01/12/2017','8:00PM'),
('How Great Leaders Inspire Action','Simon Sinek','02/22/2017','6:00PM'),
('The Puzzle of Motivation','Dan Pink','03/05/2017','12:00PM'),
('Your Elusive Creative Genius','Elizabeth Gilbert','04/16/2017','5:00PM'),
('Why are Programmers So Smart?', 'Andrew Comeau','05/01/2017','7:00PM')

Insert into MemberEvents ([MemberID],[EventID],[MemberAttend])
Values
(1,1,0),
(1,2,0),
(1,3,1),
(1,4,1),
(1,5,1),
(2,1,1),
(2,2,0),
(2,3,1),
(2,4,1),
(2,5,0),
(3,1,1),
(3,2,1),
(3,3,1),
(3,4,0),
(3,5,1),
(4,1,1),
(4,2,1),
(4,3,1),
(4,4,1),
(4,5,1),
(5,1,1),
(5,2,1),
(5,3,1),
(5,4,1),
(5,5,0),
(6,1,1),
(6,2,0),
(6,3,1),
(6,4,1),
(6,5,0),
(7,1,0),
(7,2,1),
(7,3,1),
(7,4,1),
(7,5,0),
(8,1,1),
(8,2,1),
(8,3,1),
(8,4,1),
(8,5,0),
(9,1,0),
(9,2,1),
(9,3,1),
(9,4,1),
(9,5,0),
(10,1,1),
(10,2,1),
(10,3,0),
(10,4,0),
(10,5,0),
(11,1,1),
(11,2,1),
(11,3,0),
(11,4,0),
(11,5,0),
(12,1,1),
(12,2,0),
(12,3,1),
(12,4,1),
(12,5,1),
(13,1,1),
(13,2,1),
(13,3,0),
(13,4,0),
(13,5,1),
(14,1,0),
(14,2,1),
(14,3,1),
(14,4,1),
(14,5,0),
(15,1,1),
(15,2,1),
(15,3,1),
(15,4,1),
(15,5,0);






----------------------------------------------------------------
--Shows fullname and mailing address for all members who are currently subscribed

Go
Create view MemberList
as
Select		CONCAT(m.Firstname,' ',m.Lastname)[Full Name],mm.AddressLine1,mm.City,mm.State,mm.PostalCode
From		Member m
Inner join	MemberMail mm
on			mm.MemberID = m.MemberID
inner join	Subscription s
on			s.MemberID = m.MemberID
Where s.CurrentSub = 'Yes' or s.CurrentSub = 'Free';
-----------------------------------------------------------------
--Shows members fullname and their email.

Go
Create View MemberEmail
as
Select		CONCAT(Firstname,' ', Lastname)[Full Name],Email
From		Member;
------------------------------------------------------------------
--Shows the fullname and birthdate of members on a specific month.
Go
Create Procedure sp_BirthdayList
					(@month Int)
as
Begin
		Select CONCAT(Firstname,' ', Lastname)[Full Name],Birthdate
		From	Member
		Where	Month(Birthdate) = @month
End
-------------------------------------------------------------------
--Deletes the payment method if the creditcard is expired. 
Go
Create Trigger tr_ExpiredCards
on PaymentMethods
For Delete 
as
Select CardExp
From PaymentMethods
Where GETDATE() > CardExp 
GO
---------------------------------------------------------------------
--Shows the income from only renewals between a specified time.
GO
Create Procedure sp_RenewalIncome
				@StartDate date,
				@EndDate date
AS
Begin 
		Select Sum(Charge) as Total
		From	MemberTransaction
		Where TransDate between @StartDate and @EndDate
END

--exec sp_RenewalIncome '2016-2-16','2018-2-16'
-----------------------------------------------------------------------
--Show the amount of new members recieved between specified dates

GO
Create Procedure sp_NewMembers
				@StartDate date,
				@EndDate date
AS
Begin 
		Select		CONCAT(Firstname,' ', Lastname)[Full Name], s.Joined
		From		Member m
		inner join	subscription s
		on			s.MemberID = m.MemberID
		Where Joined between @StartDate and @EndDate
END
-------------------------------------------------------------------------
--Shows the attendence between a selected startdate and enddate.
GO
Create Procedure sp_EventAttend
				@StartDate date,
				@EndDate date
AS
Begin 
		Select		COUNT(MemberAttend)
		From		MemberEvents m
		inner join	Events e
		on			e.EventID = m.EventID
		Where e.EventDate between @StartDate and @EndDate
END
--Exec sp_EventAttend '01/12/2017','03/05/2017'
---------------------------------------------------------------------------
--The view shows the members that are on the day of being expired or already expired, The the SP allows you to insert into the Transaction table.

GO
Create View SubExpire
as
Select		mt.MemberID, SubExpires,Charge,s.SubPlan
From		MemberTransaction mt
Inner join	(Select MemberID, Max(subexpires)[MaxDate]
			 From MemberTransaction
			 Group by memberID) as m
On m.MemberID =  mt.MemberID and mt.SubExpires = m.MaxDate
Inner join	Subscription s
on			s.MemberID = mt.MemberID
Where 		s.currentsub = 'Yes' and mt.SubExpires <= Getdate();

GO
Create Procedure sp_UpdateMembership
				 @memberID INT,
				 @transdate date,
				 @Charge smallmoney,
				 @Result varchar(15),
				 @SubExpires date
as 
Begin

Insert into MemberTransaction ([MemberID],[TransDate],[Charge],[Result],[SubExpires])
Values
(@memberID,@transdate,@Charge,@Result,@SubExpires)
END;

--EXEC sp_UpdateMembership 4,'2018-02-05', 27.00,'Approved','2018-05-05'
--Exec sp_UpdateMembership 2, '2018-01-29',9.99,'Approved','2018-03-01'


