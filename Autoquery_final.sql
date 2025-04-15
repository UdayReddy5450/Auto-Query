
-- Create Database
CREATE DATABASE IF NOT EXISTS AUTOQUERY_DB;
USE AUTOQUERY_DB;

CREATE TABLE Vehicles (
    VehicleID INT AUTO_INCREMENT PRIMARY KEY,
    RegistrationNo VARCHAR(20) UNIQUE NOT NULL,
    VIN VARCHAR(20) UNIQUE NOT NULL,
    Make VARCHAR(50),
    Model VARCHAR(50),
    Year INT,
    Color VARCHAR(20),
    FuelType VARCHAR(20),
    VehicleType VARCHAR(50),
    Status ENUM('Active', 'Suspended', 'Stolen') DEFAULT 'Active'
);


CREATE TABLE Owners (
    OwnerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Address TEXT,
    Phone VARCHAR(15),
    Email VARCHAR(100) UNIQUE,
    LicenseNo VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE Registrations (
    RegID INT AUTO_INCREMENT PRIMARY KEY,
    VehicleID INT,
    OwnerID INT,
    IssueDate DATE,
    ExpiryDate DATE,
    Status ENUM('Active', 'Expired') DEFAULT 'Active',
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID) ON DELETE CASCADE,
    FOREIGN KEY (OwnerID) REFERENCES Owners(OwnerID) ON DELETE CASCADE
);

CREATE TABLE Insurance (
    InsuranceID INT AUTO_INCREMENT PRIMARY KEY,
    VehicleID INT,
    ProviderName VARCHAR(100),
    PolicyNo VARCHAR(50) UNIQUE NOT NULL,
    StartDate DATE,
    ExpiryDate DATE,
    CoverageAmount DECIMAL(10,2),
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID) ON DELETE CASCADE
);

CREATE TABLE Violations (
    ViolationID INT AUTO_INCREMENT PRIMARY KEY,
    VehicleID INT,
    OwnerID INT,
    DateTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ViolationType VARCHAR(100),
    FineAmount DECIMAL(10,2),
    Status ENUM('Paid', 'Unpaid') DEFAULT 'Unpaid',
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID) ON DELETE CASCADE,
    FOREIGN KEY (OwnerID) REFERENCES Owners(OwnerID) ON DELETE CASCADE
);

CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    ViolationID INT,
    Amount DECIMAL(10,2),
    PaymentDate DATE,
    PaymentMethod VARCHAR(50),
    FOREIGN KEY (ViolationID) REFERENCES Violations(ViolationID) ON DELETE CASCADE
);

CREATE TABLE Ownership_History (
    HistoryID INT AUTO_INCREMENT PRIMARY KEY,
    VehicleID INT,
    PreviousOwnerID INT,
    NewOwnerID INT,
    TransferDate DATE,
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID) ON DELETE CASCADE
);

CREATE TABLE Vehicle_Inspection (
    InspectionID INT AUTO_INCREMENT PRIMARY KEY,
    VehicleID INT,
    InspectionDate DATE,
    Result ENUM('Pass', 'Fail'),
    Comments TEXT,
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID) ON DELETE CASCADE
);

CREATE TABLE Tolls (
    TollID INT AUTO_INCREMENT PRIMARY KEY,
    Location VARCHAR(100),
    Fee DECIMAL(10,2)
);

CREATE TABLE Toll_Records (
    RecordID INT AUTO_INCREMENT PRIMARY KEY,
    VehicleID INT,
    TollID INT,
    DateTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID) ON DELETE CASCADE,
    FOREIGN KEY (TollID) REFERENCES Tolls(TollID) ON DELETE CASCADE
);

CREATE TABLE Service_Centers (
    CenterID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Address TEXT,
    Contact VARCHAR(15)
);

CREATE TABLE Service_Records (
    ServiceID INT AUTO_INCREMENT PRIMARY KEY,
    VehicleID INT,
    CenterID INT,
    ServiceDate DATE,
    Description TEXT,
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID) ON DELETE CASCADE,
    FOREIGN KEY (CenterID) REFERENCES Service_Centers(CenterID) ON DELETE CASCADE
);

