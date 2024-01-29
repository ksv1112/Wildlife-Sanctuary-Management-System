SELECT * FROM Animals;




-- 1. Procedure to add an animal
DELIMITER $$

CREATE PROCEDURE AddNewAnimal (
  IN animalType VARCHAR(100),
  IN animalSpecies VARCHAR(100),
  IN animalPopulation INT,
  IN rangeOfExtinction VARCHAR(100),
  IN animalLifespan INT,
  IN sanctuaryId INT
)
BEGIN
  INSERT INTO Animals (Type, Species, Population, RangeOfExtinction, Lifespan, SanctuaryID)
  VALUES (animalType, animalSpecies, animalPopulation, rangeOfExtinction, animalLifespan, sanctuaryId);
END $$

DELIMITER ;


CALL AddNewAnimal('Mammal', 'Snow Leopard', 7000, 'Endangered', 12, 1);

-- ---------------------------------------------------------------------------------
SELECT * FROM Passengers;
SELECT * FROM SafariRideBookings;

-- 2. SP to Book Tickets
DELIMITER $$

CREATE PROCEDURE AddSafariRideBooking(IN p_NumOfPeople INT, IN p_Date DATE, IN p_Slots VARCHAR(100), IN p_Distance INT, IN p_VehicleType VARCHAR(100), IN p_Name VARCHAR(100), IN p_ContactNumber VARCHAR(100), IN p_Email VARCHAR(100), IN p_Birthdate DATE, IN p_SanctuaryID INT)
BEGIN
  DECLARE v_SafariRideBookingID INT;
  
  INSERT INTO SafariRideBookings (NumOfPeople, Date, Slots, Distance, VehicleType,SanctuaryID) 
  VALUES (p_NumOfPeople, p_Date, p_Slots, p_Distance, p_VehicleType,p_SanctuaryID);
  
  SET v_SafariRideBookingID = LAST_INSERT_ID();
  
  INSERT INTO Passengers (Name, ContactNumber, Email, Birthdate, SanctuaryID, SafariRideBookingID) 
  VALUES (p_Name, p_ContactNumber, p_Email, p_Birthdate, p_SanctuaryID, v_SafariRideBookingID);
  
  UPDATE SafariRideBookings SET NumOfPeople = NumOfPeople + p_NumOfPeople WHERE SafariRideBookingID = v_SafariRideBookingID;
END $$

DELIMITER ;

CALL AddSafariRideBooking(30, '2021-05-31', 'evening', 10, 'Jeep', 'Aman Singh', '897654321', 'Aman@example.com', '1983-05-01', 4);

-- ---------------------------------------------------------------------------------------------------------------


SELECT * FROM Sanctuaries;
SELECT * FROM SafariRideBookings;

--  Procedure to retrieve the list of passengers who have booked safari rides for a given date and time slot , given sanctuary and safari ride booking information:


DELIMITER $$

CREATE PROCEDURE GetPassengersForSafariRide(IN DateParam DATE, IN SlotParam VARCHAR(100),IN SanctuaryIDParam INT)
BEGIN
  SELECT p.Name, s.Name AS Sanctuary, s.City, s.State, s.Country, s.AreaSize, s.Description, s.SanctuaryID, srb.NumOfPeople, srb.Distance, srb.VehicleType
  FROM Passengers p
  JOIN SafariRideBookings srb ON p.SafariRideBookingID = srb.SafariRideBookingID
  JOIN Sanctuaries s ON srb.SanctuaryID = s.SanctuaryID
  WHERE srb.Date = DateParam 
  AND srb.Slots = SlotParam
  AND s.SanctuaryID = SanctuaryIDParam;
  
END $$

DELIMITER ;


CALL GetPassengersForSafariRide('2022-07-25','noon',1);


-- -----------------------------------------------------------------------------------------------------


-- 4.Procedures full details regarding a particular sanctuary

DELIMITER $$


