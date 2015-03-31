DROP TABLE DBS2_COORDS CASCADE CONSTRAINTS;
DROP TABLE DBS2_USER CASCADE CONSTRAINTS;
DROP TABLE DBS2_CATEGORY CASCADE CONSTRAINTS;
DROP TABLE DBS2_SUBCATEGORY CASCADE CONSTRAINTS;
DROP TABLE DBS2_ADVERT CASCADE CONSTRAINTS;
DROP TABLE DBS2_SERVICE CASCADE CONSTRAINTS;
DROP TABLE DBS2_GOOD CASCADE CONSTRAINTS;
DROP TABLE DBS2_FAVORITE_ADVERT CASCADE CONSTRAINTS;
DROP TABLE DBS2_OFFER CASCADE CONSTRAINTS;
DROP TABLE DBS2_PHOTO CASCADE CONSTRAINTS;

CREATE TABLE DBS2_COORDS
(
  postalcode VARCHAR2(20) PRIMARY KEY,
  xCoord NUMBER(4,0) NOT NULL,
  yCoord NUMBER(4,0) NOT NULL
);

CREATE TABLE DBS2_USER
(
  userID NUMBER(4,0) PRIMARY KEY,
  username VARCHAR2(20) NOT NULL,
  userPassword VARCHAR2(20) NOT NULL,
  postalcode VARCHAR2(20) NOT NULL,
  email VARCHAR2(100) NOT NULL,
  emailPref NUMBER(1,0) DEFAULT 0,
  paymentPref NUMBER(1,0) DEFAULT 0,
  receiptPref NUMBER(1,0) DEFAULT 0,
  phoneNumber VARCHAR2(20) DEFAULT 'unknown'
);

CREATE TABLE DBS2_CATEGORY
(
  categoryID NUMBER(4,0) PRIMARY KEY,
  categoryName VARCHAR2(20) NOT NULL UNIQUE
);

CREATE TABLE DBS2_SUBCATEGORY
(
  subCategoryID NUMBER(4,0) PRIMARY KEY,
  subcategoryName VARCHAR2(20) NOT NULL UNIQUE,
  categoryID NUMBER(4,0) NOT NULL
);

CREATE TABLE DBS2_ADVERT
(
  advertID NUMBER(4,0) PRIMARY KEY,
  title VARCHAR2(20) NOT NULL,
  creationDate DATE DEFAULT sysdate,
  advertViews NUMBER(4,0) DEFAULT 0,
  serviceOrGoods NUMBER(1,0) NOT NULL,
  userID NUMBER(4,0) NOT NULL
);

CREATE TABLE DBS2_SERVICE
(
  advertID NUMBER(4,0) PRIMARY KEY,
  experience VARCHAR2(20),
  employees NUMBER(4,0),
  companyType VARCHAR2(20)
);

CREATE TABLE DBS2_GOOD
(
  advertID NUMBER(4,0) PRIMARY KEY
);

CREATE TABLE DBS2_FAVORITE_ADVERT
(
  favoriteAdvertID NUMBER(4,0) PRIMARY KEY,
  userID NUMBER(4,0),
  advertID NUMBER(4,0)
);

CREATE TABLE DBS2_OFFER
(
  offerID NUMBER(4,0) PRIMARY KEY,
  userID NUMBER(4,0),
  advertID NUMBER(4,0),
  amount NUMBER(4,2) NOT NULL
);

CREATE TABLE DBS2_PHOTO
(
  fotoID NUMBER(4,0) PRIMARY KEY,
  fotoPad VARCHAR2(20) NOT NULL,
  advertID NUMBER(4,0)
);

ALTER TABLE DBS2_USER
  ADD CONSTRAINT FK_USER_postalcode FOREIGN KEY (postalcode) REFERENCES DBS2_COORDS(postalcode);

ALTER TABLE DBS2_SUBCATEGORY
  ADD CONSTRAINT FK_SUBCATEGORY_categoryID FOREIGN KEY (categoryID) REFERENCES DBS2_CATEGORY(categoryID);
  
ALTER TABLE DBS2_ADVERT
  ADD CONSTRAINT FK_ADVERT_userID FOREIGN KEY (userID) REFERENCES DBS2_USER(userID);

ALTER TABLE DBS2_GOOD
  ADD CONSTRAINT FK_GOOD_advertID FOREIGN KEY (advertID) REFERENCES DBS2_ADVERT(advertID);
  
ALTER TABLE DBS2_FAVORITE_ADVERT
  ADD CONSTRAINT FK_FAVORITE_ADVERT_userID FOREIGN KEY (userID) REFERENCES DBS2_USER(userID);
  
ALTER TABLE DBS2_FAVORITE_ADVERT
  ADD CONSTRAINT FK_FAVORITE_ADVERT_advertID FOREIGN KEY (advertID) REFERENCES DBS2_ADVERT(advertID);

ALTER TABLE DBS2_OFFER
  ADD CONSTRAINT FK_OFFER_userID FOREIGN KEY (userID) REFERENCES DBS2_USER(userID);
  
ALTER TABLE DBS2_OFFER
  ADD CONSTRAINT FK_OFFER_advertID FOREIGN KEY (advertID) REFERENCES DBS2_ADVERT(advertID);

ALTER TABLE DBS2_PHOTO
  ADD CONSTRAINT FK_PHOTO_advertID2 FOREIGN KEY (advertID) REFERENCES ADVERT(advertID);