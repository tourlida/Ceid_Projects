DROP DATABASE League;
CREATE DATABASE League;
USE League;
 

CREATE TABLE IF NOT EXISTS Team(
name VARCHAR(25) DEFAULT 'unknown' NOT NULL,
goals_out INT(9) NOT NULL,
goals_in INT(9) NOT NULL,
wins INT(9) NOT NULL,
losses INT(9) NOT NULL,
draws INT(9) NOT NULL,
points INT(9) NOT NULL,
PRIMARY KEY(name)
)engine=InnoDB;

CREATE TABLE IF NOT EXISTS Player(
 id_play INT(9) NOT NULL AUTO_INCREMENT,
 name VARCHAR(25) DEFAULT 'unknown' NOT NULL,
    lastname VARCHAR(25) DEFAULT 'unknown' NOT NULL,
    age INT(9) NOT NULL,
    goals INT(9) NOT NULL,
    bio TEXT,
    team VARCHAR(25) DEFAULT 'unknown' NOT NULL,
 pos ENUM('Normal','GoalKeeper') ,
 PRIMARY KEY(id_play),
 CONSTRAINT Team FOREIGN KEY(team) REFERENCES Team(name)
 ON UPDATE CASCADE ON DELETE CASCADE
)engine=InnoDB;


CREATE TABLE IF NOT EXISTS Fan(
   id_fan INT(9) NOT NULL AUTO_INCREMENT,
   name VARCHAR(25) DEFAULT 'unknown' NOT NULL,
   lastname VARCHAR(25) DEFAULT 'unknown' NOT NULL,
   age INT(9) NOT NULL,
   reneawl ENUM('00','01','10','11'),
   team VARCHAR(25) DEFAULT 'unknown' NOT NULL,
   PRIMARY KEY(id_fan),
   CONSTRAINT TEAM2 FOREIGN KEY(team) REFERENCES Team(name)
   ON UPDATE CASCADE ON DELETE CASCADE
) engine=InnoDB;



CREATE TABLE IF NOT EXISTS Chairman(
id_chair INT(9) NOT NULL AUTO_INCREMENT,
name VARCHAR(25) DEFAULT 'unknown' NOT NULL,
lastname VARCHAR(25) DEFAULT 'unknown' NOT NULL,
age INT(9) NOT NULL,
team VARCHAR(25) DEFAULT 'unknown' NOT NULL,
bio TEXT,
PRIMARY KEY(id_chair),
CONSTRAINT TEAM_CH FOREIGN KEY(team) REFERENCES Team(name)
ON UPDATE CASCADE ON DELETE CASCADE
)engine=InnoDB;

CREATE TABLE IF NOT EXISTS Nickname(
id_chairman INT(9) NOT NULL,
nickname VARCHAR(25) DEFAULT 'unknown' NOT NULL,
PRIMARY KEY(id_chairman,nickname),
CONSTRAINT CH_NICKNAME FOREIGN KEY(id_chairman) REFERENCES Chairman(id_chair)
ON UPDATE CASCADE ON DELETE CASCADE
)engine=InnoDB;

CREATE TABLE IF NOT EXISTS Coach(
id_coach INT(9) NOT NULL AUTO_INCREMENT,
name VARCHAR(25) DEFAULT 'unknown' NOT NULL,
lastname VARCHAR(25) DEFAULT 'unknown' NOT NULL,
age INT(9) NOT NULL,
wins INT(9) NOT NULL,
loses INT(9) NOT NULL,
draws INT(9) NOT NULL,
teams_coach VARCHAR(100) DEFAULT 'unknown' NOT NULL,
bio TEXT,
team VARCHAR(25) DEFAULT 'unknown' NOT NULL,
PRIMARY KEY(id_coach),
CONSTRAINT TEAM_COACH FOREIGN KEY(team) REFERENCES Team(name)
ON UPDATE CASCADE ON DELETE CASCADE
)engine=InnoDB;


CREATE TABLE IF NOT EXISTS Stadium(
name VARCHAR(25) DEFAULT 'unknown' NOT NULL,
city VARCHAR(25) DEFAULT 'unknown' NOT NULL,
capacity BIGINT  NOT NULL ,
UNIQUE(name),
PRIMARY KEY(name)
)engine=InnoDB;

CREATE TABLE IF NOT EXISTS Grounded(
team VARCHAR(25) DEFAULT 'unknown' NOT NULL,
stadium VARCHAR(25) DEFAULT 'unknown' NOT NULL,
PRIMARY KEY(team,stadium),
CONSTRAINT GROUNDED FOREIGN KEY(team) REFERENCES Team(name)
ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT GROUND FOREIGN KEY(stadium) REFERENCES Stadium(name)
ON UPDATE CASCADE ON DELETE CASCADE
)engine=InnoDB;

CREATE TABLE IF NOT EXISTS Admires(
player INT(9) NOT NULL,
fan INT(9) NOT NULL ,
PRIMARY KEY(player,fan),
CONSTRAINT FAN FOREIGN KEY(fan) REFERENCES Fan(id_fan)
ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT PLAYER FOREIGN KEY(player) REFERENCES Player(id_play)
ON UPDATE CASCADE ON DELETE CASCADE
)engine=InnoDB;


CREATE TABLE IF NOT EXISTS Refee(
id_refee INT(9) NOT NULL AUTO_INCREMENT,
name VARCHAR(25) DEFAULT 'unknown' NOT NULL,
lastname VARCHAR(25) DEFAULT 'unknown' NOT NULL,
age INT(9) NOT NULL,
position ENUM('Main','Observer','Fourth','Supervisor'),
PRIMARY KEY(id_refee)
)engine=InnoDB;


CREATE TABLE IF NOT EXISTS Game(
game_id INT(9) NOT NULL AUTO_INCREMENT,
result ENUM('Grounded_Win','Grounded_Lose','Draw'),
grounded VARCHAR(25) DEFAULT 'unknown' NOT NULL,
guest VARCHAR(25) DEFAULT 'unknown' NOT NULL,
score1 VARCHAR(25) DEFAULT 'unknown' NOT NULL,
description TEXT,
refee INT(9) NOT NULL,
stadium VARCHAR(25) DEFAULT 'unknown' NOT NULL,
time TIME,
date DATE,
PRIMARY KEY(game_id),
CONSTRAINT 	TeamA FOREIGN KEY(grounded) REFERENCES Team(name)
ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT 	TeamB FOREIGN KEY(guest) REFERENCES Team(name)
ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT 	REFEES FOREIGN KEY(refee) REFERENCES Refee(id_refee)
ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT Stadium FOREIGN KEY(stadium) REFERENCES Stadium(name)
ON UPDATE CASCADE ON DELETE CASCADE
)engine=InnoDB; 