CREATE TABLE Traffic_Cameras (
    CameraID INT AUTO_INCREMENT PRIMARY KEY,
    Location VARCHAR(100),
    CameraType VARCHAR(50)
);

CREATE TABLE Camera_Records (
    RecordID INT AUTO_INCREMENT PRIMARY KEY,
    CameraID INT,
    VehicleID INT,
    CaptureDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CameraID) REFERENCES Traffic_Cameras(CameraID) ON DELETE CASCADE,
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID) ON DELETE CASCADE
);

CREATE TABLE Accident_Reports (
    ReportID INT AUTO_INCREMENT PRIMARY KEY,
    VehicleID INT,
    ReportDate DATE,
    Description TEXT,
    DamageCost DECIMAL(10,2),
    FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID) ON DELETE CASCADE
);


-- Insert data into Owners with real Texas addresses
INSERT INTO Owners (OwnerID, FirstName, LastName, Address, Phone, Email, LicenseNo) VALUES
(1001, 'John', 'Lennon', '2719 S Lamar Blvd, Austin, TX 78704', '555-1234', 'johnlennon@example.com', 'L00001'),
(1023, 'Paul', 'McCartney', '2115 Barton Springs Rd, Austin, TX 78704', '555-2345', 'paulmccartney@example.com', 'L00002'),
(1045,'George', 'Harrison', '1500 Louisiana St, Houston, TX 77002', '555-3456', 'georgeharrison@example.com', 'L00003'),
(1078,'Ringo', 'Starr', '2220 N St. Mary\'s St, San Antonio, TX 78212', '555-4567', 'ringostarr@example.com', 'L00004'),
(1102,'Mick', 'Jagger', '1401 N. Loop 1604 W, San Antonio, TX 78258', '555-5678', 'mickjagger@example.com', 'L00005'),
(1134,'Keith', 'Richards', '8502 N Freeway, Fort Worth, TX 76131', '555-6789', 'keithrichards@example.com', 'L00006'),
(1156,'Freddie', 'Mercury', '4101 E Randol Mill Rd, Arlington, TX 76011', '555-7890', 'freddiemercury@example.com', 'L00007'),
(1189,'Brian', 'May', '3910 S Padre Island Dr, Corpus Christi, TX 78411', '555-8901', 'brianmay@example.com', 'L00008'),
(1215,'David', 'Bowie', '3200 W 15th St, Plano, TX 75075', '555-9012', 'davidbowie@example.com', 'L00009'),
(1250, 'Elton', 'John', '2621 34th St, Lubbock, TX 79410', '555-0123', 'eltonjohn@example.com', 'L00010');

-- Insert data into Vehicles
INSERT INTO Vehicles (VehicleID, RegistrationNo, VIN, Make, Model, Year, Color, FuelType, VehicleType, Status) VALUES
(1001, '8ABC123', '1HGCM82633A123456', 'Honda', 'Accord', 2018, 'White', 'Gasoline', 'Sedan', 'Active'),
(1002, '7XYZ789', '1FAFP404X1F123456', 'Ford', 'Mustang', 2019, 'Red', 'Gasoline', 'Coupe', 'Active'),
(1003, '6LMN456', '2T1BURHE5JC123456', 'Toyota', 'Corolla', 2020, 'Blue', 'Gasoline', 'Sedan', 'Active'),
(1004, '5QRS234', '3FA6P0LU6KR123456', 'Ford', 'Fusion', 2021, 'Black', 'Hybrid', 'Sedan', 'Active'),
(1005, '4TUV567', '1C4RJFAG0FC123456', 'Jeep', 'Grand Cherokee', 2017, 'Silver', 'Diesel', 'SUV', 'Active'),
(1006, '3WXY890', '5NPE24AF4FH123456', 'Hyundai', 'Sonata', 2016, 'Gray', 'Gasoline', 'Sedan', 'Active'),
(1007, '2ZAB123', '1N4AL3AP8JC123456', 'Nissan', 'Altima', 2019, 'White', 'Gasoline', 'Sedan', 'Active'),
(1008, '1CDE345', '1G1BE5SM5H7123456', 'Chevrolet', 'Cruze', 2018, 'Blue', 'Gasoline', 'Sedan', 'Active'),
(1009, '9FGH678', '1J4GL58K14W123456', 'Jeep', 'Liberty', 2015, 'Green', 'Gasoline', 'SUV', 'Active'),
(1010,'0IJK901', '1FTFW1EF1EKE12345', 'Ford', 'F-150', 2020, 'Black', 'Gasoline', 'Truck', 'Active');

