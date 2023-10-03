create database eshop;
use eshop;

create table Uuser(
userid int  NOT NULL PRIMARY KEY, 
nome varchar(20), 
phoneNum char(9)
);

create table store(
sid int NOT NULL PRIMARY KEY, 
nome varchar(20), 
starttime varchar(20), 
customergrade int,
check( customergrade = 1 or customergrade = 2 or customergrade = 3 or customergrade = 4 or customergrade = 5),
streetaddr varchar(40), 
city varchar(30),
province varchar(20)
);

create table oorder(
ordernumber int NOT NULL PRIMARY KEY, 
creationtime datetime, 
paymentstatus varchar(15) NOT NULL,
check(paymentstatus = 'em andamento' or paymentstatus = 'realizado'), 
totalamount float
);

create table brand(
brandname varchar(20) NOT NULL PRIMARY KEY
);

create table servicePoint(
spid int NOT NULL PRIMARY KEY,
streetaddr varchar(40),
city varchar(30),
province varchar(20),
starttime varchar(20),
endtime varchar(20)
);

create table buyer(
fk_userid int  NOT NULL PRIMARY KEY,
foreign key (fk_userid) references Uuser (userid)
);

create table seller(
fk_userid int  NOT NULL PRIMARY KEY,
foreign key (fk_userid) references Uuser (userid)
);
create table credit_card(
cardnumber VARCHAR(25) NOT NULL PRIMARY KEY, 
organizationn varchar(30),
fk_userid int  NOT NULL,
foreign key (fk_userid) references Uuser (userid)
);

create table debit_card(
cardnumber VARCHAR(25) NOT NULL PRIMARY KEY, 
organizationn varchar(30),
fk_userid int  NOT NULL,
foreign key (fk_userid) references Uuser (userid)
);

create table bank_card(
fk_cardnumber VARCHAR(25) NOT NULL PRIMARY KEY,
bank varchar(15), 
expirydate date,
foreign key (fk_cardnumber) references debit_card (cardnumber),
foreign key (fk_cardnumber) references credit_card (cardnumber)
);

create table address(
addrid int NOT NULL PRIMARY KEY, 
fk_userid int NOT NULL, 
nome varchar(20), 
city varchar(30), 
postalcode char(8), 
streetaddr varchar(40), 
province varchar(20), 
contactphonenumber char(8),
foreign key (fk_userid) references Uuser (userid)
);

create table product (
pid int NOT NULL PRIMARY KEY, 
fk_sid int NOT NULL, 
nome varchar(30), 
fk_brand varchar(20) NOT NULL, 
typee varchar(25), 
amount float, 
price float, 
color varchar(15), 
modelnumber int,
foreign key (fk_sid) references store (sid),
foreign key (fk_brand) references brand (brandname)
);

create table comments(
creationtime datetime NOT NULL,
fk_userid int NOT NULL,
fk_pid int NOT NULL,
grade float,
content varchar(500),
constraint pk_comments primary key(creationtime, fk_userid, fk_pid),
foreign key (fk_userid) references Uuser (userid),
foreign key (fk_pid) references product (pid)
);

create table save_to_Shopping_Cart(
fk_userid int NOT NULL,
fk_pid int NOT NULL,
addtime date,
quantity int,
constraint pk_stsc primary key(fk_userid, fk_pid),
foreign key (fk_userid) references Uuser (userid),
foreign key (fk_pid) references product (pid)
);

create table order_item(
itemid int NOT NULL PRIMARY KEY, 
fk_pid int NOT NULL, 
price float, 
creationtime datetime,
foreign key (fk_pid) references product (pid)
);

create table contain(
fk_ordernumber int NOT NULL,
fk_itemid int NOT NULL,
quantity int,
constraint pk_contain primary key(fk_orderNumber, fk_itemid),
foreign key (fk_ordernumber) references oorder (ordernumber),
foreign key (fk_itemid) references order_item (itemid)
);

create table payment(
fk_ordernumber int NOT NULL,
fk_cardnumberr VARCHAR(25) NOT NULL,
payTime date,
constraint pk_payment primary key(fk_ordernumber, fk_cardnumberr),
foreign key (fk_ordernumber) references oorder (ordernumber),
foreign key (fk_cardnumberr) references bank_card (fk_cardnumber)
);

create table deliver_to(
fk_addrid int NOT NULL,
fk_ordernumber int NOT NULL,
timedelivered date,
constraint pk_deliverto primary key(fk_addrid, fk_ordernumber),
foreign key (fk_ordernumber) references oorder (ordernumber),
foreign key (fk_addrid) references address (addrid)
);

create table manage(
fk_userid int  NOT NULL,
fk_sid int NOT NULL,
setuptime date,
constraint pk_manage primary key(fk_userid, fk_sid),
foreign key (fk_userid) references Uuser (userid),
foreign key (fk_sid) references store (sid)
);

create table after_Sales_Service_At( 
fk_brandName varchar(20) NOT NULL,
fk_spid int NOT NULL,
constraint pk_assa primary key(fk_brandName, fk_spid),
foreign key (fk_brandname) references brand (brandname),
foreign key (fk_spid) references servicePoint (spid)
);