CREATE TABLE IF NOT EXISTS Ticket(
code INT(9) NOT NULL AUTO_INCREMENT,
team_tick VARCHAR(25) DEFAULT 'unknown' NOT NULL,
game INT(9),
kind ENUM('SIMPLE','CONTINUOUS'),
price ENUM('10','200'),
PRIMARY KEY(code),
CONSTRAINT team1 FOREIGN KEY(team_tick) REFERENCES Team(name)
ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY(game) REFERENCES Game(game_id)
ON UPDATE CASCADE ON DELETE CASCADE
) engine=InnoDB;

CREATE TABLE IF NOT EXISTS Use_Premium(
game INT(9) NOT NULL,
fan INT(9) NOT NULL,
PRIMARY KEY(game,fan),
CONSTRAINT gameA FOREIGN KEY(game) REFERENCES Game(game_id)
ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT fanA FOREIGN KEY(fan) REFERENCES Fan(id_fan)
ON UPDATE CASCADE ON DELETE CASCADE
)engine=InnoDB; 

CREATE TABLE IF NOT EXISTS Purchased(
ticket_code INT(9),
fan_id INT(9), 
PRIMARY KEY(ticket_code),
CONSTRAINT Ticket_Code FOREIGN KEY(ticket_code) REFERENCES Ticket(code)
ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT Fan_id  FOREIGN KEY(fan_id) REFERENCES Fan(id_fan)
ON UPDATE CASCADE ON DELETE CASCADE
)engine=InnoDB;

/*CREATE TABLE Participated(
supervisor INT(9) NOT NULL ,
game INT(9) NOT NULL ,
PRIMARY KEY(supervisor,game),
CONSTRAINT Superv FOREIGN KEY(supervisor) REFERENCES Supervisor(ref1_id)
ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT Game FOREIGN KEY(game) REFERENCES Game(game_id)
ON UPDATE CASCADE ON DELETE CASCADE
)engine=InnoDB;
*/
ALTER TABLE Player AUTO_INCREMENT=1000;
ALTER TABLE Fan AUTO_INCREMENT=2000; 
ALTER TABLE Chairman AUTO_INCREMENT=3000; 
ALTER TABLE Coach AUTO_INCREMENT=4000; 
ALTER TABLE Refee AUTO_INCREMENT=5000; 
ALTER TABLE Game AUTO_INCREMENT=6000;   

INSERT INTO Team(name,goals_out,goals_in,wins,losses,draws,points)
VALUES ('HRAKLHS', 5 , 2, 1, 30, 12, 8),
( 'AEK' , 6, 7, 2, 36, 11, 5),
( 'LEVADEIAKOS', 4, 3, 5, 19, 7, 6),
( 'OLYMPIAKOS', 8, 3, 1, 35, 4, 9),
( 'PANAITWLIKOS', 5, 3, 1, 30, 6, 10),
( 'PAOK', 3, 2, 4, 20, 12, 7);