INSERT INTO Registrations (VehicleID, OwnerID, IssueDate, ExpiryDate, Status) VALUES
(1001, 1001, '2022-01-01', '2023-01-01', 'Active'),
(1002, 1023, '2022-05-15', '2023-05-15', 'Active'),
(1003, 1045, '2022-03-10', '2023-03-10', 'Active'),
(1004, 1078, '2021-12-20', '2022-12-20', 'Expired'),
(1005, 1102, '2020-08-25', '2021-08-25', 'Expired'),
(1006, 1134, '2022-02-18', '2023-02-18', 'Active'),
(1007, 1156, '2021-11-05', '2022-11-05', 'Expired'),
(1008, 1189, '2022-06-30', '2023-06-30', 'Active'),
(1009, 1215, '2021-07-15', '2022-07-15', 'Expired'),
(1010, 1250, '2022-04-22', '2023-04-22', 'Active');

-- Insert data into Insurance
INSERT INTO Insurance (VehicleID, ProviderName, PolicyNo, StartDate, ExpiryDate, CoverageAmount) VALUES
(1001, 'State Farm', 'SF123456', '2022-01-01', '2023-01-01', 25000.00),
(1002, 'Geico', 'GE123456', '2022-05-15', '2023-05-15', 30000.00),
(1003, 'Progressive', 'PR123456', '2022-03-10', '2023-03-10', 28000.00),
(1004, 'Allstate', 'AS123456', '2021-12-20', '2022-12-20', 22000.00),
(1005, 'Farmers', 'FM123456', '2020-08-25', '2021-08-25', 25000.00),
(1006, 'Liberty Mutual', 'LM123456', '2022-02-18', '2023-02-18', 24000.00),
(1007, 'Nationwide', 'NW123456', '2021-11-05', '2022-11-05', 21000.00),
(1008, 'The Hartford', 'TH123456', '2022-06-30', '2023-06-30', 26000.00),
(1009, 'Travelers', 'TR123456', '2021-07-15', '2022-07-15', 23000.00),
(1010, 'Chubb', 'CB123456', '2022-04-22', '2023-04-22', 30000.00);

-- Insert data into Violations
INSERT INTO Violations (VehicleID, OwnerID, ViolationType, FineAmount, Status) VALUES
(1001, 1001, 'Speeding', 100.00, 'Unpaid'),
(1002, 1023, 'Parking Violation', 50.00, 'Unpaid'),
(1003, 1045, 'Expired Registration', 75.00, 'Unpaid'),
(1004, 1078, 'Running a Red Light', 200.00, 'Paid'),
(1005, 1102, 'Illegal Parking', 60.00, 'Unpaid'),
(1006, 1134, 'Speeding', 150.00, 'Unpaid'),
(1007, 1156, 'No Seatbelt', 100.00, 'Paid'),
(1008, 1189, 'Parking Violation', 50.00, 'Paid'),
(1009, 1215, 'Expired Registration', 75.00, 'Unpaid'),
(1010, 1250, 'Speeding', 100.00, 'Unpaid');