CREATE PROCEDURE GetSanctuaryStats(IN SanctuaryIDParam INT)
BEGIN
    DECLARE TotalAnimals INT DEFAULT 0;
    DECLARE TotalEmployees INT DEFAULT 0;
    DECLARE TotalDoctors INT DEFAULT 0;
    DECLARE TotalHabitatAreas INT DEFAULT 0;
    DECLARE TotalTrees INT DEFAULT 0;
    DECLARE TotalBirds INT DEFAULT 0;
    DECLARE TotalPassengers INT DEFAULT 0;
    DECLARE TotalSafariRideBookings INT DEFAULT 0;
    DECLARE TotalMedicalSupplies INT DEFAULT 0;
    DECLARE TotalFoodSupplies INT DEFAULT 0;
    DECLARE i INT DEFAULT 0;
    DECLARE numHabitatAreas INT DEFAULT 0;
    DECLARE numTrees INT DEFAULT 0;
    DECLARE numBirds INT DEFAULT 0;
    DECLARE numPassengers INT DEFAULT 0;
    DECLARE numSafariRideBookings INT DEFAULT 0;
    DECLARE numMedicalSupplies INT DEFAULT 0;
    DECLARE numFoodSupplies INT DEFAULT 0;
    DECLARE No_Of_People_Visited INT DEFAULT 0;

    -- Get total number of animals in the sanctuary
    SELECT COUNT(*) INTO TotalAnimals FROM Animals WHERE SanctuaryID = SanctuaryIDParam;

    -- Get total number of employees in the sanctuary
    SELECT COUNT(*) INTO TotalEmployees FROM Employees WHERE SanctuaryID = SanctuaryIDParam;

    -- Get total number of doctors in the sanctuary
    SELECT COUNT(*) INTO TotalDoctors FROM Doctors WHERE SanctuaryID = SanctuaryIDParam;
		
    -- Get total number of habitat areas in the sanctuary
    SELECT COUNT(*) INTO TotalHabitatAreas FROM HabitatAreas WHERE SanctuaryID = SanctuaryIDParam;

    -- Get total number of trees in the sanctuary
    SELECT COUNT(*) INTO TotalTrees FROM Trees WHERE HabitatAreaID IN (SELECT HabitatAreaID FROM HabitatAreas WHERE SanctuaryID = SanctuaryIDParam);

    -- Get total number of birds in the sanctuary
    SELECT COUNT(*) INTO TotalBirds FROM Birds WHERE SanctuaryID = SanctuaryIDParam;

    -- Get total number of safari ride bookings in the sanctuary
    SELECT COUNT(*) INTO TotalSafariRideBookings FROM SafariRideBookings WHERE SanctuaryID = SanctuaryIDParam;

	SELECT SUM(NumOfPeople) INTO No_Of_People_Visited FROM 	SafariRideBookings WHERE SanctuaryID = SanctuaryIDParam;
    -- Get total number of medical supplies in the sanctuary
    SELECT COUNT(*) INTO TotalMedicalSupplies FROM MedicalSupplies WHERE SanctuaryID = SanctuaryIDParam;

    -- Get total number of food supplies in the sanctuary
    SELECT COUNT(*) INTO TotalFoodSupplies FROM FoodSupplies WHERE SanctuaryID = SanctuaryIDParam;
    
    SELECT TotalAnimals,TotalEmployees,TotalDoctors,TotalHabitatAreas,TotalTrees,TotalBirds,TotalSafariRideBookings,No_Of_People_Visited,TotalMedicalSupplies,TotalFoodSupplies;

END $$

DELIMITER ;

CALL GetSanctuaryStats(4);

-- ----------------------------------------------------------------------------------------
-- 5. stored procedure that increases the salary of all employees in a given department at a given sanctuary by a given percentage:

DELIMITER $$

CREATE PROCEDURE IncreaseSalaryByDepartment(
    IN SanctuaryIDParam INT,
    IN DepartmentParam VARCHAR(100),
    IN PercentageParam DECIMAL(10,2)
)
BEGIN
    UPDATE Employees
    SET Salary = Salary * (1 + PercentageParam/100)
    WHERE SanctuaryID = SanctuaryIDParam AND Department = DepartmentParam;
END $$

DELIMITER ;