INSERT INTO Player(name,lastname,goals,bio,age,pos,team)
VALUES('Galo','Strat',0,'gashdghsagvhsagvhdbasvdsba',30,'Goalkeeper','AEK'),
('Kolovtsios','Sinis',20,'ahsgsdhsaghdgashgfsdhgfh',25,'Normal','AEK'),
('Lampropoulos','Makhs',12,'asjghdhasgfhgsavhdchascg',26,'Normal','AEK'),
('GIOCHANSON','Marios',3,'SADHASJHDCGASHDSA',29,'Normal','AEK'),
('GALANOPOULOS','Eirhneos',2,'DASHJGDHASCGHDGHSAG',28,'Normal','AEK'),
('Rodrigez','Renos',3,'asjdhgjsagdhsgadsa',32,'Normal','AEK'),
('Vargas','Renatos',1,'ashgdhsagdhagsdhgashd',30,'Normal','AEK'),
('Madalos','Marios',2,'ajshdjashdjgasdhjas',25,'Normal','AEK'),
('Tselios','Ntanos',0,'ajshdjashjdhsajd',19,'Normal','AEK'),
('Vlaxomhtros','Andreas',0,'asjhdjsahdcaghgdhcags',19,'Normal','AEK'),
('AINTAREVITS','Kwstas',2,'asdjghhasgdhgsahdghasgdhas',26,'Normal','AEK'),
('Xristodoulopoulos','Katerinos',0,'asdjhgasjdgsjagdhasj',29,'Normal','AEK'),
('SIMOES','Rinos',1,'SAJDHJSAHDJHSAJDHAJSHDJSAHDJSAHDJ',27,'Normal','AEK'),
('Mpakasetas','Sakhs',0,'ahsgdhsagdhsaghdgsahdsa',33,'Normal','AEK'),
('Aravidhs','Luciano',0,'ashjdjsahdjhsajdhsjahd',29,'Normal','AEK'),
('Melhnikiwths','Leo',0,'asjhdjsahdjhsaj',28,'Normal','AEK'),
('ALMEIDA','Lusandros',1,'asjdhsajhdjsahdjashjdhas',32,'Normal','AEK'),
('SAXOF','Manwlhs',1,'jidiofroj;oijjq34h',26,'Normal','AEK'),
('TZIOLHS','Emanuel',0,'iijdefojpofepieunrhiuho',31,'Goalkeeper','LEVADEIAKOS'),
('KANIAS','Xrhstos',13,'jqrpfi;3kjpf4',29,'Normal','LEVADEIAKOS'),
('PELKAS','Ntanos',4,'hbierqhuojipkfpa',23,'Normal','LEVADEIAKOS'),
('KOROVESIS','Spal',0,'ihdionjpjwk[erjpfhohw',25,'Normal','LEVADEIAKOS'),
('KATSE','Marinos',0,'jousihudepfjho',23,'Normal','LEVADEIAKOS'),
('BISESVAR','Grounded_Wintas',0,'QNFOJIPojihubojipkop',28,'Normal','LEVADEIAKOS'),
('MUSTAKIDHS','Oresths',13,'noijjk[rpkffijj30ok',22,'Normal','LEVADEIAKOS'),
('TZALMA','Lampis',7,'VUBIUijohukcvwbhnjoiwljv',29,'Normal','LEVADEIAKOS'),
('ATHANASIADHS','Alex',0,'ojihuyghiojsp[poihu',28,'Normal','LEVADEIAKOS'),
('PEREIRA','Mhtsos',2,'PKOJAJOIPOiughjOJHU',28,'Normal','LEVADEIAKOS'),
('KOULOURHS','Nikos',0,'iohugyfhjuiopkiugfgvbhu',20,'Normal','LEVADEIAKOS'),
('LAMPROU','Lazaros',0,'oojihugyftfcfhgjk',20,'Normal','LEVADEIAKOS'),
('LEALI','Swkraths',8,'ojihugytvbhnjk',23,'Normal','LEVADEIAKOS'),
('KAPINO','Mogli',0,'POpojiuiyugyhj',22,'Normal','LEVADEIAKOS'),
('XOUTESIWTS','Tarzan',12,'hjpoklikgu',22,'Normal','PAOK'),
('VOYROS','Kwstas',0,'oihughjk',21,'Normal','PAOK'),
('RETSOS','Jan',9,'oiugyftfokplihuh',18,'Normal','PAOK'),
('VIANA','Mal',0,'lkjhgbhijok;olikhjgh',31,'Goalkeeper','PAOK'),
('FIGKARO','Mov',5,'lkojikhugyftdcfguhiujop',25,'Normal','PAOK'),
('NTAKOSTA','Stergios',0,'ljihuyftyuhiokp[;oliuy',30,'Normal','PAOK'),
('MPOTIA','Stelios',9,'kolikjuyftdfgyuiop',26,'Normal','PAOK'),
('KAMPIASO','Dhmos',0,'ghijokpkoiugyftvghbjko',36,'Normal','PAOK'),
('MANIATHS','Anesths',3,'pojiuhgyftrdfghjui',30,'Normal','PAOK'),
('FOURTOYNHS','Aristos',5,'pojikhugftgvuhijo',26,'Normal','PAOK'),
('DOMIGEZ','Murtilos',8,'ikujyhftgdgvhjkklkjhgf',36,'Normal','PAOK'),
('KYRIAKIDHS','Aris',4,'lkhjgfxdghjik;',30,'Normal','PAOK'),
('KOLOBOURHS','Arizonas',3,'kljkighyftgvhjk',24,'Normal','OLYMPIAKOS'),
('KOUTROUMANHS','Bo',0,'LKIHUGYFTRDFGVHJI',29,'Normal','OLYMPIAKOS'),
('TZITZHS','Murtilos',6,'pkojihugftrdfvgbjko',23,'Normal','OLYMPIAKOS'),
('TSOKANHS','Panos',0,'guhyiujoiopkjihguyfu',32,'Normal','OLYMPIAKOS'),
('MALHS','Marios',3,';oljkihgyftdcvhjipk;klkhg',23,'Normal','OLYMPIAKOS'),
('RONTRIGEZ','Odusseas',13,'pokjihugyftdrfghuiujo',23,'Normal','OLYMPIAKOS'),
('PAPAZOGLOU','Dias',0,'PLKFTFPOJIHUGYF',28,'Goalkeeper','OLYMPIAKOS'),
('XANTAKIAS','Zeus',0,'llklhuftydrfghuijoikpo',28,'Goalkeeper','OLYMPIAKOS'),
('KOUSAS','Axilleas',8,'oljgyftdfghujiko',24,'Normal','OLYMPIAKOS'),
('MUGAS','Ektoras',9,';lkjugtdrcuyihuopko',22,'Normal','OLYMPIAKOS'),
('NAMASKO','Paris',15,'jlikjfxfcgvhjk',30,'Normal','OLYMPIAKOS'),
('MOSXONAS','Adhs',0,'okljihugftdguhiujoi',26,'Normal','OLYMPIAKOS'),
('SYNODINOS','Ermhs',3,';kokihjugyftdcvubiuoijopko',19,'Normal','PANAITWLIKOS'),
('DASKALAKHS','Apollwnas',0,'hjljlhkgjfhxfcvbhnjmkkhg',21,'Goalkeeper','PANAITWLIKOS'),
('TRIPOTSERHS','leandro',0,'jrsxtyfugiiukhliknbvcy',30,'Goalkeeper','PANAITWLIKOS'),
('TOPI','Pasxalhs',4,'lkjhgfgguhijlkvgfytuy',21,'Normal','PANAITWLIKOS'),
('MENTI','Ermhs',0,'jlukgyuftbg',21,'Normal','PANAITWLIKOS'),
('MAGKAS','Apollwnas',12,'ihgyuftdrcvuiuopokjlknjbvh',22,'Normal','PANAITWLIKOS'),
('KASPAS','Ermhs',0,'kjhgfdcfyguihbvcfytugj',30,'Normal','PANAITWLIKOS'),
('MOULOPOULOS','Apollwnas',3,'szxcyugihhjmhncytuio',31,'Normal','PANAITWLIKOS'),
('PROGITS','Ermhs',0,'jhgyftdresdrftgihojkbvgt',29,'Normal','PANAITWLIKOS'),
('MILIAGETS','Apollwnas',3,'ercytvyuuhkljkjjc',33,'Normal','PANAITWLIKOS'),
('MAXAIRAS','Apollwnas',0,'sybiujoksopiajkhbgyu89ho',26,'Normal','PANAITWLIKOS'),
('PEDRO','Paris',0,'gyutrdyftugyhuioj',26,'Normal','PANAITWLIKOS'),
('BIGIA','Paris',7,'kjhgfdyfuikjhvgcffugih',21,'Normal','HRAKLHS'),
('POURTOULIDHS','Paris',0,'dfyguhiuhgyftuuvg',33,'Goalkeeper','HRAKLHS'),
('ZAMPAZHS','Paris',2,'kjhgfdfyugiuhkjnbvgu',19,'Normal','HRAKLHS'),
('HLIADHS','Paris',0,'hbuinjlkuiy',23,'Normal','HRAKLHS'),
('MPLETSAS','Axilleas',1,'kjhgfdftgyiuoipolkjvg',21,'Normal','HRAKLHS'),
('AGGELOPOULOS','Axilleas',0,'tfsguyhodjowejd0h0w',19,'Normal','HRAKLHS'),
('PASAS','Axilleas',4,'oyuiyuftyfygihjp',26,'Normal','HRAKLHS'),
('LASKARHS','Axilleas',0,'oijhugyftdfugiojkhhbu',20,'Normal','HRAKLHS'),
('MPIKIARHS','Axilleas',2,'fugiuojkhvyfugiuhkj',19,'Normal','HRAKLHS'),
('ANTWNIOU','Axilleas',1,'ihguftcyfghoik',22,'Normal','HRAKLHS'),
('DOUMTSIOS','Zeus',0,'pouiyt7fr6d5rcfgvbiho',19,'Normal','HRAKLHS'),
('AMARANTIDHS','Zeus',2,'dtcyfugibbij',19,'Normal','HRAKLHS'),
('MONTIERO','Zeus',3,'fyf8iguhoohpjhouivuc',28,'Normal','HRAKLHS'),
('KALFOUTZOS','Zeus',1,'rdctycfuvyiguoho',18,'Normal','HRAKLHS'),
('LEOZINIO','Zeus',0,'fyviygohohphogvibno',31,'Goalkeeper','HRAKLHS');

