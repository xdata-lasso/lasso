---
trigger: always_on
---

Only for string type values where you don't have anything from query to rely on, you can use faker. You will never get random data from faker. If there are some complex constraints needed for any table, better use z3 in combination.


Unique values
Through use of the .unique property on the generator, you can guarantee that any generated values are unique for this specific instance. 

from faker import Faker
fake = Faker()
names = [fake.unique.first_name() for i in range(500)]
assert len(set(names)) == len(names)
On Faker instances with multiple locales, you can specify the locale to use for the unique values by using the subscript notation:

from faker import Faker
fake = Faker(['en_US', 'fr_FR'])
names = [fake.unique["en_US"].first_name() for i in range(500)]
assert len(set(names)) == len(names)
Calling fake.unique.clear() clears the already seen values.

Note, to avoid infinite loops, after a number of attempts to find a unique value, Faker will throw a UniquenessException. 

from faker import Faker

fake = Faker()
for i in range(3):
     # Raises a UniquenessException
     fake.unique.boolean()
In addition, only hashable arguments and return values can be used with .unique.