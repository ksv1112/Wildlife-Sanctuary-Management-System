-- DBMS Project 

-- Creating new databasse 
CREATE DATABASE wildlife_sanctuary; 

-- Using the same database 
USE wildlife_sanctuary; 

CREATE TABLE Sanctuaries (
  SanctuaryID INT PRIMARY KEY,
  Name VARCHAR(100),
  City VARCHAR(100),
  State VARCHAR(100),
  Country VARCHAR(100),
  AreaSize INT,
  Description VARCHAR(100)
);

CREATE TABLE Animals (
  AnimalID INT PRIMARY KEY,
  Type VARCHAR(100),
  Species VARCHAR(100),
  Population INT,
  RangeOfExtinction VARCHAR(100),
  Lifespan INT,
  SanctuaryID INT,
  FOREIGN KEY (SanctuaryID) REFERENCES Sanctuaries(SanctuaryID)
);

CREATE TABLE Employees (
  EmployeeID INT PRIMARY KEY,
  EmployeeName VARCHAR(100),
  ContactNumber VARCHAR(100),
  JobTitle VARCHAR(100),
  Department VARCHAR(100),
  Salary DECIMAL(10, 2),
  HireDate DATE,
  SanctuaryID INT,
  FOREIGN KEY (SanctuaryID) REFERENCES Sanctuaries(SanctuaryID)
);
 
CREATE TABLE Doctors (
  DoctorID INT PRIMARY KEY,
  FirstName VARCHAR(100),
  LastName VARCHAR(100),
  Specialization VARCHAR(100),
  SanctuaryID INT,
  FOREIGN KEY (SanctuaryID) REFERENCES Sanctuaries(SanctuaryID)
);

CREATE TABLE HabitatAreas (
  HabitatAreaID INT PRIMARY KEY,
  Name VARCHAR(100),
  Location VARCHAR(100),
  AreaSize INT,
  Climate VARCHAR(100),
  Terrain VARCHAR(100),
  SanctuaryID INT,
  FOREIGN KEY (SanctuaryID) REFERENCES Sanctuaries(SanctuaryID)
);


CREATE TABLE Trees (
  TreeID INT PRIMARY KEY,
  Species VARCHAR(100),
  HabitatAreaID INT,
  SanctuaryID INT,
  FOREIGN KEY (HabitatAreaID) REFERENCES HabitatAreas(HabitatAreaID),
  FOREIGN KEY (SanctuaryID) REFERENCES Sanctuaries(SanctuaryID)
);

CREATE TABLE Birds (
  BirdID INT PRIMARY KEY,
  Type VARCHAR(100),
  Species VARCHAR(100),
  HabitatAreaID INT,
  Population INT,
  SanctuaryID INT,
  FOREIGN KEY (HabitatAreaID) REFERENCES HabitatAreas(HabitatAreaID),
  FOREIGN KEY (SanctuaryID) REFERENCES Sanctuaries(SanctuaryID)
);

CREATE TABLE Passengers (
  PassengerID INT PRIMARY KEY,
  Name VARCHAR(100),
  ContactNumber VARCHAR(100),
  Email VARCHAR(100),
  Birthdate DATE,
  SanctuaryID INT,
  FOREIGN KEY (SanctuaryID) REFERENCES Sanctuaries(SanctuaryID)
);

CREATE TABLE SafariRideBookings (
  SafariRideBookingID INT PRIMARY KEY,
  PassengerID INT,
  NumOfPeople INT,
  Date DATE,
  Slots VARCHAR(100),
  Distance INT,
  VehicleType VARCHAR(100),
  SanctuaryID INT,
  FOREIGN KEY (PassengerID) REFERENCES Passengers(PassengerID),
  FOREIGN KEY (SanctuaryID) REFERENCES Sanctuaries(SanctuaryID)
);


CREATE TABLE MedicalSupplies (
    MedicalSupplyID INT PRIMARY KEY,
    Name VARCHAR(100),
    Description VARCHAR(100),
    Quantity INT,
    SupplierInfo VARCHAR(100),
    CostPerUnit INT,
    SanctuaryID INT,
    FOREIGN KEY (SanctuaryID) REFERENCES Sanctuaries(SanctuaryID)
);

CREATE TABLE FoodSupplies (
    FoodSupplyID INT PRIMARY KEY,
    Name VARCHAR(100),
    Description VARCHAR(100),
    Quantity INT,
    SupplierInfo VARCHAR(100),
    CostPerUnit INT,
    SanctuaryID INT,
    FOREIGN KEY (SanctuaryID) REFERENCES Sanctuaries(SanctuaryID)
);

-- ----------------------------------------------------------------------------------------------------------------------- 

-- Sanctuaries 