-- Insert data into Payments
INSERT INTO Payments (ViolationID, Amount, PaymentDate, PaymentMethod) VALUES
(1, 100.00, '2022-01-10', 'Credit Card'),
(2, 50.00, '2022-05-20', 'Debit Card'),
(3, 75.00, '2022-03-15', 'Cash'),
(4, 200.00, '2021-12-25', 'Credit Card'),
(5, 60.00, '2020-09-01', 'Debit Card'),
(6, 150.00, '2022-03-01', 'Credit Card'),
(7, 100.00, '2021-12-10', 'Cash'),
(8, 50.00, '2022-07-05', 'Debit Card'),
(9, 75.00, '2021-07-20', 'Credit Card'),
(10, 100.00, '2022-05-10', 'Debit Card');
-- Insert data into Ownership_History
INSERT INTO Ownership_History (VehicleID, PreviousOwnerID, NewOwnerID, TransferDate) VALUES
(1001, 1001, 1023, '2022-01-01'),
(1002, 1023, 1045, '2022-05-15'),
(1003, 1045, 1078, '2022-03-10'),
(1004, 1078, 1102, '2021-12-20'),
(1005, 1102, 1134, '2020-08-25'),
(1006, 1134, 1156, '2022-02-18'),
(1007, 1156, 1189, '2021-11-05'),
(1008, 1189, 1215, '2022-06-30'),
(1009, 1215, 1250, '2021-07-15'),
(1010, 1250, 1001, '2022-04-22');

-- Insert data into Vehicle_Inspection

INSERT INTO Vehicle_Inspection (VehicleID, InspectionDate, Result, Comments) VALUES
(1001, '2022-01-10', 'Pass', 'Inspection Passed'),
(1002, '2022-06-05', 'Pass', 'Inspection Passed'),
(1003, '2022-03-15', 'Fail', 'Brakes need replacing'),
(1004, '2021-12-25', 'Pass', 'Inspection Passed'),
(1005, '2020-09-05', 'Pass', 'Inspection Passed'),
(1006, '2022-03-05', 'Pass', 'Inspection Passed'),
(1007, '2021-12-10', 'Fail', 'Engine check required'),
(1008, '2022-07-05', 'Pass', 'Inspection Passed'),
(1009, '2021-07-25', 'Fail', 'Tire pressure low'),
(1010, '2022-05-05', 'Pass', 'Inspection Passed');

-- Insert data into Tolls
INSERT INTO Tolls (Location, Fee) VALUES
('Dallas Tollway, Dallas, TX', 2.50),
('I-10, Houston, TX', 3.00),
('US-281, San Antonio, TX', 1.50),
('I-35, Austin, TX', 2.00),
('SH-130, Austin, TX', 4.00);

INSERT INTO Toll_Records (VehicleID, TollID, DateTime) VALUES
(1001, 1, '2022-01-10 10:00:00'),
(1002, 2, '2022-06-05 12:30:00'),
(1003, 3, '2022-03-15 14:00:00'),
(1004, 4, '2021-12-25 09:45:00'),
(1005, 5, '2020-09-05 16:00:00'),
(1006, 1, '2022-03-05 11:00:00'),
(1007, 2, '2021-12-10 08:30:00'),
(1008, 3, '2022-07-05 13:15:00'),
(1009, 4, '2021-07-25 07:45:00'),
(1010, 5, '2022-05-05 15:30:00');

-- Insert data into Service_Centers
INSERT INTO Service_Centers (Name, Address, Contact) VALUES
('Jiffy Lube', '1234 Main St, Dallas, TX 75201', '555-1111'),
('Firestone', '5678 Elm St, Austin, TX 78701', '555-2222'),
('Goodyear', '91011 Oak St, Houston, TX 77005', '555-3333'),
('Pep Boys', '1213 Pine St, San Antonio, TX 78205', '555-4444'),
('Midas', '1415 Cedar St, Corpus Christi, TX 78401', '555-5555');

-- Insert data into Service_Records
INSERT INTO Service_Records (VehicleID, CenterID, ServiceDate, Description) VALUES
(1001, 01, '2022-01-15', 'Oil Change'),
(1002, 02, '2022-06-10', 'Tire Rotation'),
(1003, 03, '2022-03-20', 'Brake Replacement'),
(1004, 04, '2021-12-28', 'Battery Replacement'),
(1005, 05, '2020-09-10', 'Engine Tune-up'),
(1006, 01, '2022-03-10', 'Oil Change'),
(1007, 02, '2021-12-15', 'Brake Pads Replacement'),
(1008, 03, '2022-07-10', 'Tire Replacement'),
(1009, 04, '2021-07-30', 'Alignment'),
(1010, 05, '2022-05-15', 'Transmission Fluid Change');

