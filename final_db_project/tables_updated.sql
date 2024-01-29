-- DBMS Project 

-- Creating new databasse 
CREATE DATABASE wildlife_sanctuary_new; 

-- Using the same database 
USE wildlife_sanctuary_new; 


CREATE TABLE Sanctuary (
  SanctuaryID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  Name VARCHAR(100),
  City VARCHAR(100),
  State VARCHAR(100),
  Country VARCHAR(100),
  AreaSize INT,
  Description VARCHAR(100)
);

CREATE TABLE Animals (
  AnimalID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  Type VARCHAR(100),
  Species VARCHAR(100),
  Population INT,
  RangeOfExtinction VARCHAR(100),
  Lifespan INT
);

CREATE TABLE Employees (
  EmployeeID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  EmployeeName VARCHAR(100),
  ContactNumber VARCHAR(100),
  JobTitle VARCHAR(100),
  Department VARCHAR(100),
  Salary DECIMAL(10, 2),
  HireDate DATE
);
 
 
CREATE TABLE Doctors (
  DoctorID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  FirstName VARCHAR(100),
  LastName VARCHAR(100),
  Specialization VARCHAR(100),
  salary DECIMAL(10, 2)
);


CREATE TABLE HabitatAreas (
  HabitatAreaID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  Name VARCHAR(100),
  AreaSize INT,
  Climate VARCHAR(100),
  Terrain VARCHAR(100)
);



CREATE TABLE Trees (
  TreeID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  Species VARCHAR(100),
  HabitatAreaID INT,
  FOREIGN KEY (HabitatAreaID) REFERENCES HabitatAreas(HabitatAreaID)
);


CREATE TABLE Birds (
  BirdID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  Type VARCHAR(100),
  Species VARCHAR(100),
  HabitatAreaID INT,
  Population INT,
  FOREIGN KEY (HabitatAreaID) REFERENCES HabitatAreas(HabitatAreaID)
);

CREATE TABLE Passengers (
  PassengerID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  Name VARCHAR(100),
  ContactNumber VARCHAR(100),
  Email VARCHAR(100),
  Birthdate DATE,
  SanctuaryID INT
);

CREATE TABLE SafariRideBookings (
  SafariRideBookingID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  PassengerID INT,
  NumOfPeople INT,
  Date DATE,
  Slots VARCHAR(100),
  Distance INT,
  VehicleType VARCHAR(100),
  FOREIGN KEY (PassengerID) REFERENCES Passengers(PassengerID)
);


CREATE TABLE MedicalSupplies (
    MedicalSupplyID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Name VARCHAR(100),
    Description VARCHAR(100),
    Quantity INT,
    SupplierInfo VARCHAR(100),
    CostPerUnit INT
);

CREATE TABLE FoodSupplies (
    FoodSupplyID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Name VARCHAR(100),
    Description VARCHAR(100),
    Quantity INT,
    SupplierInfo VARCHAR(100),
    CostPerUnit INT,
    SanctuaryID INT
);


-- ----------------------------------------------------------------------------------------------------------------------- 

-- Sanctuaries 

INSERT INTO Sanctuary ( Name, City, State, Country, AreaSize, Description) VALUES 
('Gir WildLife Sanctuary', 'Sasan', 'Gujarat', 'India', 1412, 'Famous for Asiatic Lions');

SELECT * FROM Sanctuary;

-- ---------------------------------------------------------------------------------------------------------------------

	
INSERT INTO Animals (Type, Species, Population, RangeOfExtinction, Lifespan) VALUES
('Mammal', 'Asiatic Lion', 674, 'Endangered', 10),
('Mammal', 'Indian Leopard', 400, 'Vulnerable', 12),
('Mammal', 'Indian Wild Dog', 50, 'Endangered', 8),
('Reptile', 'Star Tortoise', 150, 'Vulnerable', 80),
('Mammal', 'Striped Hyena', 60, 'Near Threatened', 12),
('Reptile', 'King Cobra', 100, 'Least Concern', 20),
('Mammal', 'Sloth Bear', 7000, 'Vulnerable', 25),
('Mammal', 'Indian Wild Dog', 2500, 'Endangered', 12),
('Mammal', 'Blackbuck', 5000, 'Least Concern', 10),
('Reptile', 'Gharial', 200, 'Critically Endangered', 40);