INSERT INTO Sanctuaries (SanctuaryID, Name, City, State, Country, AreaSize, Description) VALUES 
(1, 'Kanha National Park', 'Mandla', 'Madhya Pradesh', 'India', 940, 'Famous for Bengal Tigers and Barasingha'),
(2, 'Bandhavgarh National Park', 'Umaria', 'Madhya Pradesh', 'India', 437, 'Famous for Bengal Tigers and White Tigers'),
(3, 'Sundarbans National Park', 'South 24 Parganas', 'West Bengal', 'India', 1330, 'Famous for Royal Bengal Tigers and Saltwater Crocodiles'),
(4, 'Periyar Wildlife Sanctuary', 'Thekkady', 'Kerala', 'India', 305, 'Famous for Elephants and Bengal Tigers'),
(5, 'Sariska National Park', 'Alwar', 'Rajasthan', 'India', 866, 'Famous for Bengal Tigers and Leopards');

SELECT * FROM Sanctuaries;

-- ---------------------------------------------------------------------------------------------------------------------

	
INSERT INTO Animals (AnimalID, Type, Species, Population, RangeOfExtinction, Lifespan, SanctuaryID) VALUES
(1, 'Mammal', 'Bengal Tiger', 2500, 'Endangered', 15, 1),
(2, 'Mammal', 'Indian Rhinoceros', 3500, 'Vulnerable', 35, 1),
(3, 'Bird', 'Indian Peafowl', 10000, 'Least Concern', 15, 1),
(4, 'Mammal', 'Asiatic Lion', 523, 'Endangered', 16, 2),
(5, 'Mammal', 'Indian Elephant', 27000, 'Endangered', 60, 2),
(6, 'Bird', 'Indian Vulture', 150, 'Critically Endangered', 20, 2),
(7, 'Reptile', 'King Cobra', 100, 'Least Concern', 20, 3),
(8, 'Mammal', 'Sloth Bear', 7000, 'Vulnerable', 25, 3),
(9, 'Mammal', 'Indian Wild Dog', 2500, 'Endangered', 12, 3),
(10, 'Bird', 'Sarus Crane', 1500, 'Vulnerable', 30, 4),
(11, 'Mammal', 'Blackbuck', 5000, 'Least Concern', 10, 4),
(12, 'Reptile', 'Gharial', 200, 'Critically Endangered', 40, 4);

SELECT * FROM Animals;

-- ------------------------------------------------------------------------------------------------


INSERT INTO Employees (EmployeeID, EmployeeName, ContactNumber, JobTitle, Department, Salary, HireDate, SanctuaryID) VALUES
(101, 'Aarav Patel', '9876543210', 'Zookeeper', 'Animal Care', 25000.00, '2021-01-01', 1),
(102, 'Aanya Singh', '9876543211', 'Tour Guide', 'Tourism', 20000.00, '2021-02-01', 1),
(103, 'Arjun Sharma', '9876543212', 'Veterinarian', 'Animal Health', 40000.00, '2021-03-01', 2),
(104, 'Avni Desai', '9876543213', 'Sanctuary Manager', 'Operations', 50000.00, '2021-04-01', 2),
(105, 'Devansh Gupta', '9876543214', 'Accountant', 'Finance', 35000.00, '2021-05-01', 3),
(106, 'Ishika Singh', '9876543215', 'Tour Guide', 'Tourism', 20000.00, '2021-06-01', 3),
(107, 'Kabir Mishra', '9876543216', 'Zookeeper', 'Animal Care', 25000.00, '2021-07-01', 4),
(108, 'Kavya Patel', '9876543217', 'Veterinarian', 'Animal Health', 40000.00, '2021-08-01', 4),
(109, 'Manya Singh', '9876543218', 'Tour Guide', 'Tourism', 20000.00, '2021-09-01', 5),
(110, 'Parth Desai', '9876543219', 'Sanctuary Manager', 'Operations', 50000.00, '2021-10-01', 5);

SELECT * FROM Employees; 
-- -------------------------------------------------------------------------------------------------------------------- 

INSERT INTO Doctors (DoctorID, FirstName, LastName, Specialization, SanctuaryID) VALUES 
(200, 'Aditi', 'Gupta', 'Zoo Veterinarian', 1),
(201, 'Alok', 'Jha', 'Animal Behaviorist', 2),
(202, 'Amit', 'Patel', 'Wildlife Biologist', 3),
(203, 'Ankita', 'Sharma', 'Zoologist', 4),
(204, 'Ankit', 'Singh', 'Wildlife Conservationist', 4),
(205, 'Aparna', 'Rao', 'Veterinary Surgeon', 1),
(206, 'Arjun', 'Kumar', 'Animal Nutritionist', 2),
(207, 'Arvind', 'Gupta', 'Wildlife Veterinarian', 3);

SELECT * FROM Doctors; 

-- ------------------------------------------------------------------------------------------------