-- Insert data into Traffic_Cameras
INSERT INTO Traffic_Cameras (Location, CameraType) VALUES
('I-35, Austin, TX', 'Speed Camera'),
('US-59, Houston, TX', 'Red Light Camera'),
('SH-45, San Antonio, TX', 'Speed Camera'),
('I-10, Dallas, TX', 'Red Light Camera'),
('I-30, Fort Worth, TX', 'Speed Camera');

-- Insert data into Camera_Records
INSERT INTO Camera_Records (CameraID, VehicleID, CaptureDate) VALUES
(1, 1001, '2022-01-10 10:00:00'),
(2, 1002, '2022-06-05 12:30:00'),
(3, 1003, '2022-03-15 14:00:00'),
(4, 1004, '2021-12-25 09:45:00'),
(5, 1005, '2020-09-05 16:00:00');

-- Insert data into Accident_Reports with changed VehicleID
INSERT INTO Accident_Reports (VehicleID, ReportDate, Description, DamageCost) VALUES
(1001, '2022-01-10', 'Rear-end collision', 5000.00),
(1002, '2022-06-05', 'Side swipe', 3000.00),
(1003, '2022-03-15', 'Head-on collision', 10000.00),
(1004, '2021-12-25', 'Single vehicle rollover', 15000.00),
(1005, '2020-09-05', 'Hit-and-run', 7000.00),
(1006, '2022-03-05', 'Minor fender bender', 2000.00),
(1007, '2021-12-10', 'T-bone collision', 12000.00),
(1008, '2022-07-05', 'Rear-end collision', 5000.00),
(1009, '2021-07-25', 'Single vehicle crash', 8000.00),
(1010, '2022-05-05', 'Minor side collision', 3000.00);

-- Stored Procedure - GetOwnerVehicleDetails - This procedure simplifies fetching owner and vehicle details by combining data from multiple tables, making the query more efficient and reusable.

DELIMITER $$

CREATE PROCEDURE GetOwnerVehicleDetails(IN ownerID INT)
BEGIN
    SELECT 
        o.FirstName, 
        o.LastName, 
        v.VehicleID, 
        v.RegistrationNo, 
        v.Make, 
        v.Model, 
        v.Year
    FROM 
        Owners o
    JOIN 
        Registrations r ON o.OwnerID = r.OwnerID
    JOIN 
        Vehicles v ON r.VehicleID = v.VehicleID
    WHERE 

        o.OwnerID = ownerID;
END $$

DELIMITER ;
-- 2. Get vehicle details by VIN - This procedure ensures consistent and efficient retrieval of vehicle details by VIN, centralizing the logic for easy maintenance.
DELIMITER $$

CREATE PROCEDURE GetVehicleDetailsByVIN(IN vin VARCHAR(20))
BEGIN
    SELECT * 
    FROM Vehicles
    WHERE VIN = vin;
END $$

DELIMITER ;

-- 3. Get ownerdetails by OwnerID - It encapsulates the logic for retrieving an owner’s details by OwnerID, reducing redundancy and improving maintainability in the application.
DELIMITER $$

CREATE PROCEDURE GetOwnerDetailsByID(IN ownerID INT)
BEGIN
    SELECT * 
    FROM Owners
    WHERE OwnerID = ownerID;
END $$

DELIMITER ;

-- 4. Get Vehicle Violation Summary
-- It Provides total violations, total fine amount, and outstanding unpaid fines for a given vehicle.
-- Fast summary report for law enforcement and compliance checking.

DELIMITER $$

CREATE PROCEDURE GetVehicleViolationSummary (IN in_VehicleID INT)
BEGIN
    SELECT 
        VehicleID,
        COUNT(*) AS TotalViolations,
        SUM(FineAmount) AS TotalFineAmount,
        SUM(CASE WHEN Status = 'Unpaid' THEN FineAmount ELSE 0 END) AS UnpaidFines
    FROM Violations
    WHERE VehicleID = in_VehicleID
    GROUP BY VehicleID;