INSERT INTO Stadium(name,city,capacity)
VALUES ('Spuros_Louhs','Athina',68600),
('Toumpa','Thessalonikh',28200),
('Karaiskakh','Peiraias',33200),
('Panaitwlikou','Agrinio',7527),
('Livadeias','Livadeia',6501),
('Kautanzogleio','Thessalonikh',27775);

INSERT INTO Fan(id_fan,age ,name,lastname,team,reneawl)
VALUES (NULL,25,'Savvas','Skoulidhs','AEK','10'),
(NULL,17,'Vagia','Tourlida','LEVADEIAKOS','10'),
(NULL,20,'Vasilhs','Tsalafos','PAOK','10'),
(NULL,19,'Panos','Kouridhs','AEK','10'),
(NULL,45,'Manos','Gianakas','OLYMPIAKOS','10'),
(NULL,46,'Giwrgos','Toulas','PAOK','00'),
(NULL,54,'Andreas','Souleles','AEK','10'),
(NULL,43,'Giwrgos','Skandalos','PAOK','00'),
(NULL,16,'Giannhs','Papantwniou','PANAITWLIKOS','10'),
(NULL,28,'Giwrgos','Vasileiou','OLYMPIAKOS','00'),
(NULL,36,'Basilhs','Ntallas','LEVADEIAKOS','10'),
(NULL,93,'Hraklhs','Arguros','PAOK','10'),
(NULL,34,'Hlias','Koufos','PANAITWLIKOS','00'),
(NULL,26,'Spuros','Kantanhs','LEVADEIAKOS','00'),
(NULL,71,'Iwannhs','Mpanias','OLYMPIAKOS','00'),
(NULL,38,'Kwstas','Sbarnias','PANAITWLIKOS','10'),
(NULL,38,'Xarhs','Laedhs','HRAKLHS','10'),
(NULL,25,'Giwrgos','Prwtogeros','PANAITWLIKOS','10'),
(NULL,37,'Nickos','Tsampas','PANAITWLIKOS','10'),
(NULL,14,'Dimitris','Xarir','LEVADEIAKOS','00'),
(NULL,26,'Nickos','Kitsios','AEK','00'),
(NULL,37,'Li','Mplikas','PANAITWLIKOS','00'),
(NULL,36,'Giannhs','Ntovas','OLYMPIAKOS','00');




INSERT INTO Refee(id_refee,name,lastname,age,position)
     VALUES(NULL,'Chris','Papas',26,'Fourth'),
     (NULL,'Nick','nikakis',25,'Fourth'),
     (NULL,'George','Papadakis',25,'Fourth'),
     (NULL,'Kwstas','Triantis',29 ,'Observer'),
     (NULL,'Savvas','Skoultidhs',29,'Observer'),
     (NULL,'Vasilhs','Tsalafos',26,'Fourth'),
     (NULL,'Viviano','Tsaknhs',27,'Main'),
     (NULL,'Nikos','Ntovas',26,'Main'),
     (NULL,'George','Samaras',25,'Supervisor'),
     (NULL,'Lakhs','Tikem',26,'Supervisor'),
     (NULL,'Nick','Papas',26,'Fourth'),
     (NULL,'Chris','nikakis',25,'Fourth'),
     (NULL,'Kwstas','Papadakis',25,'Fourth'),
     (NULL,'George','Triantis',29 ,'Observer'),
     (NULL,'Vasilhs','Skoultidhs',29,'Observer'),
     (NULL,'Savvas','Tsalafos',26,'Fourth'),
     (NULL,'Luchiano','Tsaknhs',27,'Main'),
     (NULL,'Alex','Ntovas',26,'Main'),
     (NULL,'Chris','Samaras',25,'Supervisor'),
     (NULL,'Leo','Tikem',26,'Supervisor'),
     (NULL,'Chris','Nikakis',26,'Fourth'),
     (NULL,'Nick','Papas',25,'Fourth'),
     (NULL,'George','Triantis',25,'Main'),
     (NULL,'Kwstas','Xrhstou',29 ,'Observer'),
     (NULL,'Savvas','Skoulidhs',29,'Supervisor'),
     (NULL,'Vasilhs','Tsaknhs',26,'Supervisor'),
     (NULL,'Viviano','Tsalafos',27,'Main'),
     (NULL,'Nikos','Nto',26,'Main'),
     (NULL,'George','Sama',25,'Supervisor'),
     (NULL,'Lakhs','Tickem',26,'Supervisor'),
     (NULL,'Nick','Papadopoulos',26,'Supervisor'),
     (NULL,'Chris','Xrhstou',25,'Main'),
     (NULL,'Kwstas','Papas',25,'Observer'),
     (NULL,'George','Triantas',29 ,'Observer'),
     (NULL,'Vasilhs','Skoulhs',29,'Observer'),
     (NULL,'Savvas','Tsalas',26,'Fourth'),
     (NULL,'Luchiano','Tsamhs',27,'Main'),
     (NULL,'Alex','Nton',26,'Main'),
     (NULL,'Chris','Tsonis',25,'Supervisor'),
     (NULL,'Nick','Colucci',26,'Supervisor'),
     (NULL,'Leo','Papadopoulos',26,'Supervisor'),
     (NULL,'Kwstas','Xrhstou',25,'Supervisor'),
     (NULL,'George','Papas',25,'Supervisor'),
     (NULL,'Chris','Triantas',29 ,'Supervisor'),
     (NULL,'Bill','Skoulhs',29,'Supervisor'),
     (NULL,'Luchiano','Tsalas',26,'Supervisor'),
     (NULL,'Savvas','Tsamhs',27,'Supervisor'),
     (NULL,'Leo','Nton',26,'Supervisor'),
     (NULL,'George','Tsonis',25,'Supervisor'),
     (NULL,'Nick','Colucci',26,'Supervisor');
