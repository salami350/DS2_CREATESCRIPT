DROP TABLE DBS2_MARKTUSER CASCADE CONSTRAINTS;
DROP TABLE DBS2_MARKTCATEGORY CASCADE CONSTRAINTS;
DROP TABLE DBS2_SUBCATEGORY CASCADE CONSTRAINTS;
DROP TABLE DBS2_ADVERT CASCADE CONSTRAINTS;
DROP TABLE DBS2_SERVICE CASCADE CONSTRAINTS;
DROP TABLE DBS2_GOOD CASCADE CONSTRAINTS;
DROP TABLE DBS2_FAVORITE_ADVERT CASCADE CONSTRAINTS;
DROP TABLE DBS2_OFFER CASCADE CONSTRAINTS;
DROP TABLE DBS2_PHOTO CASCADE CONSTRAINTS;
DROP TABLE DBS2_COORDS CASCADE CONSTRAINTS;

CREATE TABLE DBS2_COORDS
(
  postalcode VARCHAR2(20) PRIMARY KEY,
  coord VARCHAR2(20) NOT NULL
);

CREATE TABLE DBS2_USER
(
  userID NUMBER(4,0) PRIMARY KEY,
  username VARCHAR2(20) NOT NULL,
  marktPassword VARCHAR2(20) NOT NULL,
  postalcode VARCHAR2(20) NOT NULL,
  email VARCHAR2(20) NOT NULL,
  emailPref NUMBER(1,0) DEFAULT 0,
  paymentPref NUMBER(1,0) DEFAULT 0,
  receiptPref NUMBER(1,0) DEFAULT 0,
  phoneNumber VARCHAR2(20) DEFAULT 'unknown',
  CONSTRAINT FK_MARKTUSER_postalcode FOREIGN KEY (postalcode) REFERENCES COORDS(postalcode)
);

CREATE TABLE DBS2_CATEGORY
(
  categoryID NUMBER(4,0) PRIMARY KEY,
  categoryName VARCHAR2(20) NOT NULL UNIQUE
);

CREATE TABLE SUBCATEGORY
(
subCategoryID NUMBER(4,0) PRIMARY KEY,
marktName VARCHAR2(20) NOT NULL,
categoryID NUMBER(4,0) NOT NULL,
CONSTRAINT FK_marktCategoryID FOREIGN KEY (categoryID) REFERENCES MARKTCATEGORY (marktCategoryID)
);

CREATE TABLE ADVERT
(
advertID NUMBER(4,0) PRIMARY KEY,
title VARCHAR2(20) NOT NULL,
creationDate DATE DEFAULT sysdate,
marktViews NUMBER(4,0) DEFAULT 0,
serviceOrGoods NUMBER(1,0) NOT NULL,
userID NUMBER(4,0) NOT NULL
);

CREATE TABLE SERVICE
(
advertID NUMBER(4,0) PRIMARY KEY,
experience VARCHAR2(20),
employees NUMBER(4,0),
companyType VARCHAR2(20),
CONSTRAINT FK_advertID FOREIGN KEY (advertID) REFERENCES ADVERT(advertID)
);

CREATE TABLE GOOD
(
advertID NUMBER(4,0) PRIMARY KEY,
CONSTRAINT FK_GOODAdvertID FOREIGN KEY (advertID) REFERENCES ADVERT(advertID)
);

CREATE TABLE FAVORITE_ADVERT
(
userID NUMBER(4,0),
advertID NUMBER(4,0),
  CONSTRAINT PK_FAVORITE_ADVERT PRIMARY KEY (userID, advertID),
  CONSTRAINT FK_FAVORITE_ADVERT_userID FOREIGN KEY (userID) REFERENCES MARKTUSER(userID),
  CONSTRAINT FK_FAVORITE_ADVERT_advertID FOREIGN KEY (advertID) REFERENCES ADVERT(advertID)
);

CREATE TABLE OFFER
(
offerID NUMBER(4,0) PRIMARY KEY,
userID NUMBER(4,0),
advertID NUMBER(4,0),
amount NUMBER(4,2) NOT NULL,
CONSTRAINT FK_OFFER_userID FOREIGN KEY (userID) REFERENCES MARKTUSER(userID),
CONSTRAINT FK_ADVER_advertID FOREIGN KEY (advertID) REFERENCES ADVERT(advertID)
);

CREATE TABLE PHOTO
(
fotoID NUMBER(4,0) PRIMARY KEY,
fotoPad VARCHAR2(20) NOT NULL,
advertID NUMBER(4,0),
CONSTRAINT FK_PHOTO_advertID FOREIGN KEY (advertID) REFERENCES ADVERT(advertID)
);