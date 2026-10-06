USE TaxiDB;
GO

DECLARE @NewTripID INT;

EXEC dbo.uspLogTrip
    @PassengerName = N'Asha',
    @DriverName = N'Ravi',
    @DistanceKm = 12.50,
    @FarePerKm = 40.00,
    @NewTripID = @NewTripID OUTPUT;

PRINT 'Generated TripID = ' + CAST(@NewTripID AS VARCHAR(20));

IF @NewTripID IS NULL OR @NewTripID <= 0
    THROW 50001, 'FAIL: TripID was not generated.', 1;

IF NOT EXISTS
(
    SELECT 1
    FROM dbo.Trips
    WHERE TripID = @NewTripID
      AND PassengerName = N'Asha'
      AND DriverName = N'Ravi'
      AND DistanceKm = 12.50
      AND FarePerKm = 40.00
      AND Fare = 500.00
)
    THROW 50002, 'FAIL: Trip or fare calculation is incorrect.', 1;

PRINT 'PASS: Trip inserted successfully.';
PRINT 'PASS: Fare calculated correctly.';
PRINT 'PASS: OUTPUT TripID returned successfully.';
GO