INSERT INTO HabitatAreas (HabitatAreaID, Name, Location, AreaSize, Climate, Terrain, SanctuaryID) VALUES 
(101, 'Bamboo Forest', 'Kanha National Park', 120, 'Tropical', 'Forest', 1),
(102, 'Grasslands', 'Bandhavgarh National Park', 80, 'Tropical', 'Grassland', 2),
(103, 'Mangrove Forest', 'Sundarbans National Park', 150, 'Tropical', 'Forest', 3),
(104, 'Evergreen Forest', 'Periyar Wildlife Sanctuary', 90, 'Tropical', 'Forest', 4),
(105, 'Desert Scrubland', 'Sariska National Park', 200, 'Arid', 'Desert', 5),
(106, 'Mixed Deciduous Forest', 'Kanha National Park', 110, 'Tropical', 'Forest', 1),
(107, 'Dry Deciduous Forest', 'Bandhavgarh National Park', 70, 'Tropical', 'Forest', 2),
(108, 'Swamp Forest', 'Sundarbans National Park', 120, 'Tropical', 'Swamp', 3),
(109, 'Montane Forest', 'Periyar Wildlife Sanctuary', 100, 'Temperate', 'Mountain', 4),
(110, 'Thorn Forest', 'Sariska National Park', 180, 'Arid', 'Forest', 5);

SELECT * FROM HabitatAreas; 

-- ----------------------------------------------------------------------------------------------------------------


INSERT INTO Trees (TreeID, Species, HabitatAreaID, SanctuaryID) VALUES 
(1, 'Bamboo', 101, 1),
(2, 'Sal', 101, 1),
(3, 'Teak', 106, 1),
(4, 'Sissoo', 107, 2),
(5, 'Mangrove', 103, 3),
(6, 'Ebony', 104, 4),
(7, 'Rosewood', 104, 4),
(8, 'Acacia', 110, 5),
(9, 'Babool', 110, 5),
(10, 'Neem', 110, 5);

SELECT * FROM Trees; 

-- ------------------------------------------------------------------------------------------------------------------------

INSERT INTO Birds (BirdID, Type, Species, HabitatAreaID, Population, SanctuaryID) VALUES
(1, 'Passerine', 'Baya Weaver', 101, 100, 1),
(2, 'Raptor', 'Crested Serpent Eagle', 102, 20, 2),
(3, 'Waterbird', 'Cormorant', 103, 75, 3),
(4, 'Passerine', 'Indian Robin', 104, 50, 4),
(5, 'Raptor', 'Indian Vulture', 105, 10, 5),
(6, 'Passerine', 'Red-vented Bulbul', 106, 75, 1),
(7, 'Raptor', 'Shikra', 107, 15, 2),
(8, 'Waterbird', 'Spoonbill', 108, 30, 3),
(9, 'Passerine', 'White-throated Kingfisher', 109, 40, 4),
(10, 'Raptor', 'Tawny Eagle', 110, 25, 5);

SELECT * FROM Birds; 

-- ------------------------------------------------------------------------------------------------------------------------

INSERT INTO Passengers (PassengerID, Name, ContactNumber, Email, Birthdate, SanctuaryID) VALUES 
(1, 'Priya Patel', '9876543210', 'priya.patel@example.com', '1990-01-01', 1),
(2, 'Rahul Singh', '8765432109', 'rahul.singh@example.com', '1992-05-12', 2),
(3, 'Kavita Sharma', '7654321098', 'kavita.sharma@example.com', '1985-09-23', 3),
(4, 'Amit Kumar', '6543210987', 'amit.kumar@example.com', '1987-03-15', 4),
(5, 'Anjali Gupta', '5432109876', 'anjali.gupta@example.com', '1998-11-30', 5),
(6, 'Sachin Sharma', '4321098765', 'sachin.sharma@example.com', '1995-07-08', 1),
(7, 'Neha Patel', '3210987654', 'neha.patel@example.com', '1993-02-20', 2),
(8, 'Kunal Gupta', '2109876543', 'kunal.gupta@example.com', '1991-06-18', 3),
(9, 'Manoj Singh', '1098765432', 'manoj.singh@example.com', '1989-12-10', 4),
(10, 'Radhika Khanna', '0987654321', 'radhika.khanna@example.com', '1997-08-25', 5);

SELECT * FROM Passengers; 

-- ------------------------------------------------------------------------------------------------------------------------