INSERT INTO Game(game_id,time,date,result,score1,description,stadium,refee,grounded,guest)
VALUES (NULL,'21:00:00','2016-01-26','Grounded_Win','2-0','dxyfvibibohwobidi','Karaiskakh',5001,'OLYMPIAKOS','AEK'),
(NULL,'21:00:00','2016-01-15','Grounded_Win','2-0','dxyfvibibohwobidi','Karaiskakh',5004,'OLYMPIAKOS','AEK'),
(NULL,'21:00:00','2016-01-17','Grounded_Win','2-0','dxyfvibibohwobidi','Karaiskakh',5007,'OLYMPIAKOS','AEK'),
(NULL,'21:00:00','2016-01-19','Grounded_Win','2-0','dxyfvibibohwobidi','Karaiskakh',5009,'OLYMPIAKOS','AEK'),
(NULL,'21:00:00','2016-01-22','Grounded_Win','2-0','dxyfvibibohwobidi','Karaiskakh',5010,'OLYMPIAKOS','AEK'),



(NULL,'21:00:00','2016-01-05','Draw','1-1','gfchgyjhukjil','Toumpa',5002,'PAOK','HRAKLHS'),
(NULL,'21:00:00','2016-01-07','Draw','1-1','gfchgyjhukjil','Toumpa',5008,'PAOK','HRAKLHS'),
(NULL,'21:00:00','2016-01-09','Draw','1-1','gfchgyjhukjil','Toumpa',5005,'PAOK','HRAKLHS'),
(NULL,'21:00:00','2016-01-12','Draw','1-1','gfchgyjhukjil','Toumpa',5019,'PAOK','HRAKLHS'),
(NULL,'21:00:00','2016-01-16','Draw','1-1','gfchgyjhukjil','Toumpa',5020,'PAOK','HRAKLHS'),

(NULL,'20:00:00','2016-02-02','Grounded_Lose','1-2','vubgihoihjpih0uhg9y','Livadeias',5003,'LEVADEIAKOS','PANAITWLIKOS'),(NULL,'20:00:00','2016-02-04','Grounded_Lose','1-2','vubgihoihjpih0uhg9y','Livadeias',5017,'LEVADEIAKOS','PANAITWLIKOS'),
(NULL,'20:00:00','2016-02-06','Grounded_Lose','1-2','vubgihoihjpih0uhg9y','Livadeias',5014,'LEVADEIAKOS','PANAITWLIKOS'),
(NULL,'20:00:00','2016-02-07','Grounded_Lose','1-2','vubgihoihjpih0uhg9y','Livadeias',5025,'LEVADEIAKOS','PANAITWLIKOS'),
(NULL,'20:00:00','2016-02-08','Grounded_Lose','1-2','vubgihoihjpih0uhg9y','Livadeias',5026,'LEVADEIAKOS','PANAITWLIKOS'),


(NULL,'16:00:00','2016-01-05','Grounded_Win','3-0','auigh0ouhpi9oguvibih','Spuros_Louhs',5006,'HRAKLHS','PANAITWLIKOS'),
(NULL,'16:00:00','2016-01-06','Grounded_Win','3-0','auigh0ouhpi9oguvibih','Spuros_Louhs',5018,'HRAKLHS','PANAITWLIKOS'),
(NULL,'16:00:00','2016-01-07','Grounded_Win','3-0','auigh0ouhpi9oguvibih','Spuros_Louhs',5015,'HRAKLHS','PANAITWLIKOS'),
(NULL,'16:00:00','2016-01-09','Grounded_Win','3-0','auigh0ouhpi9oguvibih','Spuros_Louhs',5029,'HRAKLHS','PANAITWLIKOS'),
(NULL,'16:00:00','2016-01-15','Grounded_Win','3-0','auigh0ouhpi9oguvibih','Spuros_Louhs',5030,'HRAKLHS','PANAITWLIKOS'),

(NULL,'21:00:00','2016-02-05','Grounded_Win','2-1','hiuhhu00ihj0ijh0ihj','Kautanzogleio',5011,'AEK','HRAKLHS'),
(NULL,'21:00:00','2016-02-06','Grounded_Win','2-1','hiuhhu00ihj0ijh0ihj','Kautanzogleio',5027,'AEK','HRAKLHS'),
(NULL,'21:00:00','2016-02-07','Grounded_Win','2-1','hiuhhu00ihj0ijh0ihj','Kautanzogleio',5020,'AEK','HRAKLHS'),
(NULL,'21:00:00','2016-02-08','Grounded_Win','2-1','hiuhhu00ihj0ijh0ihj','Kautanzogleio',5039,'AEK','HRAKLHS'),
(NULL,'21:00:00','2016-02-09','Grounded_Win','2-1','hiuhhu00ihj0ijh0ihj','Kautanzogleio',5040,'AEK','HRAKLHS'),

(NULL,'20:30:00','2016-02-08','Grounded_Lose','1-2','HGVUYVIUGBIbvuiwediu','Toumpa',5012,'PAOK','LEVADEIAKOS'),
(NULL,'20:30:00','2016-02-10','Grounded_Lose','1-2','HGVUYVIUGBIbvuiwediu','Toumpa',5028,'PAOK','LEVADEIAKOS'),
(NULL,'20:30:00','2016-02-11','Grounded_Lose','1-2','HGVUYVIUGBIbvuiwediu','Toumpa',5021,'PAOK','LEVADEIAKOS'),
(NULL,'20:30:00','2016-02-12','Grounded_Lose','1-2','HGVUYVIUGBIbvuiwediu','Toumpa',5041,'PAOK','LEVADEIAKOS'),
(NULL,'20:30:00','2016-02-18','Grounded_Lose','1-2','HGVUYVIUGBIbvuiwediu','Toumpa',5042,'PAOK','LEVADEIAKOS'),

(NULL,'16:30:00','2016-01-23','Grounded_Win','2-0','fcsydcvuveidbobo','Panaitwlikou',5013,'PANAITWLIKOS','AEK'),
(NULL,'16:30:00','2016-01-24','Grounded_Win','2-0','fcsydcvuveidbobo','Panaitwlikou',5037,'PANAITWLIKOS','AEK'),
(NULL,'16:30:00','2016-01-26','Grounded_Win','2-0','fcsydcvuveidbobo','Panaitwlikou',5024,'PANAITWLIKOS','AEK'),
(NULL,'16:30:00','2016-01-28','Grounded_Win','2-0','fcsydcvuveidbobo','Panaitwlikou',5043,'PANAITWLIKOS','AEK'),
(NULL,'16:30:00','2016-01-29','Grounded_Win','2-0','fcsydcvuveidbobo','Panaitwlikou',5044,'PANAITWLIKOS','AEK'),

