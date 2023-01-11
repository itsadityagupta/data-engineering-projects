{% docs dvdrental %}

This database represents the business processes of a DVD rental store. The DVD rental database has many objects, including:

1. 15 tables
2. 1 trigger
3. 7 views
4. 8 functions
5. 1 domain
6. 13 sequences

Here's an ER diagram of the database:

![DVDRental ER Diagram](assets/dvdrental-er-model.png)

{% enddocs %}

{% docs actors_source %}

Stores actors first name and last name.

{% enddocs %}

{% docs actors %}

Stores actor names.

{% enddocs %}

{% docs actor_id %}

Uniquely identifies each actor.

{% enddocs %}

{% docs actor_first_name %}

First name of the actor.

{% enddocs %}

{% docs actor_last_name %}

Last name of the actor.

{% enddocs %}

{% docs actor_name %}

Name of the actor created from `first_name` and `last_name` columns of the [source actor table](#!/source/source.dvdrental.dvdrental.actors).

{% enddocs %}

{% docs last_updated %}

Last update time of the record.

{% enddocs %}

{% docs addresses %}

Stores addresses for customers, staff, stores or any other entities.

{% enddocs %}

{% docs address_id %}

Uniquely identifies each address.

{% enddocs %}

{% docs address %}

First line of the address.

{% enddocs %}

{% docs address2 %}

Second line of the address.

{% enddocs %}

{% docs district %}

District name.

{% enddocs %}

{% docs city_id %}

Id of the city. Acts as a foreign key refering to [cities](#!/source/source.dvdrental.dvdrental.cities) table.

{% enddocs %}

{% docs postal_code %}

Postal code of the address.

{% enddocs %}

{% docs phone %}

Phone number of the addressee.

{% enddocs %}