INSERT INTO SafariRideBookings(SafariRideBookingID, PassengerID, NumOfPeople, Date, Slots, Distance, VehicleType, SanctuaryID)
VALUES
(301, 1, 2, '2022-06-15', 'morning', 10, 'jeep', 1),
(302, 2, 4, '2021-12-20', 'noon', 20, 'bus', 2),
(303, 3, 1, '2023-01-05', 'evening', 5, 'jeep', 3),
(304, 4, 3, '2022-09-10', 'morning', 15, 'jeep', 4),
(305, 5, 2, '2023-03-18', 'noon', 20, 'bus', 5),
(306, 6, 5, '2021-11-30', 'evening', 10, 'jeep', 1),
(307, 7, 2, '2022-05-12', 'morning', 5, 'jeep', 2),
(308, 8, 3, '2023-02-28', 'noon', 15, 'bus', 3),
(309, 9, 1, '2022-07-25', 'evening', 20, 'jeep', 4),
(310, 10, 4, '2021-10-15', 'morning', 10, 'jeep', 5);

SELECT * FROM SafariRideBookings; 

-- -------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO MedicalSupplies (MedicalSupplyID, Name, Description, Quantity, SupplierInfo, CostPerUnit, SanctuaryID) VALUES 
(1, 'Vitamin C Tablets', 'Supplement for primates', 100, 'ABC Inc.', 20, 1),
(2, 'Antibiotic Ointment', 'Antibiotic ointment for minor injuries', 50, 'XYZ Corp.', 30, 1),
(3, 'Disinfectant Spray', 'Disinfectant spray for cages and enclosures', 200, 'PQR Ltd.', 15, 1),
(4, 'Oral Rehydration Salts', 'For dehydration in birds', 75, 'DEF Inc.', 10, 2),
(5, 'Feather Conditioning Oil', 'For grooming and conditioning feathers', 40, 'LMN Corp.', 25, 2),
(6, 'Birdseed Mix', 'Mixed birdseed for feeding birds', 150, 'GHI Ltd.', 5, 2),
(7, 'Sterilized Bandages', 'Bandages for wound care', 60, 'ABC Inc.', 8, 3),
(8, 'Topical Cream', 'For treating skin conditions in reptiles', 30, 'PQR Ltd.', 40, 3),
(9, 'Heat Lamps', 'Lamps for providing warmth in enclosures', 20, 'STU Corp.', 20, 3),
(10, 'Anti-inflammatory Medication', 'For treating inflammation in large mammals', 25, 'ABC Inc.', 50, 4),
(11, 'Pain Medication', 'For treating pain in large mammals', 20, 'XYZ Corp.', 60, 4),
(12, 'Hoof Trimmers', 'For trimming hooves in large mammals', 10, 'PQR Ltd.', 35, 4),
(13, 'Fish Food Pellets', 'Pellets for feeding fish', 100, 'DEF Inc.', 5, 5),
(14, 'Water Testing Kit', 'For testing water quality in aquariums', 5, 'LMN Corp.', 100, 5),
(15, 'Aquarium Salt', 'For maintaining proper water chemistry in aquariums', 20, 'GHI Ltd.', 15, 5);

SELECT * FROM MedicalSupplies; 

-- -------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO FoodSupplies(FoodSupplyID, Name, Description, Quantity, SupplierInfo, CostPerUnit, SanctuaryID) VALUES
(1, 'Hay', 'Dried grass used as animal feed', 100, 'ABC Farms', 50, 1),
(2, 'Fruits', 'Fresh fruits for primates', 50, 'XYZ Farms', 100, 1),
(3, 'Meat', 'Fresh meat for carnivorous animals', 75, 'Meat Lovers Inc.', 150, 1),
(4, 'Grains', 'Various grains for birds and rodents', 200, 'Agro Foods', 25, 2),
(5, 'Fish', 'Frozen fish for penguins and otters', 150, 'Seafood Inc.', 80, 2),
(6, 'Vegetables', 'Fresh vegetables for herbivorous animals', 100, 'Green Farms', 40, 2),
(7, 'Kibble', 'Dry dog food for domesticated animals', 50, 'Pet Foods Inc.', 20, 3),
(8, 'Mice', 'Live mice for reptile feeding', 200, 'Rodent Supplies', 2, 3),
(9, 'Insects', 'Live insects for insectivorous animals', 150, 'Bug Farms', 5, 3),
(10, 'Hay', 'Dried grass used as animal feed', 75, 'ABC Farms', 50, 4),
(11, 'Carrots', 'Fresh carrots for herbivorous animals', 50, 'Farm Fresh', 30, 4),
(12, 'Fish', 'Frozen fish for sea lions and otters', 100, 'Seafood Inc.', 75, 4),
(13, 'Fruits', 'Fresh fruits for primates', 100, 'XYZ Farms', 80, 5),
(14, 'Kibble', 'Dry cat food for domesticated animals', 75, 'Pet Foods Inc.', 30, 5),
(15, 'Seeds', 'Various seeds for birds', 200, 'Agro Foods', 15, 5);

SELECT * FROM FoodSupplies; 

-- ------------------------------------------------------------------------------------------------------------------------------------- 