SELECT * FROM Animals;

-- ------------------------------------------------------------------------------------------------


INSERT INTO Employees (EmployeeName, ContactNumber, JobTitle, Department, Salary, HireDate) VALUES
('Aarav Patel', '9876543210', 'Zookeeper', 'Animal Care', 25000.00, '2021-01-01'),
('Aanya Singh', '9876543211', 'Tour Guide', 'Tourism', 20000.00, '2021-02-01'),
('Avni Desai', '9876543213', 'Sanctuary Manager', 'Operations', 50000.00, '2021-04-01'),
('Devansh Gupta', '9876543214', 'Accountant', 'Finance', 35000.00, '2021-05-01'),
('Ishika Singh', '9876543215', 'Tour Guide', 'Tourism', 20000.00, '2021-06-01'),
('Kabir Mishra', '9876543216', 'Zookeeper', 'Animal Care', 25000.00, '2021-07-01'),
('Manya Singh', '9876543218', 'Tour Guide', 'Tourism', 20000.00, '2021-09-01'),
('Parth Desai', '9876543219', 'Sanctuary Manager', 'Operations', 50000.00, '2021-10-01'),
('Amit Desai', '9876545321', 'Driver', 'Operations', 30000.00, '2018-10-01'),
('Aman Agrawal', '9876545678', 'Driver', 'Operations', 30000.00, '2020-08-15');


SELECT * FROM Employees; 
-- -------------------------------------------------------------------------------------------------------------------- 

INSERT INTO Doctors (FirstName, LastName, Specialization,salary) VALUES 
('Aditi', 'Gupta', 'Zoologist',30000.00),
('Alok', 'Jha', 'Veterinary Surgeon',70000.00),
('Amit', 'Patel', 'Wildlife Biologist',50000.00),
('Ankita', 'Sharma', 'Zoologist',40000.00),
('Ankit', 'Singh', 'Zoologist','40000.00'),
('Aparna', 'Rao', 'Veterinary Surgeon',70000.00),
('Arjun', 'Kumar', 'Animal Nutritionist',35000.00),
('Arvind', 'Gupta', 'Animal Nutritionist',35000.00);

SELECT * FROM Doctors; 

-- ------------------------------------------------------------------------------------------------

INSERT INTO HabitatAreas ( Name,  AreaSize, Climate, Terrain) VALUES 
('Bamboo Forest', 120, 'Tropical', 'Forest'),
('Grasslands',  80, 'Tropical', 'Grassland'),
('Mangrove Forest',  150, 'Tropical', 'Forest'),
('Evergreen Forest',  90, 'Tropical', 'Forest'),
('Desert Scrubland',  200, 'Arid', 'Desert'),
('Mixed Deciduous Forest',  110, 'Tropical', 'Forest'),
('Dry Deciduous Forest', 70, 'Tropical', 'Forest'),
('Swamp Forest', 20, 'Tropical', 'Swamp'),
('Montane Forest',  100, 'Temperate', 'Mountain'),
('Thorn Forest',  180, 'Arid', 'Forest');

SELECT * FROM HabitatAreas; 

-- ----------------------------------------------------------------------------------------------------------------


INSERT INTO Trees (Species, HabitatAreaID) VALUES 
('Bamboo', 1),
('Sal', 1),
('Teak', 6),
('Sissoo', 7),
('Mangrove', 3),
('Ebony', 4),
('Rosewood', 4),
('Acacia', 10),
('Babool', 10),
( 'Neem', 4),
('Banyan', 2),
('Jamun', 2),
('Anogeissus latifolia', 3),
('Ficus racemosa', 5),
('Butea monosperma', 5),
('Salvadora oleoides', 6),
('Mango', 7),
('Neem', 8),
('Peepal', 8),
('Acacia catechu', 9),
('Melia azedarach', 9),
('Dhak', 10),
('Tamarind', 7);