(NULL,'22:30:00','2016-03-04','Draw','1-1','gfchgyjhukjil','Toumpa',5016,'PAOK','LEVADEIAKOS'),
(NULL,'22:30:00','2016-03-06','Draw','1-1','gfchgyjhukjil','Toumpa',5038,'PAOK','LEVADEIAKOS'),
(NULL,'22:30:00','2016-03-08','Draw','1-1','gfchgyjhukjil','Toumpa',5034,'PAOK','LEVADEIAKOS'),
(NULL,'22:30:00','2016-03-09','Draw','1-1','gfchgyjhukjil','Toumpa',5045,'PAOK','LEVADEIAKOS'),
(NULL,'22:30:00','2016-03-12','Draw','1-1','gfchgyjhukjil','Toumpa',5046,'PAOK','LEVADEIAKOS'),

(NULL,'21:00:00','2016-03-10','Grounded_Win','2-1','hiuhhu00ihj0ijh0ihj','Livadeias',5021,'LEVADEIAKOS','AEK'),
(NULL,'21:00:00','2016-03-12','Grounded_Win','2-1','hiuhhu00ihj0ijh0ihj','Livadeias',5023,'LEVADEIAKOS','AEK'),
(NULL,'21:00:00','2016-03-14','Grounded_Win','2-1','hiuhhu00ihj0ijh0ihj','Livadeias',5035,'LEVADEIAKOS','AEK'),
(NULL,'21:00:00','2016-03-15','Grounded_Win','2-1','hiuhhu00ihj0ijh0ihj','Livadeias',5047,'LEVADEIAKOS','AEK'),
(NULL,'21:00:00','2016-03-19','Grounded_Win','2-1','hiuhhu00ihj0ijh0ihj','Livadeias',5048,'LEVADEIAKOS','AEK');

/*(NULL,'21:30:00','2016-02-05','Grounded_Win','3-1','hERuhhohoioweh0ihj','Spuros_Louhs',22)(NULL,'21:30:00','2016-02-05','Grounded_Win','3-1','hERuhhohoioweh0ihj','Spuros_Louhs',32)
(NULL,'21:30:00','2016-02-05','Grounded_Win','3-1','hERuhhohoioweh0ihj','Spuros_Louhs',33)
(NULL,'21:30:00','2016-02-05','Grounded_Win','3-1','hERuhhohoioweh0ihj','Spuros_Louhs',49)
(NULL,'21:30:00','2016-02-05','Grounded_Win','3-1','hERuhhohoioweh0ihj','Spuros_Louhs',50);*/

INSERT INTO Chairman(id_chair,team,age,name,lastname,bio)
VALUES(NULL,'HRAKLHS',50,'Sakhs','PAPATHANASLAAKHS','xaxa1'),(NULL,'AEK',47,'Vasilhs','ASLANIDHS','xaxa2'),(NULL,'LEVADEIAKOS',53,'Andreas','ROUSARHS','xaxa3'),(NULL,'OLYMPIAKOS',57,'Vasilakis','MARINAKHS','xaxa4'),(NULL,'PANAITWLIKOS',54,'Fwths','KWSTOULAS','xaxa5'),(NULL,'PAOK',39,'Voulh','IVITS','xaxa6');


INSERT INTO Ticket(code,team_tick,game,kind,price)
VALUES(NULL,'LEVADEIAKOS',6000,'Simple','10'),
(NULL,'LEVADEIAKOS',6000,'Simple','10'),
(NULL,'LEVADEIAKOS',6000,'Simple','10'),
(NULL,'HRAKLHS',6001,'Simple','10'),
(NULL,'LEVADEIAKOS',6000,'Continuous','200'),
(NULL,'HRAKLHS',6001,'Continuous','200'),
(NULL,'HRAKLHS',6001,'Continuous','200'),
(NULL,'LEVADEIAKOS',6002,'Continuous','200'),
(NULL,'PAOK',6002,'Simple','10'),
(NULL,'PAOK',6002,'Simple','10'),
(NULL,'PAOK',6002,'Simple','10'),
(NULL,'AEK',6003,'Simple','10'),
(NULL,'AEK',6003,'Simple','10'),
(NULL,'AEK',6003,'Continuous','200'),
(NULL,'PAOK',6003,'Simple','10'),
(NULL,'PAOK',6003,'Continuous','200'),
(NULL,'PAOK',6003,'Continuous','200'),
(NULL,'PAOK',6003,'Continuous','200'),
(NULL,'PAOK',6003,'Continuous','200'),
(NULL,'PAOK',6003,'Continuous','200'),
(NULL,'PANAITWLIKOS',6004,'Simple','10'),
(NULL,'PANAITWLIKOS',6004,'Simple','10'),
(NULL,'PANAITWLIKOS',6004,'Simple','10'),
(NULL,'PANAITWLIKOS',6004,'Simple','10'),
(NULL,'PANAITWLIKOS',6004,'Continuous','200'),
(NULL,'PANAITWLIKOS',6004,'Continuous','200'),
(NULL,'PANAITWLIKOS',6004,'Continuous','200'),
(NULL,'OLYMPIAKOS',6004,'Simple','10'),
(NULL,'OLYMPIAKOS',6004,'Simple','10'),
(NULL,'OLYMPIAKOS',6004,'Continuous','200'),
(NULL,'OLYMPIAKOS',6004,'Continuous','200'),
(NULL,'LEVADEIAKOS',6005,'Simple','10'),
(NULL,'LEVADEIAKOS',6005,'Simple','10'),
(NULL,'LEVADEIAKOS',6005,'Simple','10'),
(NULL,'HRAKLHS',6005,'Simple','10'),
(NULL,'LEVADEIAKOS',6005,'Continuous','200'),
(NULL,'HRAKLHS',6005,'Continuous','200'),
(NULL,'HRAKLHS',6005,'Continuous','200'),
(NULL,'LEVADEIAKOS',6005,'Continuous','200'),
(NULL,'PAOK',6006,'Simple','10'),
(NULL,'PAOK',6006,'Simple','10'),
(NULL,'PAOK',6006,'Simple','10'),
(NULL,'AEK',6006,'Simple','10'),
(NULL,'AEK',6006,'Simple','10'),
(NULL,'AEK',6006,'Continuous','200'),
(NULL,'PAOK',6006,'Simple','10'),
(NULL,'PAOK',6006,'Continuous','200'),
(NULL,'PAOK',6006,'Continuous','200'),
(NULL,'PAOK',6006,'Continuous','200'),
(NULL,'PAOK',6006,'Continuous','200'),
(NULL,'PAOK',6006,'Continuous','200'),
(NULL,'PANAITWLIKOS',6007,'Simple','10'),
(NULL,'PANAITWLIKOS',6007,'Simple','10'),
(NULL,'PANAITWLIKOS',6007,'Simple','10'),
(NULL,'PANAITWLIKOS',6007,'Simple','10'),
(NULL,'PANAITWLIKOS',6007,'Continuous','200'),
(NULL,'PANAITWLIKOS',6007,'Continuous','200'),
(NULL,'PANAITWLIKOS',6007,'Continuous','200'),
(NULL,'OLYMPIAKOS',6007,'Simple','10'),
(NULL,'OLYMPIAKOS',6007,'Simple','10'),
(NULL,'OLYMPIAKOS',6007,'Continuous','200'),
(NULL,'OLYMPIAKOS',6007,'Continuous','200');

