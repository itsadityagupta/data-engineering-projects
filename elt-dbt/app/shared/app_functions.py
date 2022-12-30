def insert_customer_data_query():
    """Query to insert customer data"""

    return """
    INSERT INTO {} (
    gender,
    age,
    married,
    no_of_dependants,
    city,
    zipcode,
    tenure,
    offer,
    phone_service,
    internet_service,
    total_charges,
    total_revenue,
    customer_status) VALUES
    (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """


def insert_population_data_query():
    """Query to insert population data"""

    return """
    INSERT INTO {} VALUES
    (%s, %s)
    """
