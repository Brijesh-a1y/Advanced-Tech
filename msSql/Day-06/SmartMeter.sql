-- Database: SmartMeter

DROP DATABASE IF EXISTS "SmartMeter";


create database SmartMeter
owner=esyasoft
template=template0
encoding='UTF8'
lc_collate='en_US_utf8'
lc_ctype='en_US_utf8'


-- CREATE TABLE [User](  
--   UserId         BIGINT IDENTITY PRIMARY KEY,  
--   Username       NVARCHAR(100) NOT NULL UNIQUE,  
--   PasswordHash   VARBINARY(256) NOT NULL,  
--   DisplayName    NVARCHAR(150) NOT NULL,  
--   Email          NVARCHAR(200) NULL,  
--   Phone          NVARCHAR(30) NULL,  
--   LastLoginUtc   DATETIME2(3) NULL,  
--   IsActive       BIT NOT NULL DEFAULT 1);

CREATE TABLE "User"(
  UserId         BIGSERIAL PRIMARY KEY,
  Username       VARCHAR(100) NOT NULL UNIQUE,
  PasswordHash   BYTEA NOT NULL,
  DisplayName    VARCHAR(150) NOT NULL,
  Email          VARCHAR(200) NULL,
  Phone          VARCHAR(30) NULL,
  LastLoginUtc   TIMESTAMPTZ NULL,
  IsActive       BOOLEAN NOT NULL DEFAULT true
);

CREATE TABLE OrgUnit(
    OrgUnitId SERIAL PRIMARY KEY,
    Type VARCHAR(20) NOT NULL CHECK (Type IN ('Zone','Substation','Feeder','DTR')),
    Name VARCHAR(100) NOT NULL,
    ParentId INT NULL REFERENCES OrgUnit(OrgUnitId)
);

CREATE TABLE Tariff (
    TariffId SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    EffectiveFrom DATE NOT NULL,
    EffectiveTo DATE NULL,
    BaseRate NUMERIC(18,4) NOT NULL,
    TaxRate NUMERIC(18,4) NOT NULL DEFAULT 0,
	constraints CK_Tariff check(EffectiveFrom<EffectiveTo and BaseRate>0)
);
select * from Tariff

alter table Tariff
drop constraint CK_Tariff

drop table Tariff
delete from Tariff

CREATE TABLE TodRule (
    TodRuleId      SERIAL PRIMARY KEY,
    TariffId       INT NOT NULL REFERENCES Tariff(TariffId),
    Name           VARCHAR(50) NOT NULL,
    StartTime      TIME(0) NOT NULL,
    EndTime        TIME(0) NOT NULL,
    RatePerKwh     NUMERIC(18,6) NOT NULL,
	constraints CK_TodRule check(EndTime>StartTime and RatePerKwh>0)
);

CREATE TABLE TariffSlab (
    TariffSlabId   SERIAL PRIMARY KEY,
    TariffId       INT NOT NULL REFERENCES Tariff(TariffId),
    FromKwh        DECIMAL(18,6) NOT NULL,
    ToKwh          DECIMAL(18,6) NOT NULL,
    RatePerKwh     DECIMAL(18,6) NOT NULL,
    CONSTRAINT CK_TariffSlab CHECK (FromKwh >= 0 AND ToKwh > FromKwh and RatePerKwh>0)
);


CREATE TABLE Arrears(
    AId SERIAL PRIMARY KEY,
    ConsumerId INT NOT NULL,
    AType VARCHAR(50) NOT NULL,
    PaidStatus VARCHAR(50) NOT NULL,
    BId INT NULL references Bill(BId)
);

CREATE TABLE TariffDetails(
    TariffDetailsId SERIAL PRIMARY KEY,
    TariffId INT NOT NULL references Tariff(TariffId),
    TariffSlabId INT NULL references TariffSlab(TariffSlabId),
    TodRuleId INT NULL references TodRule(TodRuleId)
);

CREATE TABLE Bill(
    BId SERIAL PRIMARY KEY,
    BillDate DATE NOT NULL,
    BillAmount DECIMAL(18,2) NOT NULL,
    MeterId INT NOT NULL,
    TariffDetailsId INT NOT NULL references TariffDetails(TariffDetailsId),
    CreatedDate DATE NOT NULL,
    PaymentDate DATE NULL,
    DueDate DATE NOT NULL,
    CreatedBy INT NOT NULL,
    -- PreviousReadingDate DATE NOT NULL,
    -- CurrentReadingDate DATE NOT NULL,
    PreviousReadingKwh DECIMAL(18,2) NOT NULL,
    CurrentReadingKwh DECIMAL(18,2) NOT NULL,
    PowerFactor DECIMAL(5,2) NULL,
    LoadFactor DECIMAL(5,2) NULL,
    DisconnectedDate DATE NULL,
	constraints CK_Bill check(CurrentReadingKwh>PreviousReadingKwh and BillAmount>=0)
	
);

CREATE TABLE Meter (
  MeterSerialNo VARCHAR(50) NOT NULL PRIMARY KEY,
  IpAddress VARCHAR(45) NOT NULL,
  ICCID VARCHAR(30) NOT NULL,
  IMSI VARCHAR(30) NOT NULL,
  Manufacturer VARCHAR(100) NOT NULL,
  Firmware VARCHAR(50) NULL,
  Category VARCHAR(50) NOT NULL,
  InstallTsUtc TIMESTAMPTZ NOT NULL,
  Status VARCHAR(20) NOT NULL DEFAULT 'Active'
           CHECK (Status IN ('Active','Inactive','Decommissioned')),
  ConsumerId BIGINT NULL REFERENCES Consumer(ConsumerId)
);

-- ICCI = Integrated Circuit Card Identifier
-- IMSI =  International Mobile Subscriber Identity


CREATE TABLE Consumer (
  ConsumerId BIGSERIAL PRIMARY KEY,
  Name VARCHAR(200) NOT NULL,
  Address VARCHAR(500) NULL,
  Phone VARCHAR(30) NULL,
  Email VARCHAR(200) NULL,
  OrgUnitId INT NOT NULL REFERENCES OrgUnit(OrgUnitId),
  TariffId INT NOT NULL REFERENCES Tariff(TariffId),
  Status VARCHAR(20) NOT NULL DEFAULT 'Active' CHECK (Status IN ('Active','Inactive')),
  CreatedAt TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  CreatedBy VARCHAR(100) NOT NULL DEFAULT 'system',
  UpdatedAt TIMESTAMPTZ NULL,
  UpdatedBy VARCHAR(100) NULL
  constraints CK_Consumer check(UpdatedAt>CreatedAt)
);

CREATE TABLE MeterDetails(
    MeterDetailId SERIAL PRIMARY KEY,
    MeterReadingDate TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    -- MeterReadingInterval INT NOT NULL, consider the interval [15 minutes]
    EnergyConsumed NUMERIC(18,4) NOT NULL,
    MeterId VARCHAR(50) NOT NULL REFERENCES Meter(MeterSerialNo),
    Current NUMERIC(10,2) NULL,
    Voltage NUMERIC(10,2) NULL
	constraints CK_MeterDetails check(EnergyConsumed>0)
);


select * from "User";
select * from OrgUnit;