SELECT * FROM Trees; 

-- ------------------------------------------------------------------------------------------------------------------------

INSERT INTO Birds (Type, Species, HabitatAreaID, Population) VALUES
('Passerine', 'Baya Weaver', 1, 100),
('Raptor', 'Crested Serpent Eagle', 2, 20),
('Waterbird', 'Cormorant', 3, 75),
('Passerine', 'Indian Robin', 4, 50),
('Raptor', 'Indian Vulture', 5, 10),
('Passerine', 'Red-vented Bulbul', 6, 75),
('Raptor', 'Shikra', 7, 15),
('Waterbird', 'Spoonbill', 8, 30),
('Passerine', 'White-throated Kingfisher', 9, 40),
( 'Raptor', 'Tawny Eagle', 10, 25),
('Predator', 'Indian Eagle', 1, 35),
('Predator', 'Marsh Harrier', 2, 25),
('Prey', 'Indian Peafowl', 3, 100),
('Prey', 'Grey Francolin', 4, 150),
('Wading', 'Black-Winged Stilt', 5, 20),
('Passerine', 'Common Iora', 6, 40),
('Gamebird', 'Red Spurfowl', 7, 25),
('Waterfowl', 'Common Teal', 8, 50),
('Scavenger', 'Indian Pond Heron', 9, 30), 
('Prey', 'Laughing Dove', 10, 120);


SELECT * FROM Birds; 

-- ------------------------------------------------------------------------------------------------------------------------

INSERT INTO Passengers (Name, ContactNumber, Email, Birthdate ) VALUES 
('Priya Patel', '9876543210', 'priya.patel@example.com', '1990-01-01'),
('Rahul Singh', '8765432109', 'rahul.singh@example.com', '1992-05-12'),
('Kavita Sharma', '7654321098', 'kavita.sharma@example.com', '1985-09-23'),
('Amit Kumar', '6543210987', 'amit.kumar@example.com', '1987-03-15'),
('Anjali Gupta', '5432109876', 'anjali.gupta@example.com', '1998-11-30'),
('Sachin Sharma', '4321098765', 'sachin.sharma@example.com', '1995-07-08'),
('Neha Patel', '3210987654', 'neha.patel@example.com', '1993-02-20'),
('Kunal Gupta', '2109876543', 'kunal.gupta@example.com', '1991-06-18'),
('Manoj Singh', '1098765432', 'manoj.singh@example.com', '1989-12-10'),
( 'Radhika Khanna', '0987654321', 'radhika.khanna@example.com', '1997-08-25');

SELECT * FROM Passengers; 

-- ------------------------------------------------------------------------------------------------------------------------

INSERT INTO SafariRideBookings(PassengerID, NumOfPeople, Date, Slots, Distance, VehicleType)
VALUES
(1, 2, '2022-06-15', 'morning', 10, 'jeep'),
(2, 4, '2021-12-20', 'noon', 20, 'bus'),
(3, 1, '2023-01-05', 'evening', 5, 'jeep'),
(4, 3, '2022-09-10', 'morning', 15, 'jeep'),
(5, 2, '2023-03-18', 'noon', 20, 'bus'),
(6, 5, '2021-11-30', 'evening', 10, 'jeep'),
(7, 2, '2022-05-12', 'morning', 5, 'jeep'),
(8, 3, '2023-02-28', 'noon', 15, 'bus'),
(9, 1, '2022-07-25', 'evening', 20, 'jeep'),
(10, 4, '2021-10-15', 'morning', 10, 'jeep'),
(1, 5, '2021-01-31', 'morning', 10, 'jeep'),
(3, 7, '2022-09-04', 'noon', 15, 'bus'),
(5, 4, '2021-07-28', 'evening', 9, 'bus'),
(7, 10, '2021-01-25', 'morning', 20, 'jeep'),
(9, 4, '2022-09-25', 'morning', 10, 'jeep'),
(2, 14, '2022-08-28', 'evening', 9, 'bus'),
(4, 10, '2021-01-25', 'morning', 20, 'jeep'),
(6, 4, '2022-09-25', 'morning', 10, 'jeep');

