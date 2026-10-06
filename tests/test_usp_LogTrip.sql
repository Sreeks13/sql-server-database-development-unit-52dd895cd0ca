USE TaxiDB;
GO

DECLARE @NewTripID INT;

EXEC dbo.uspLogTrip
    @PassengerName = 'Asha',
    @DriverName = 'Ravi',
    @DistanceKm = 12.50,
    @FarePerKm = 40.00,
    @NewTripID = @NewTripID OUTPUT;

PRINT 'Generated TripID = ' + CAST(@NewTripID AS VARCHAR(20));

IF @NewTripID IS NULL OR @NewTripID <= 0
    THROW 50001, 'Test failed: TripID was not generated.', 1;

IF NOT EXISTS
(
    SELECT 1
    FROM dbo.Trips
    WHERE TripID = @NewTripID
      AND PassengerName = 'Asha'
      AND DriverName = 'Ravi'
      AND DistanceKm = 12.50
      AND Fare = 500.00
)
    THROW 50002, 'Test failed: Trip was not inserted or fare is incorrect.', 1;

PRINT 'PASS: Trip inserted and fare calculated correctly.';
GO
