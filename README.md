# Airline-Analysis-using-SQL

**Business Problem:**

The aviation company faces a challenge in enhancing its overall business performance by optimizing various aspects of its operations. 
The main challenges include:
1.	Optimizing the fleet composition based on passenger preferences and operational efficiency.
2.	Implementing targeted marketing strategies to enhance customer engagement and loyalty.
3.	Planning and executing operational expansions, particularly in identifying potential hub airports for improved connectivity.
4.	Strategically identifying peak revenue seasons for effective promotional planning. 
The airline aims to leverage data-driven insights to make informed decisions in these areas, ultimately improving customer satisfaction, maximizing revenue, and positioning itself for sustained growth in the competitive aviation market.

**Objectives for the Project:**

1.	Customer Segmentation and Preferences:
•	Understand customer demographics and travel preferences.
•	Identify patterns in gender and travel class preferences.
2.	Airport Optimization:
•	Determine the busiest departure airports.
•	Identify potential hub airports for operational planning.
•	Analyze destination airports for arrival patterns.
3.	Route Optimization:
•	Identify the longest and shortest flight routes for strategic planning.
•	Categorize routes into short, intermediate, and long distances.
4.	Revenue Management:
•	Optimize pricing strategies based on historical ticket sales and customer preferences.
•	Identify the most profitable travel classes.
•	Analyze yearly revenue trends and monthly variations.
5.	Customer Booking Insights:
•	Identify customers with the highest number of ticket bookings.
•	Determine passengers traveling by specific classes for targeted services.
•	Implement a function to specify if complimentary services are provided for specific travel classes.

The analysis and insights provided through SQL queries form the basis for informed decision-making in addressing the identified challenges and achieving the set objectives.

**About the Dataset:**

There are four tables in the "aviation" database namely: `passengersonflight`, `customer`, `routes`, and `ticketdetails`. 
Below is a summary of each table:

1. passengersonflight Table:
•	Columns: passenger_id, flight_id, customer_id, route_id, travel_class, seat_number.
•	Foreign Key Constraints: 
o	`fk` on `customer_id` referencing `customer(customer_id)`.
o	`fk2` on `route_id` referencing `routes(route_id)`.
 

2. customer Table:
•	Columns: customer_id, first_name, last_name, email, phone_number.
•	Primary Key Constraint: `pk` on `customer_id`. 

3. routes Table:
•	Columns: route_id, departure_airport, arrival_airport, distance, duration.
•	Primary Key Constraint: `pk1` on `route_id`.
 
4. ticketdetails Table:
•	Columns: ticket_id, customer_id, flight_id, ticket_price, purchase_date.
•	 Foreign Key Constraint: `fk1` on `customer_id` referencing `customer(customer_id)`.

 
**TASKS PERFORMED:**

1. **Database Setup:**
   - Created a new database named "aviation."
   - Defined tables: `passengersonflight`, `customer`, `routes`, and `ticketdetails`.
   - Established foreign key relationships for data integrity.

2. **ER Diagram:**
   - Included a visual representation of the entity-relationship diagram to showcase the database structure.

3. **Aircraft Analysis:**
   - Identified four types of aircraft: Airbus A321, Boeing 767-301ER, Embraer ERJ142, and Bombardier CRJ900.
   - Analyzed ticket sales per aircraft type, revealing Boeing 767-301ER as the most popular.

4. **Customer Segmentation and Preferences:**
   - Explored customer demographics and travel preferences, including gender and travel class preferences.
   - Identified that males predominantly booked tickets in the Business class.

5. **Airport Optimization:**
   - Determined busiest departure airports (e.g., HNL, EWR, LAX).
   - Identified popular destination airports (e.g., LAX, EWR).

6. **Route Optimization:**
   - Analyzed longest and shortest flight routes for strategic planning.
   - Categorized routes into short, intermediate, and long distances.

7. **Revenue Management:**
   - Optimized pricing strategies based on historical ticket sales and customer preferences.
   - Identified most profitable travel classes (e.g., Business class).

8. **Customer Booking Insights:**
   - Identified customers with the highest number of ticket bookings.
   - Implemented a function to specify if complimentary services are provided for specific travel classes.

9. **Yearly and Monthly Revenue Trends:**
   - Analyzed yearly revenue trends, showing growth from 2018 to 2019 and further growth in 2020.
   - Explored monthly revenue variations across different years, identifying high-revenue months.

10. **Advanced Analysis using Window Functions, Rollup, and Stored Procedures:**
    - Examined the number of tickets booked by passengers, identifying top customers.
    - Identified passengers traveling by Business class for potential complementary service considerations.
    - Utilized window functions to find maximum ticket prices for each class.
    - Employed rollup function to calculate the total price of tickets booked by a customer across different aircraft IDs.
    - Developed stored procedures to extract details based on route ranges, distance categories, and complimentary services.


**Conclusion:**

 In conclusion, the SQL analysis of the aviation company's dataset yielded actionable insights for strategic decision-making. 
•	For instance, the identification of Boeing 767-301ER as the preferred aircraft suggests potential fleet optimization strategies.
•	The observation that male customers predominantly choose Business class highlights an opportunity for targeted marketing and services tailored to this demographic. 
•	The exploration of departure and destination airports, such as HNL(Honolulu International Airport) and LAX (Los Angeles International Airport), provides a basis for operational planning and potential hub expansion.
•	 The examination of revenue by class underscores the significance of premium classes like Business and First Class in generating higher total revenue.
•	The identification of peak revenue months like March and November enables strategic promotional planning. 
•	The use of stored procedures and functions further streamlines data extraction for ongoing analysis, supporting the aviation company's goal of sustained growth and enhanced customer satisfaction.



HAPPY ANALYZING !!!