SELECT * FROM SafariRideBookings; 

-- -------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO MedicalSupplies ( Name, Description, Quantity, SupplierInfo, CostPerUnit) VALUES 
('Vitamin C Tablets', 'Supplement for primates', 100, 'ABC Inc.', 20),
('Antibiotic Ointment', 'Antibiotic ointment for minor injuries', 50, 'XYZ Corp.', 30),
('Disinfectant Spray', 'Disinfectant spray for cages and enclosures', 200, 'PQR Ltd.', 15),
('Oral Rehydration Salts', 'For dehydration in birds', 75, 'DEF Inc.', 10),
('Feather Conditioning Oil', 'For grooming and conditioning feathers', 40, 'LMN Corp.', 25),
('Birdseed Mix', 'Mixed birdseed for feeding birds', 150, 'GHI Ltd.', 5),
('Sterilized Bandages', 'Bandages for wound care', 60, 'ABC Inc.', 8),
('Topical Cream', 'For treating skin conditions in reptiles', 30, 'PQR Ltd.', 40),
('Heat Lamps', 'Lamps for providing warmth in enclosures', 20, 'STU Corp.', 20),
( 'Anti-inflammatory Medication', 'For treating inflammation in large mammals', 25, 'ABC Inc.', 50),
( 'Pain Medication', 'For treating pain in large mammals', 20, 'XYZ Corp.', 60),
( 'Hoof Trimmers', 'For trimming hooves in large mammals', 10, 'PQR Ltd.', 35),
( 'Fish Food Pellets', 'Pellets for feeding fish', 100, 'DEF Inc.', 5),
( 'Water Testing Kit', 'For testing water quality in aquariums', 5, 'LMN Corp.', 100),
( 'Aquarium Salt', 'For maintaining proper water chemistry in aquariums', 20, 'GHI Ltd.', 15);

SELECT * FROM MedicalSupplies; 

-- -------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO FoodSupplies( Name, Description, Quantity, SupplierInfo, CostPerUnit) VALUES
('Hay', 'Dried grass used as animal feed', 100, 'ABC Farms', 50),
('Fruits', 'Fresh fruits for primates', 50, 'XYZ Farms', 100),
('Meat', 'Fresh meat for carnivorous animals', 75, 'Meat Lovers Inc.', 150),
('Grains', 'Various grains for birds and rodents', 200, 'Agro Foods', 25),
('Fish', 'Frozen fish for penguins and otters', 150, 'Seafood Inc.', 80),
('Vegetables', 'Fresh vegetables for herbivorous animals', 100, 'Green Farms', 40),
('Kibble', 'Dry dog food for domesticated animals', 50, 'Pet Foods Inc.', 20),
('Mice', 'Live mice for reptile feeding', 200, 'Rodent Supplies', 2),
('Insects', 'Live insects for insectivorous animals', 150, 'Bug Farms', 5),
( 'Hay', 'Dried grass used as animal feed', 75, 'ABC Farms', 50),
( 'Carrots', 'Fresh carrots for herbivorous animals', 50, 'Farm Fresh', 30),
( 'Fish', 'Frozen fish for sea lions and otters', 100, 'Seafood Inc.', 75),
( 'Fruits', 'Fresh fruits for primates', 100, 'XYZ Farms', 80),
( 'Kibble', 'Dry cat food for domesticated animals', 75, 'Pet Foods Inc.', 30),
( 'Seeds', 'Various seeds for birds', 200, 'Agro Foods', 15);

SELECT * FROM FoodSupplies; 

-- -------------------------------------------------------------------------------------------------------------------------------------