END $$

DELIMITER ;

-- 5. Get Owner Payment History
-- It Fetches complete payment history for a specific owner, sorted by latest payment date.
-- Quick review of owner’s payment transactions for customer service and dispute resolution.

DELIMITER $$

CREATE PROCEDURE GetOwnerPaymentHistory (IN in_OwnerID INT)
BEGIN
    SELECT 
        PaymentID,
        OwnerID,
        Amount,
        PaymentDate,
        PaymentMethod,
        Status
    FROM Payments
    WHERE OwnerID = in_OwnerID
    ORDER BY PaymentDate DESC;
END $$

DELIMITER ;

-- FUNCTIONS 

-- 1.Function: GetTotalFineAmount - This function calculates the total unpaid fine for a specific vehicle, providing an easy way to get financial data related to vehicle violations.
DELIMITER $$

CREATE FUNCTION GetTotalFineAmount(vehicleID INT) 
RETURNS DECIMAL(10, 2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE totalFine DECIMAL(10, 2);
    SELECT SUM(FineAmount) INTO totalFine
    FROM Violations
    WHERE VehicleID = vehicleID AND Status = 'Unpaid';
    RETURN IFNULL(totalFine, 0);
END $$

DELIMITER ;

-- 2. Function: GetVehicleStatus - This function retrieves the current status of a vehicle, ensuring consistency in accessing vehicle status across different parts of the system.
DELIMITER $$

CREATE FUNCTION GetVehicleStatus(vehicleID INT) 
RETURNS VARCHAR(50)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE vehicleStatus VARCHAR(50);
    SELECT Status INTO vehicleStatus
    FROM Vehicles
    WHERE VehicleID = vehicleID;
    RETURN vehicleStatus;
END $$

DELIMITER ;

-- 3. Function: GetOwnerViolationCount -  returns the number of violations associated with a specific owner, centralizing the logic for violation counting and improving query reusability.
DELIMITER $$

CREATE FUNCTION GetOwnerViolationCount(ownerID INT) 
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE violationCount INT;
    SELECT COUNT(*) INTO violationCount
    FROM Violations v
    JOIN Registrations r ON v.VehicleID = r.VehicleID
    WHERE r.OwnerID = ownerID;
    RETURN violationCount;
END $$

DELIMITER ;

-- 4.Function Get total fines for a vehicle - This function calculates the total fines for a vehicle, simplifying financial reporting and enhancing the accuracy of fine data retrieval.
DELIMITER $$

CREATE FUNCTION GetTotalFines(p_VehicleID INT) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(FineAmount) INTO total 
    FROM Violations 
    WHERE VehicleID = p_VehicleID;
    RETURN total;
END $$

DELIMITER ;

-- 5. Get owner vehicle count - This function returns the number of vehicles associated with an owner, streamlining ownership-related queries and improving performance.
DELIMITER $$

CREATE FUNCTION GetOwnerVehicleCount(ownerID INT) 
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE vehicleCount INT;
    -- Count the number of vehicles associated with the owner
    SELECT COUNT(*) INTO vehicleCount
    FROM Registrations r
    WHERE r.OwnerID = ownerID;
    RETURN vehicleCount;
END $$

DELIMITER ;

-- Triggers:
-- 1.Auto update vehicle status on expired registration - This trigger automatically updates a vehicle’s status to “Suspended” when the registration expires, ensuring data consistency and reducing manual updates.
DELIMITER //
CREATE TRIGGER UpdateVehicleStatus
AFTER UPDATE ON Registrations
FOR EACH ROW
BEGIN
    IF NEW.Status = 'Expired' THEN
        UPDATE Vehicles SET Status = 'Suspended' WHERE VehicleID = NEW.VehicleID;
    END IF;
END;
//
DELIMITER ;
-- 2. Prevent duplicate registration numbers - This trigger prevents inserting duplicate registration numbers, ensuring data integrity by enforcing uniqueness in vehicle registrations.
DELIMITER //
CREATE TRIGGER PreventDuplicateRegistration
BEFORE INSERT ON Vehicles
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM Vehicles WHERE RegistrationNo = NEW.RegistrationNo) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Registration number already exists!';
    END IF;