CALL IncreaseSalaryByDepartment(1,'Tourism',15);

-- SELECT * FROM Employees WHERE Department = 'Tourism' AND SanctuaryID = 1;

-- ----------------------------------------------------------------------------------

-- 6. Procedure to get the top 3 most booked safari ride dates for a specific sanctuary:
DROP PROCEDURE IF EXISTS GetTop3SafariRideDates;
DELIMITER $$

CREATE PROCEDURE GetTop3SafariRideDates(
    IN SanctuaryNameParam VARCHAR(100)
)
BEGIN
    SELECT Date, COUNT(*) AS NumOfBookings
    FROM (
        SELECT DISTINCT sr.SafariRideBookingID, sr.Date
        FROM Sanctuaries s
        JOIN SafariRideBookings sr ON s.SanctuaryID = sr.SanctuaryID
        WHERE s.Name = SanctuaryNameParam
    ) AS temp
    GROUP BY Date
    ORDER BY NumOfBookings DESC
    LIMIT 3;
END $$

DELIMITER ;

CALL GetTop3SafariRideDates('Kanha National Park');
-- --------------------------------------

-- 7 . Procedure to get the list of all habitat areas that have a population of birds greater than the average population of birds in all habitat areas of a specific sanctuary: 

DELIMITER $$

CREATE PROCEDURE GetHabitatAreasWithHighBirdPopulation(
    IN SanctuaryNameParam VARCHAR(100)
)
BEGIN
    SELECT ha.Name AS HabitatArea, b.Population
    FROM Sanctuaries s
    JOIN HabitatAreas ha ON s.SanctuaryID = ha.SanctuaryID
    JOIN Birds b ON ha.HabitatAreaID = b.HabitatAreaID
    WHERE s.Name = SanctuaryNameParam AND b.Population > (
        SELECT AVG(b2.Population)
        FROM Birds b2
        JOIN HabitatAreas ha2 ON b2.HabitatAreaID = ha2.HabitatAreaID
        JOIN Sanctuaries s2 ON ha2.SanctuaryID = s2.SanctuaryID
        WHERE s2.Name = SanctuaryNameParam
    );
END $$

DELIMITER ;

CALL GetHabitatAreasWithHighBirdPopulation('Sundarbans National Park');

-- ------------------------------------------------------------------------------------

-- 8. Stored procedure to update the population of a given bird species in all sanctuaries by a given percentage: 

SELECT * FROM Birds WHERE Type = 'Raptor';



DELIMITER $$
CREATE PROCEDURE UpdateBirdPopulation(
    IN BirdTypeParam VARCHAR(100),
    IN PopulationIncreasePercentage DECIMAL(5, 2)
)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE currentSanctuaryID INT;
    DECLARE currentPopulation INT;
    
    -- Declare cursor for the Sanctuaries table
    DECLARE sanctuaryCursor CURSOR FOR SELECT SanctuaryID FROM Sanctuaries;
    
    -- Declare continue handler for the cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    -- Open the cursor
    OPEN sanctuaryCursor;
    
    -- Loop through each row of the cursor
    sanctuary_loop: LOOP
        -- Fetch the next row of the cursor
        FETCH sanctuaryCursor INTO currentSanctuaryID;
        
        -- Exit loop if there are no more rows to fetch
        IF done THEN
            LEAVE sanctuary_loop;
        END IF;
        
        -- Get the current population of the given bird species in the sanctuary
        SELECT Population INTO currentPopulation FROM Birds WHERE Type = BirdTypeParam AND SanctuaryID = currentSanctuaryID;
        
        -- Calculate the new population after the percentage increase
        SET currentPopulation = currentPopulation + (currentPopulation * PopulationIncreasePercentage / 100);
        
        -- Update the bird population in the current sanctuary
        UPDATE Birds SET Population = currentPopulation WHERE Type = BirdTypeParam AND SanctuaryID = currentSanctuaryID;
    END LOOP;
    
    -- Close the cursor
    CLOSE sanctuaryCursor;
END $$
DELIMITER ;



CALL UpdateBirdPopulation('Raptor',50);
-- --------------