CREATE DATABASE airline_analysis;
USE airline_analysis;

SELECT * FROM airline_flights

#Q1. What is the total number of passengers, total flights, total revenue, average ticket fare, and average flight delay?
SELECT
    COUNT(DISTINCT Passenger_ID) AS Total_Passengers,
    COUNT(DISTINCT Flight_ID) AS Total_Flights,
    SUM(Ticket_Fare) AS Total_Revenue,
    ROUND(AVG(Ticket_Fare), 2) AS Avg_Ticket_Fare,
    ROUND(AVG(Delay_Minutes), 2) AS Avg_Delay_Minutes
FROM airline_flights;


#Q2. How do airlines compare in terms of passenger volume, revenue, and average flight delay?
SELECT
    Airline,
    COUNT(DISTINCT Passenger_ID) AS Total_Passengers,
    COUNT(DISTINCT Flight_ID) AS Total_Flights,
    SUM(Ticket_Fare) AS Total_Revenue,
    ROUND(AVG(Ticket_Fare), 2) AS Avg_Fare,
    ROUND(AVG(Delay_Minutes), 2) AS Avg_Delay
FROM airline_flights
GROUP BY Airline
ORDER BY Total_Passengers DESC;


#Q3. How does flight status vary across airlines?
SELECT
    Airline,
    Flight_Status,
    COUNT(*) AS Total_Flights
FROM airline_flights
GROUP BY Airline, Flight_Status
ORDER BY Airline, Total_Flights DESC;


#Q4. What is the cancellation rate for each airline?
SELECT
    Airline,
    COUNT(DISTINCT Flight_ID) AS Total_Flights,
    COUNT(DISTINCT CASE
        WHEN Cancellation_Status = 'Cancelled' THEN Flight_ID
    END) AS Cancelled_Flights,
    ROUND(
        100.0 * COUNT(DISTINCT CASE
            WHEN Cancellation_Status = 'Cancelled' THEN Flight_ID
        END)
        / COUNT(DISTINCT Flight_ID),
        2
    ) AS Cancellation_Rate
FROM airline_flights
GROUP BY Airline
ORDER BY Cancellation_Rate DESC;


#Q5. How does passenger satisfaction vary with average flight delay?
SELECT
    Passenger_Satisfaction,
    COUNT(*) AS Total_Passengers,
    ROUND(AVG(Delay_Minutes), 2) AS Avg_Delay
FROM airline_flights
GROUP BY Passenger_Satisfaction
ORDER BY Passenger_Satisfaction;


#Q6. How does travel class affect passenger volume, revenue, and average fare?
SELECT
    Travel_Class,
    COUNT(DISTINCT Passenger_ID) AS Total_Passengers,
    SUM(Ticket_Fare) AS Total_Revenue,
    ROUND(AVG(Ticket_Fare), 2) AS Avg_Fare
FROM airline_flights
GROUP BY Travel_Class
ORDER BY Total_Passengers DESC;


#Q7. Which routes have the highest passenger volume and revenue?
SELECT
    Origin_Airport,
    Destination_Airport,
    COUNT(DISTINCT Passenger_ID) AS Total_Passengers,
    COUNT(DISTINCT Flight_ID) AS Total_Flights,
    SUM(Ticket_Fare) AS Total_Revenue
FROM airline_flights
GROUP BY Origin_Airport, Destination_Airport
ORDER BY Total_Passengers DESC
LIMIT 10;


#Q8. How does booking channel affect passenger volume and revenue?
SELECT
    Booking_Channel,
    COUNT(DISTINCT Passenger_ID) AS Total_Passengers,
    SUM(Ticket_Fare) AS Total_Revenue,
    ROUND(AVG(Ticket_Fare), 2) AS Avg_Fare
FROM airline_flights
GROUP BY Booking_Channel
ORDER BY Total_Passengers DESC;


#Q9. Which airlines generate the highest revenue per flight?
SELECT
    Airline,
    COUNT(DISTINCT Flight_ID) AS Total_Flights,
    SUM(Ticket_Fare) AS Total_Revenue,
    ROUND(
        SUM(Ticket_Fare) / COUNT(DISTINCT Flight_ID),
        2
    ) AS Revenue_Per_Flight
FROM airline_flights
GROUP BY Airline
ORDER BY Revenue_Per_Flight DESC;


#Q10. Which months have the highest number of passengers and total revenue?
SELECT
    MONTH(Flight_Date) AS Flight_Month,
    COUNT(DISTINCT Passenger_ID) AS Total_Passengers,
    SUM(Ticket_Fare) AS Total_Revenue
FROM airline_flights
GROUP BY MONTH(Flight_Date)
ORDER BY Total_Passengers DESC;


#Q11. Which routes have the highest average flight delay?
SELECT
    Origin_Airport,
    Destination_Airport,
    COUNT(DISTINCT Flight_ID) AS Total_Flights,
    ROUND(AVG(Delay_Minutes), 2) AS Avg_Delay
FROM airline_flights
GROUP BY Origin_Airport, Destination_Airport
HAVING COUNT(DISTINCT Flight_ID) >= 50
ORDER BY Avg_Delay DESC
LIMIT 10;


#Q12. How does cancellation rate vary across travel classes?
SELECT
    Travel_Class,
    COUNT(DISTINCT Flight_ID) AS Total_Flights,
    COUNT(DISTINCT CASE
        WHEN Cancellation_Status = 'Cancelled' THEN Flight_ID
    END) AS Cancelled_Flights,
    ROUND(
        100.0 * COUNT(DISTINCT CASE
            WHEN Cancellation_Status = 'Cancelled' THEN Flight_ID
        END)
        / COUNT(DISTINCT Flight_ID),
        2
    ) AS Cancellation_Rate
FROM airline_flights
GROUP BY Travel_Class
ORDER BY Cancellation_Rate DESC;


#Q13. Which aircraft types generate the highest revenue and carry the most passengers?
SELECT
    Aircraft_Type,
    COUNT(DISTINCT Passenger_ID) AS Total_Passengers,
    COUNT(DISTINCT Flight_ID) AS Total_Flights,
    SUM(Ticket_Fare) AS Total_Revenue,
    ROUND(AVG(Delay_Minutes), 2) AS Avg_Delay
FROM airline_flights
GROUP BY Aircraft_Type
ORDER BY Total_Revenue DESC;