END;
//
DELIMITER ;
-- 3. Automatically Update Insurance Expiry Status - This trigger ensures that the insurance status is automatically updated to “Expired” when the expiration date passes, maintaining up-to-date insurance data.
DELIMITER $$

CREATE TRIGGER UpdateInsuranceStatus
AFTER UPDATE ON Insurance
FOR EACH ROW
BEGIN
    -- Check if the insurance expiry date is less than the current date
    IF NEW.ExpiryDate < CURDATE() THEN
        -- Update the insurance status to Expired for the vehicle
        UPDATE Insurance
        SET Status = 'Expired'
        WHERE VehicleID = NEW.VehicleID;
    END IF;
END $$

DELIMITER ;

-- 4. Payment Insert Audit
-- This trigger Logs any new payment into Payment_Audit table and Ensures traceability of all financial transactions for transparency.

DELIMITER $$

CREATE TRIGGER trg_AfterInsert_Payment
AFTER INSERT ON Payments
FOR EACH ROW
BEGIN
    INSERT INTO Payment_Audit (PaymentID, OwnerID, Amount, PaymentDate, Status, ActionTaken)
    VALUES (NEW.PaymentID, NEW.OwnerID, NEW.Amount, NEW.PaymentDate, NEW.Status, 'Inserted');
END $$

DELIMITER ;

-- 5.Insurance Update Audit
-- This trigger Logs updates to insurance records into Insurance_Audit table and Maintains history of insurance changes for compliance and reference.

DELIMITER $$

CREATE TRIGGER trg_AfterUpdate_Insurance
AFTER UPDATE ON Insurance
FOR EACH ROW
BEGIN
    INSERT INTO Insurance_Audit (InsuranceID, VehicleID, ProviderName, PolicyNo, StartDate, ExpiryDate, ActionTaken)
    VALUES (NEW.InsuranceID, NEW.VehicleID, NEW.ProviderName, NEW.PolicyNo, NEW.StartDate, NEW.ExpiryDate, 'Updated');
END $$

DELIMITER ;