INSERT INTO Purchased(ticket_code,fan_id)
VALUES(5,2001),
(6,2002),
(8,2003),
(14,2004),
(15,2005),
(21,2005),
(26,2006),
(27,2008),
(28,2009),
(29,2009),
(30,2010),
(31,2011),
(32,2012),
(33,2013),
(34,2014),
(35,2014),
(36,2015),
(37,2016),
(38,2017),
(39,2018),
(40,2020),
(41,2020),
(42,2020),
(43,2021),
(60,2022),
(62,2000);

INSERT INTO Nickname(nickname,id_chairman)
VALUES('Big Daddy XI',3001),
('Little Potato',3002),
('OUNKS',3003),
('Papatrexas',3004),
('DOUKI',3005),
('Tsiou',3005),
('tufwnas',3002);


 INSERT INTO Coach(id_coach,name,lastname,age,wins,loses,draws,teams_coach,bio,team)
     VALUES(NULL,'Zack','MORAIS',51,23,11,6,'OLUMPIAKOS,PANETOLIKOS','DSAHDGSAHGDH','HRAKLHS'),
     (NULL,'Iwannhs','SAVVIDIS',45,13,16,3,'LEVADIAKOS,PANATHINAIKOS','XAXDASD','LEVADEIAKOS'),
     (NULL,'Labros','MPENTO',47,17,13,6,'HRAKLHS,ARHS','SADJHSJA','OLYMPIAKOS'),
     (NULL,'Gewrgios','MATZOURAKHS',68,21,7,2,'ERMHS','DASDHSAJ','PAOK'),
     (NULL,'Giannhs','XRISTOPOULOS',44,19,13,3,'ASTERAS TRIPOLHS','SADJHAS','PANAITWLIKOS'),
     (NULL,'Sakhs','PANTELIDHS',51,12,9,2,'DOKSA','AASD','AEK');
INSERT INTO Admires(player,fan)
VALUES(1022,2001),
(1023,2018),
(1024,2003),
(1025,2004),
(1026,2005),
(1027,2006),
(1028,2007),
(1029,2008),
(1030,2009),
(1031,2010),
(1032,2011),
(1033,2012),
(1034,2013),
(1035,2014),
(1036,2015),
(1037,2016),
(1038,2017);


INSERT INTO Grounded(team,stadium)
VALUES('OLYMPIAKOS','Karaiskakh'),
('HRAKLHS','Spuros_Louhs'),
('LEVADEIAKOS','Livadeias'),
('PANAITWLIKOS','Panaitwlikou'),
('AEK','Kautanzogleio'),
('PAOK','Toumpa');

INSERT INTO Use_Premium(game,fan)
VALUES(6001,2000),
(6010,2001),
(6001,2002),
(6001,2006),
(6011,2001),
(6002,2002),
(6002,2003),
(6002,2004),
(6002,2005),
(6002,2006),
(6012,2001),
(6003,2002),
(6003,2003),
(6003,2004),
(6003,2005),
(6003,2006),
(6003,2007),
(6003,2008),
(6013,2001),
(6004,2002),
(6004,2003),
(6004,2004),
(6004,2005),
(6004,2006),
(6004,2007),
(6004,2008),
(6005,2000),
(6014,2001);


/*INSERT INTO Supervisor(ref1_id,pos1)
VALUES(1,'Supervisor'),
(8,'Supervisor');

INSERT INTO Participated(supervisor,game)
VALUES(1,1),
(8,1),
(1,2),
(8,2),
(1,3),
(8,3),
(1,4),
(8,4),
(1,5),
(8,5),
(1,6),
(8,6),
(1,7),
(8,7),
(1,8),
(8,8),
(1,9),
(8,9),
(1,10),
(8,10);
*/


/*1*/
DELIMITER $
CREATE PROCEDURE best_bios()
BEGIN 
SELECT Chairman.name AS best_Team_chairman_name,Chairman.lastname AS best_Team_chairman_lastname,Chairman.bio AS best_Team_chairman_bio FROM Chairman INNER JOIN Team ON Team.name=Chairman.team WHERE wins=(SELECT MAX(wins) FROM Team);
SELECT Coach.name AS best_Team_Coach_name,Coach.lastname AS best_Team_Coach_lastname,Coach.bio AS best_Team_Coach_bio FROM Coach INNER JOIN Team ON Team.name=Coach.team WHERE Team.wins=(SELECT MAX(wins) FROM Team);
END $ 
DELIMITER ;


/*2*/
DELIMITER $
CREATE PROCEDURE best_scorer()
BEGIN 
DECLARE pl_name VARCHAR(25);
DECLARE pl_lastname VARCHAR(25);
DECLARE pl_goals INT(9);
DECLARE sub INT(9);
DECLARE finishedFlag INT;
DECLARE i INT;
DECLARE ScorrerCursor CURSOR FOR 
SELECT name,lastname,goals FROM Player ORDER BY goals DESC LIMIT 2;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET finishedFlag=1;
OPEN ScorrerCursor;
SET finishedFlag=0;
SET sub=0; 
SET i=0;
FETCH ScorrerCursor INTO  pl_name,pl_lastname,pl_goals;
SET sub=pl_goals;
REPEAT
FETCH ScorrerCursor INTO  pl_name,pl_lastname,pl_goals;
IF (finishedFlag=0) THEN
SET sub=sub-pl_goals;
END IF;
UNTIL (finishedFlag=1)
END REPEAT;
CLOSE ScorrerCursor;
OPEN ScorrerCursor;
FETCH ScorrerCursor INTO  pl_name,pl_lastname,pl_goals;
SELECT pl_name AS 'Best_Scorer_name', pl_lastname AS 'Best_Scorer_lastname',pl_goals AS 'GOALS',sub AS 'sub_from_second';
CLOSE ScorrerCursor;
END $
DELIMITER ;

/*3*/

DELIMITER $
CREATE PROCEDURE best_player()
BEGIN
SELECT team,count(*) AS c FROM Player GROUP BY team  ; /*vriskei to plhthos twn paiktwn se kathe omada*/ 
/*kserwdas to plhthos kathe omadas mporw na emfanisw ta adistoixa onomata */

