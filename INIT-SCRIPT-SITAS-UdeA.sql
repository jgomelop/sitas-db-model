Create table
  IdentificationType (
    identification_type_id NUMBER GENERATED BY DEFAULT AS IDENTITY (
      START
      WITH
        1 INCREMENT BY 1
    ) PRIMARY KEY,
    identification_type VARCHAR2 (20) NOT NULL
  );

Create table
  Person (
    person_id NUMBER GENERATED BY DEFAULT AS IDENTITY (
      START
      WITH
        1 INCREMENT BY 1
    ) PRIMARY KEY,
    id_identification_type NUMBER REFERENCES IdentificationType (identification_type_id) ON DELETE CASCADE,
    identification_number VARCHAR2 (20) NOT NULL,
    first_name VARCHAR2 (200) NOT NULL,
    last_name VARCHAR2 (200) NOT NULL,
    genre CHAR(1) NOT NULL,
    birth_date DATE NOT NULL,
    phone_number VARCHAR2 (20) NOT NULL,
    country VARCHAR2 (50) NOT NULL,
    province VARCHAR2 (50) NOT NULL,
    city VARCHAR2 (50) NOT NULL,
    residence VARCHAR2 (200) NOT NULL,
    email VARCHAR2 (200) NOT NULL,
    access_key VARCHAR2 (200) NOT NULL
  );

Create table
  Position(
    position_id NUMBER GENERATED BY DEFAULT AS IDENTITY (
      START
      WITH
        1 INCREMENT BY 1
    ) PRIMARY KEY,
    position_name VARCHAR2 (50) NOT NULL,
    detail VARCHAR2 (500) NOT NULL
  );

Create table
  Privilege (
    privilege_id NUMBER GENERATED BY DEFAULT AS IDENTITY (
      START
      WITH
        1 INCREMENT BY 1
    ) PRIMARY KEY,
    privilege_name VARCHAR2 (50) NOT NULL,
    detail VARCHAR2 (500) NOT NULL
  );

Create table
  PersonPosition (
    person_position_id NUMBER GENERATED BY DEFAULT AS IDENTITY (
      START
      WITH
        1 INCREMENT BY 1
    ) PRIMARY KEY,
    person_id NUMBER REFERENCES Person (person_id) ON DELETE CASCADE,
    position_id NUMBER REFERENCES Position(position_id) ON DELETE CASCADE
  );

Create table
  PositionPrivilege (
    position_privilege_id NUMBER GENERATED BY DEFAULT AS IDENTITY (
      START
      WITH
        1 INCREMENT BY 1
    ) PRIMARY KEY,
    position_id NUMBER REFERENCES Position(position_id) ON DELETE CASCADE,
    privilege_id NUMBER REFERENCES Privilege (privilege_id) ON DELETE CASCADE
  );

CREATE TABLE
  Flight (
    flight_id NUMBER GENERATED BY DEFAULT AS IDENTITY (
      START
      WITH
        1 INCREMENT BY 1
    ) PRIMARY KEY,
    flight_number VARCHAR2 (6) NOT NULL,
    base_price NUMBER (10, 2) NOT NULL,
    tax_percent NUMBER (5, 2) NOT NULL,
    surcharge NUMBER (10, 2) NOT NULL,
    status VARCHAR2 (20) NOT NULL
  );

CREATE TABLE
  AirplaneModel (
    airplane_model VARCHAR2 (15) PRIMARY KEY,
    family VARCHAR2 (15) NOT NULL,
    capacity NUMBER (3) NOT NULL,
    cargo_capacity NUMBER (10, 2) NOT NULL,
    volume_capacity NUMBER (10, 2) NOT NULL
  );

CREATE TABLE
  Airport (
    airport_code VARCHAR2 (3) PRIMARY KEY,
    name VARCHAR2 (80) NOT NULL,
    type VARCHAR2 (20) NOT NULL,
    city VARCHAR2 (80) NOT NULL,
    country VARCHAR2 (30) NOT NULL,
    runways NUMBER (2) NOT NULL
  );

CREATE TABLE
  Scale (
    scale_id NUMBER GENERATED BY DEFAULT AS IDENTITY (
      START
      WITH
        1 INCREMENT BY 1
    ) PRIMARY KEY,
    flight_id NUMBER REFERENCES Flight (flight_id) ON DELETE CASCADE,
    airplane_model VARCHAR2 (15) REFERENCES AirplaneModel (airplane_model),
    origin_airport VARCHAR2 (3) NOT NULL REFERENCES Airport (airport_code),
    destination_airport VARCHAR2 (3) NOT NULL REFERENCES Airport (airport_code),
    departure_date TIMESTAMP NOT NULL,
    arrival_date TIMESTAMP NOT NULL,
    price NUMBER (10, 2) NOT NULL
  );

CREATE TABLE
  Employee (
    employee_id NUMBER GENERATED BY DEFAULT AS IDENTITY (
      START
      WITH
        1 INCREMENT BY 1
    ) PRIMARY KEY,
    name VARCHAR2 (80) NOT NULL,
    job_title VARCHAR2 (30) NOT NULL
  );

