USE TaxiDB;
GO

CREATE OR ALTER PROCEDURE dbo.uspLogTrip
    @PassengerName NVARCHAR(100),
    @DriverName NVARCHAR(100),
    @DistanceKm DECIMAL(10,2),
    @FarePerKm DECIMAL(10,2),
    @NewTripID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Fare DECIMAL(10,2);

    SET @Fare = @DistanceKm * @FarePerKm;

    INSERT INTO dbo.Trips
    (
        PassengerName,
        DriverName,
        DistanceKm,
        FarePerKm,
        Fare
    )
    VALUES
    (
        @PassengerName,
        @DriverName,
        @DistanceKm,
        @FarePerKm,
        @Fare
    );

    SET @NewTripID = CONVERT(INT, SCOPE_IDENTITY());

    SELECT
        TripID,
        PassengerName,
        DriverName,
        DistanceKm,
        FarePerKm,
        Fare
    FROM dbo.Trips
    WHERE TripID = @NewTripID;
END;
GO
