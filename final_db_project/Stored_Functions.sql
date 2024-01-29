SELECT * FROM HabitatAreas;

-- 1.List of Medical Supplies and their cost for a particular Sanctuary 
DELIMITER $$

CREATE FUNCTION GetMedicalSuppliesInSanctuary(sanctuaryID INT)
RETURNS VARCHAR(5000)
DETERMINISTIC
BEGIN
    DECLARE medicalSupplyName VARCHAR(100);
    DECLARE totalCost DECIMAL(10, 2);
    DECLARE output varchar(5000) DEFAULT '';
    DECLARE done INT DEFAULT FALSE;
    
    DECLARE cur CURSOR FOR
        SELECT MedicalSupplies.Name, SUM(MedicalSupplies.Quantity * MedicalSupplies.CostPerUnit) AS TotalCost
        FROM MedicalSupplies
        INNER JOIN Sanctuaries ON MedicalSupplies.SanctuaryID = Sanctuaries.SanctuaryID
        WHERE Sanctuaries.SanctuaryID = sanctuaryID
        GROUP BY MedicalSupplies.Name;
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cur;
    
   
    
   WHILE NOT done DO
        FETCH cur INTO medicalSupplyName, totalCost;
        IF NOT done THEN
            SET output = CONCAT(output, medicalSupplyName, ' ', totalCost, '--------');
        END IF;
    END WHILE;

    CLOSE cur;
    
    return output;
    
END $$

DELIMITER ;

SELECT (GetMedicalSuppliesInSanctuary(1)) AS MedicalSuppliesCosting;

-- -----------------------------------------------------------------------------
-- 2.Function for adding a doctor to a sanctuary

DELIMITER $$
CREATE FUNCTION addDoctorToSanctuary(
  doctorFirstName VARCHAR(100),
  doctorLastName VARCHAR(100),
  doctorSpecialization VARCHAR(100),
  sanctuaryIDParam INT
) 
RETURNS VARCHAR(200)
DETERMINISTIC
BEGIN
  DECLARE SanctuaryName VARCHAR(50);
  INSERT INTO Doctors (FirstName, LastName, Specialization, SanctuaryID)
  VALUES (doctorFirstName, doctorLastName, doctorSpecialization, sanctuaryIDParam);
  
  SELECT name INTO SanctuaryName FROM Sanctuaries WHERE SanctuaryID = sanctuaryIDParam;
  
  RETURN CONCAT('Doctor ', doctorFirstName, ' ', doctorLastName, ' has been added to Sanctuary ', SanctuaryName);
END$$
DELIMITER ;

SELECT addDoctorToSanctuary('Dhaval','Desai','Zoo Veterinarian',2) AS OUTPUT;


-- ----------------------------------------------------------

-- 3.Function to get the total number of bookings for a given passenger in all sanctuaries:

DELIMITER $$

CREATE FUNCTION getTotalBookingsForPassenger(passenger_name VARCHAR(200))
RETURNS VARCHAR(1000)
DETERMINISTIC
BEGIN

DECLARE Safari_date  DATE;
DECLARE safari_slot VARCHAR(20);
DECLARE SanctuaryName VARCHAR(50);
DECLARE done INT DEFAULT FALSE;
DECLARE output varchar(1000) DEFAULT '';

	DECLARE cur CURSOR FOR SELECT SafariRideBookings.Date,SafariRideBookings.Slots,Sanctuaries.name  FROM SafariRideBookings 
		JOIN Passengers ON SafariRideBookings.SafariRideBookingID = Passengers.SafariRideBookingID
        JOIN Sanctuaries ON Sanctuaries.SanctuaryID = SafariRideBookings.SanctuaryID
        WHERE Passengers.name = passenger_name;

		
        
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
		OPEN cur;
        
        SET output = 'Previous Safari Trips ';
        
        WHILE NOT done DO
        FETCH cur INTO Safari_date,safari_slot,SanctuaryName;
        IF NOT done THEN
            SET output = CONCAT(output,  '  Safari Date : ', Safari_date , '   Safari Slot : ',safari_slot,' Sanctuary Name : ',SanctuaryName,
            '.           .');
        END IF;
    END WHILE;
        
    CLOSE cur;
    
    return output;
END $$

DELIMITER ;

SELECT getTotalBookingsForPassenger('Priya Patel') AS OUTPUT;

-- -----------------------------------------------------------------------

SELECT * FROM Animals;

-- ------------------------------------------------------------------
-- 4. Generate Safari Report and Calculate total revenue within date Range

DROP FUNCTION IF EXISTS GetSafariRideReport;
DELIMITER $$

CREATE FUNCTION GetSafariRideReport(startDate DATE, endDate DATE)
RETURNS VARCHAR(1000)
DETERMINISTIC
BEGIN

DECLARE vehicleTypeParam VARCHAR(100);
	DECLARE finished INT DEFAULT 0;
    DECLARE numOfPassengers INT;
    DECLARE distance INT;
    DECLARE revenue DECIMAL(10, 2);
    DECLARE totalRevenue DECIMAL(10, 2) DEFAULT 0;
    DECLARE report VARCHAR(1000) DEFAULT '';
	
    
    


    DECLARE vehicleCursor CURSOR FOR 
        SELECT DISTINCT VehicleType 
        FROM SafariRideBookings
        WHERE Date >= startDate AND Date <= endDate;
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
    
    -- loop through each vehicle type
    OPEN vehicleCursor;
    
    read_loop: LOOP
        -- fetch the next row
        FETCH vehicleCursor INTO vehicleTypeParam;
        
        -- exit loop if no more rows
        IF finished = 1 THEN
            LEAVE read_loop;
        END IF;
        
        -- calculate total passengers, distance, and revenue for the vehicle type
        SELECT SUM(NumOfPeople), SUM(Distance) 
        INTO numOfPassengers, distance 
        FROM SafariRideBookings 
        WHERE VehicleType = vehicleTypeParam AND Date >= startDate AND Date <= endDate;
        
        SET revenue = distance * 10.0; 
        
        -- concatenate the intermedia
        
           SET report = CONCAT(report, 'In ',vehicleTypeParam, ' No of passengers visited', numOfPassengers , ' And distance covered ', distance , ' and revenue generated ',revenue ,' | ');
        
        SET totalRevenue = totalRevenue + revenue;
    END LOOP;
    
    -- concatenate the total revenue to the report string
    SET report = CONCAT(report, '| Total Revenue Generated: Rs. ', totalRevenue);
    
   return report;
END$$

DELIMITER ;

SELECT GetSafariRideReport('2021-05-01','2023-05-31') AS OUTPUT;

-- ------------------------------------------------------------------------------------    
-- 5. retrieve the name of the sanctuary with the highest population of a given animal species

DROP PROCEDURE IF EXISTS Sanctuary_With_Highest_Population;
DELIMITER $$


CREATE FUNCTION Sanctuary_With_Highest_Population(TypeParam VARCHAR(100))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE sanctuary_name VARCHAR(100);
    
    SELECT s.Name 
    INTO sanctuary_name
    FROM Sanctuaries s 
    INNER JOIN Animals a ON s.SanctuaryID = a.SanctuaryID 
    WHERE a.Type = TypeParam
    ORDER BY a.Population DESC 
    LIMIT 1;
    
    RETURN sanctuary_name;
END$$

DELIMITER ; 

SELECT Sanctuary_With_Highest_Population('Mammal') AS OUTPUT;