-- AUDIT TABLES FOR TRIGGERS
-- Audit Table for Ownership Transfer Trigger
CREATE TABLE Ownership_Transfer_Audit (
    AuditID INT PRIMARY KEY AUTO_INCREMENT,
    VehicleID INT,
    PreviousOwnerID INT,
    NewOwnerID INT,
    TransferDate DATETIME,
    ActionTaken VARCHAR(50),
    AuditTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Audit Table for Registration Expiry Trigger
CREATE TABLE Registration_Expiry_Audit (
    AuditID INT PRIMARY KEY AUTO_INCREMENT,
    RegID INT,
    VehicleID INT,
    OwnerID INT,
    ExpiryDate DATE,
    StatusBefore VARCHAR(50),
    StatusAfter VARCHAR(50),
    AuditTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Audit Table for Violation Trigger
CREATE TABLE Violation_Audit (
    AuditID INT PRIMARY KEY AUTO_INCREMENT,
    ViolationID INT,
    VehicleID INT,
    OwnerID INT,
    ViolationType VARCHAR(100),
    FineAmount DECIMAL(10,2),
    ActionTaken VARCHAR(50),
    AuditTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Audit Table for Payment Trigger
CREATE TABLE Payment_Audit (
    AuditID INT PRIMARY KEY AUTO_INCREMENT,
    PaymentID INT,
    OwnerID INT,
    Amount DECIMAL(10,2),
    PaymentDate DATETIME,
    Status VARCHAR(50),
    ActionTaken VARCHAR(50),
    AuditTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Audit Table for Insurance Trigger
CREATE TABLE Insurance_Audit (
    AuditID INT PRIMARY KEY AUTO_INCREMENT,
    InsuranceID INT,
    VehicleID INT,
    ProviderName VARCHAR(100),
    PolicyNo VARCHAR(100),
    StartDate DATE,
    ExpiryDate DATE,
    ActionTaken VARCHAR(50),
    AuditTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- complex queries

-- 1. Retrieve Vehicles That Have Passed Inspection but Were Involved in an Accident
SELECT 
    v.VehicleID, 
    v.RegistrationNo, 
    vi.InspectionDate, 
    a.ReportDate, 
    a.Description, 
    a.DamageCost 
FROM Vehicles v
JOIN Vehicle_Inspection vi ON v.VehicleID = vi.VehicleID
JOIN Accident_Reports a ON v.VehicleID = a.VehicleID
WHERE vi.Result = 'Pass';

-- 2. Find the Top 3 Owners Who Have Paid the Highest Amount in Violation Fines
SELECT 
    o.FirstName, 
    o.LastName, 
    SUM(p.Amount) AS TotalPaid 
FROM Payments p
JOIN Violations v ON p.ViolationID = v.ViolationID
JOIN Owners o ON v.OwnerID = o.OwnerID
GROUP BY o.OwnerID 
ORDER BY TotalPaid DESC 
LIMIT 3;

-- 3. Find the Top 3 Vehicles with Most Violations
SELECT 
    v.Make, 
    v.Model, 
    COUNT(vi.ViolationID) AS ViolationCount
FROM Vehicles v
JOIN Violations vi ON v.VehicleID = vi.VehicleID
GROUP BY v.VehicleID
ORDER BY ViolationCount DESC
LIMIT 3;

-- 4. Get the Number of Vehicles per Owner
SELECT 
    o.FirstName, 
    o.LastName, 
    COUNT(r.VehicleID) AS TotalVehicles
FROM Owners o
JOIN Registrations r ON o.OwnerID = r.OwnerID
GROUP BY o.OwnerID;

-- 5. Find Vehicles that Have Never Been Fined
SELECT 
    v.Make, 
    v.Model 
FROM Vehicles v
LEFT JOIN Violations vi ON v.VehicleID = vi.VehicleID
WHERE vi.VehicleID IS NULL;


-- 6. Get the Most Common Violation Type
SELECT 
    ViolationType, 
    COUNT(*) AS Occurrences
FROM Violations
GROUP BY ViolationType
ORDER BY Occurrences DESC
LIMIT 1;

-- 7. Find the Owners Who Have Never Owned a Vehicle with an Active Registration Status
SELECT 
    o.FirstName, 
    o.LastName
FROM Owners o
WHERE NOT EXISTS (
    SELECT 1 
    FROM Registrations r 
    WHERE r.OwnerID = o.OwnerID AND r.Status = 'Active'
);
-- 8. Find the Total Number of Toll Records for Each Vehicle and the Total Toll Fee Paid
SELECT 
    v.RegistrationNo, 
    COUNT(tr.RecordID) AS TotalTolls, 
    SUM(t.Fee) AS TotalTollFee
FROM Vehicles v
JOIN Toll_Records tr ON v.VehicleID = tr.VehicleID
JOIN Tolls t ON tr.TollID = t.TollID
GROUP BY v.VehicleID;

-- 9. List All Vehicles with Expired Registrations but Still Have Active Insurance
SELECT 
    v.RegistrationNo, 
    v.Make, 
    v.Model, 
    r.ExpiryDate AS RegistrationExpiry, 
    i.ExpiryDate AS InsuranceExpiry
FROM Vehicles v
JOIN Registrations r ON v.VehicleID = r.VehicleID
JOIN Insurance i ON v.VehicleID = i.VehicleID
WHERE r.Status = 'Expired' AND i.ExpiryDate > CURDATE();

-- 10. Find the Most Recent Service Performed on Each Vehicle
SELECT 
    v.RegistrationNo, 
    s.ServiceDate, 
    s.Description
FROM Vehicles v
JOIN Service_Records s ON v.VehicleID = s.VehicleID
WHERE s.ServiceDate = (
    SELECT MAX(ServiceDate) 
    FROM Service_Records 
    WHERE VehicleID = v.VehicleID
);