SELECT Player.name,Player.lastname,Player.goals,Player.team FROM Player ORDER BY  Player.team,Player.goals DESC LIMIT 3;
SELECT Player.name,Player.lastname,Player.goals,Player.team FROM Player GROUP BY id_play,team ORDER BY  team,goals DESC LIMIT 3 OFFSET 18;
SELECT Player.name,Player.lastname,Player.goals,Player.team FROM Player GROUP BY id_play,team ORDER BY  team,goals DESC LIMIT 3 OFFSET 33;
SELECT Player.name,Player.lastname,Player.goals,Player.team FROM Player GROUP BY id_play,team ORDER BY  team,goals DESC LIMIT 3 OFFSET 47;
SELECT Player.name,Player.lastname,Player.goals,Player.team FROM Player GROUP BY id_play,team ORDER BY  team,goals DESC LIMIT 3 OFFSET 59;
SELECT Player.name,Player.lastname,Player.goals,Player.team FROM Player GROUP BY id_play,team ORDER BY  team,goals DESC LIMIT 3 OFFSET 71;
/*plhthos fulathwn pou thaumazoun paixtes se mia omada */
SELECT Player.team,count(*) as fans_of_teams FROM Player INNER JOIN Admires ON Player.id_play=Admires.player INNER JOIN Fan ON Admires.fan=Fan.id_fan GROUP BY Player.team ORDER BY  Player.team DESC;
/*analoga me auto ftiaxnw kai katallhlees select*/

SELECT Player.name AS Player_name,Player.lastname AS Player_lastname,Player.goals AS Player_goals,Player.team,Fan.name AS Fan_name,Fan.lastname AS Fan_lastname FROM Player INNER JOIN Admires ON Player.id_play=Admires.player INNER JOIN Fan ON Admires.fan=Fan.id_fan GROUP BY Player.team,Player.name,Player.lastname,Player.goals,Fan.name,Fan.lastname ORDER BY  Player.team,Player.goals DESC LIMIT 3 ;

SELECT Player.name AS Player_name,Player.lastname AS Player_lastname,Player.goals AS Player_goals,Player.team,Fan.name AS Fan_name,Fan.lastname AS Fan_lastname FROM Player INNER JOIN Admires ON Player.id_play=Admires.player INNER JOIN Fan ON Admires.fan=Fan.id_fan GROUP BY Player.team,Player.name,Player.lastname,Player.goals,Fan.name,Fan.lastname ORDER BY  Player.team,Player.goals DESC LIMIT 3 OFFSET 10;

END$
DELIMITER ;



/*4*/

DELIMITER $
CREATE PROCEDURE selled_continuous_tickets()
BEGIN
/*plhthos eishthriwn diarkeias gia kathe omada*/
SELECT Ticket.team_tick,count(*) AS c  FROM Ticket WHERE Ticket.kind LIKE'%CONTINUOUS%' GROUP BY team_tick ORDER BY  c DESC ;

/*onomata twn fulathwn pou ta exoun agorasei*/

SELECT Fan.name,Fan.lastname,Ticket.team_tick FROM Fan INNER JOIN Purchased ON Purchased.fan_id=Fan.id_fan INNER JOIN Ticket ON Ticket.code=Purchased.ticket_code  WHERE Ticket.kind LIKE'CONTINUOUS';
END $
DELIMITER ;


/*6*/
DELIMITER $
CREATE PROCEDURE best_team()
BEGIN
SELECT Team.name AS best_team,Coach.name AS Coach_name,Coach.lastname AS Coach_lastname,Chairman.name AS Chairman_name,Chairman.lastname Chairman_lastname,Grounded.stadium,Team.goals_out-goals_in AS result FROM Coach INNER JOIN Team ON Coach.team=Team.name INNER JOIN Chairman ON Chairman.team=Team.name INNER JOIN Grounded ON Grounded.team=Team.name WHERE Team.goals_out-goals_in=(SELECT MAX(goals_out-goals_in) FROM Team);
END$
DELIMITER ;


CALL best_team();
CALL  selled_continuous_tickets();
CALL best_scorer();
CALL best_bios();
CALL best_player();


/***************======GRAPHIS_FAN======**************************/
SELECT Fan.id_fan,Fan.name,Fan.lastname,Fan.team,Game.game_id,Game.date,Game.score1,Game.result, Ticket.kind FROM Game INNER JOIN USED_TICKETS ON Game.game_id=USED_TICKETS.game INNER JOIN Fan ON Fan.id_fan=USED_TICKETS.fan INNER JOIN Purchased ON Purchased.fan_id=Fan.id_fan INNER JOIN Ticket ON Ticket.code=Purchased.ticket_code;


/*******return FAN favourite team and the sub between goals_in-goals_out******/


SELECT Fan.id_fan,Fan.name AS Fan_name,Fan.lastname AS Fan_name_lastname,Fan.team AS Fan_favourite_team,Team.goals_in-goals_out  AS fav_team_sub FROM Fan INNER JOIN Team ON Team.name=Fan.team;
/*************************************************************************************************************/


/*********************return the goals of every fan favourite player***********/

SELECT Fan.id_fan,Fan.name AS Fan_name,Fan.lastname AS Fan_name_lastname,Player.goals AS fav_player_goals FROM Fan INNER JOIN Admires ON Admires.fan=Fan.id_fan
INNER JOIN Player ON Player.id_play=Admires.player;

/*************************************************************************************************/




/************************available seats for continuous_tickets_fans*****************************/

/*DELIMITER $
CREATE PROCEDURE available_seats()
BEGIN
/********* return all fans with continuous tickets*******/
/*SELECT Fan.name,Fan.lastname,Ticket.kind FROM Fan INNER JOIN Purchased ON Fan.id_fan=Purchased.fan_id INNER JOIN Ticket ON Ticket.code=Purchased.ticket_code WHERE Ticket.kind LIKE'CONTINUOUS' INNER JOIN USED_TICKETS ON USED_TICKETS.fan=Fan.id_fan;


END $
DELIMITER;


/***********************************************************************************************/


/*

//fan

SELECT COUNT(1) FROM Purchased
INNER JOIN Ticket ON Purchased.ticket_code=Ticket.code
INNER JOIN Team ON Ticket.team_tick=Team.name
WHERE Team.name='PAOK'


SELECT useNumber 
FROM Use_Premium 
INNER JOIN Ticket ON Use_Premium.ticket_id=Ticket.code 
INNER JOIN Game ON Game.game_id=Ticket.game 
WHERE Game.game_id=6001 
*/