CREATE TABLE
  FlightCrew (
    flight_crew_id NUMBER GENERATED BY DEFAULT AS IDENTITY (
      START
      WITH
        1 INCREMENT BY 1
    ) PRIMARY KEY,
    flight_id NUMBER REFERENCES Flight (flight_id) ON DELETE CASCADE,
    employee_id NUMBER REFERENCES Employee (employee_id),
    flight_role VARCHAR2 (20) NOT NULL
  );

CREATE TABLE
    Passenger(
        passenger_id NUMBER GENERATED BY DEFAULT AS IDENTITY (
            START
            WITH
                1 INCREMENT BY 1
        ) PRIMARY KEY,
        person_id NUMBER REFERENCES Person (person_id) NOT NULL
    );

CREATE TABLE
    Booking (
        booking_id NUMBER GENERATED BY DEFAULT AS IDENTITY (
        START
        WITH
            1 INCREMENT BY 1
        ) PRIMARY KEY,
        --fk User, to get the user who made the booking--
        passenger_id NUMBER REFERENCES Passenger NOT NULL,
        flight_id NUMBER REFERENCES Flight NOT NULL,
        booking_date TIMESTAMP NOT NULL,
        booking_status VARCHAR2 (20) NOT NULL,
        total_price NUMBER (10, 2) NOT NULL
    );

CREATE TABLE
  PlacementArea (
    PLACEMENT_AREA_ID NUMBER GENERATED BY DEFAULT AS IDENTITY (
      START
      WITH
        1 INCREMENT BY 1
    ) PRIMARY KEY,
    NAME VARCHAR2 (100) NOT NULL
  );

CREATE TABLE
  Luggage (
    LUGGAGE_ID NUMBER GENERATED BY DEFAULT AS IDENTITY (
      START
      WITH
        1 INCREMENT BY 1
    ) PRIMARY KEY,
    LUGGAGE_TYPE VARCHAR2 (100) NOT NULL,
    EXTRA_CHARGE FLOAT DEFAULT 0,
    QUANTITY NUMBER (4) DEFAULT 1,
    DESCRIPTION VARCHAR2 (150),
    WIDTH FLOAT NOT NULL,
    HEIGHT FLOAT NOT NULL,
    WEIGHT FLOAT NOT NULL,
    PASSENGER_ID NUMBER REFERENCES passenger NOT NULL,
    FLIGHT_ID NUMBER REFERENCES flight NOT NULL,
    BOOKING_ID NUMBER REFERENCES Booking NOT NULL,
    placement_area_ID REFERENCES PlacementArea NOT NULL
  );

CREATE TABLE
  LostLuggageInfo (
    LostLuggageID NUMBER (10, 0) GENERATED ALWAYS AS IDENTITY INCREMENT BY 1 START
    WITH
      1 PRIMARY KEY,
      Shipping_address VARCHAR2 (150) NOT NULL,
      phone_number VARCHAR2 (150) NOT NULL,
      receiver_name VARCHAR2 (150) NOT NULL,
      Luggage_id NUMBER REFERENCES Luggage NOT NULL
  );

CREATE TABLE
  MedicalInfo (
    Medical_info_ID NUMBER (10, 0) GENERATED ALWAYS AS IDENTITY INCREMENT BY 1 START
    WITH
      1 PRIMARY KEY,
      person_id NUMBER REFERENCES Person (person_id) NOT NULL,
      medical_conditions VARCHAR2 (150) NOT NULL
  );

Create table
  Boardingpass (
    Boarding_pass_ID NUMBER (10, 0) GENERATED ALWAYS AS IDENTITY INCREMENT BY 1 START
    WITH
      1 PRIMARY KEY,
      passenger_id NUMBER REFERENCES Passenger NOT NULL,
      --fk seat, to get asigned_seat to a passenger or asigned a empy seat--
      booking_id NUMBER REFERENCES Booking NOT NULL,
      Flight_ID NUMBER (10) REFERENCES Flight NOT NULL, --needed departure_date, origin and destination camps
      medical_info_ID NUMBER (10) REFERENCES Medicalinfo NOT NULL,
      Lost_Luggage_ID NUMBER (10) REFERENCES LostLuggageInfo NOT NULL,
      boarding_time TIMESTAMP NOT NULL
    );

CREATE TABLE
  PaymentMethod (
    payment_method_id NUMBER GENERATED BY DEFAULT AS IDENTITY (
      START
      WITH
        1 INCREMENT BY 1
    ) PRIMARY KEY,
    payment_method_type VARCHAR2 (20) NOT NULL
  );

CREATE TABLE
  PaymentMethodXUser (
    payment_methodXuser_id NUMBER GENERATED BY DEFAULT AS IDENTITY (
      START
      WITH
        1 INCREMENT BY 1
    ) PRIMARY KEY,
    payment_method_id REFERENCES PaymentMethod (payment_method_id),
    user_id NUMBER NOT NULL  --User table is not created yet, but this is a fk
  );
