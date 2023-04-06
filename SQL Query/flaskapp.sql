-- Flask app queries

-- Provide all the countries where 50% of their populations speaks an non-official language
SELECT CountryCode, Language ,Percentage
FROM countrylanguage 
WHERE IsOfficial = 'F' and Percentage > 50
ORDER BY countrylanguage.Percentage desc
LIMIT 10;
+-------------+----------------+------------+
| CountryCode | Language       | Percentage |
+-------------+----------------+------------+
| HTI         | Haiti Creole   |      100.0 |
| KNA         | Creole English |      100.0 |
| GRD         | Creole English |      100.0 |
| CPV         | Crioulo        |      100.0 |
| DMA         | Creole English |      100.0 |
| VCT         | Creole English |       99.1 |
| MTQ         | Creole French  |       96.6 |
| GUY         | Creole English |       96.4 |
| PSE         | Arabic         |       95.9 |
| ATG         | Creole English |       95.7 |
+-------------+----------------+------------+


-- Provide the population of all coutries where 50% of their population speaks an non-official language
SELECT country.Name, country.Region ,country.GovernmentForm , country.Population, countrylanguage.Percentage as NonOfficial, countrylanguage.Language as Language
FROM countrylanguage 
JOIN country ON countrylanguage.CountryCode = country.Code
WHERE countrylanguage.IsOfficial = 'F' and countrylanguage.Percentage > 50
ORDER BY countrylanguage.Percentage desc
LIMIT 10;
+----------------------------------+----------------+-------------------------------+------------+-------------+----------------+
| Name                             | Region         | GovernmentForm                | Population | NonOfficial | Language       |
+----------------------------------+----------------+-------------------------------+------------+-------------+----------------+
| Saint Kitts and Nevis            | Caribbean      | Constitutional Monarchy       |      38000 |       100.0 | Creole English |
| Haiti                            | Caribbean      | Republic                      |    8222000 |       100.0 | Haiti Creole   |
| Cape Verde                       | Western Africa | Republic                      |     428000 |       100.0 | Crioulo        |
| Dominica                         | Caribbean      | Republic                      |      71000 |       100.0 | Creole English |
| Grenada                          | Caribbean      | Constitutional Monarchy       |      94000 |       100.0 | Creole English |
| Saint Vincent and the Grenadines | Caribbean      | Constitutional Monarchy       |     114000 |        99.1 | Creole English |
| Martinique                       | Caribbean      | Overseas Department of France |     395000 |        96.6 | Creole French  |
| Guyana                           | South America  | Republic                      |     861000 |        96.4 | Creole English |
| Palestine                        | Middle East    | Autonomous Area               |    3101000 |        95.9 | Arabic         |
| Antigua and Barbuda              | Caribbean      | Constitutional Monarchy       |      68000 |        95.7 | Creole English |
+----------------------------------+----------------+-------------------------------+------------+-------------+----------------+


-- Provide the population of all coutries where 50% of their population speaks an non-official language
SELECT country.Name, country.Region ,country.GovernmentForm , country.Population, countrylanguage.Percentage as NonOfficial, countrylanguage.Language as Language
FROM countrylanguage 
JOIN country ON countrylanguage.CountryCode = country.Code
WHERE countrylanguage.IsOfficial = 'F' and countrylanguage.Percentage > 50
LIMIT 10;
+---------------------+-----------------+----------------------------------------------+------------+-------------+----------------+
| Name                | Region          | GovernmentForm                               | Population | NonOfficial | Language       |
+---------------------+-----------------+----------------------------------------------+------------+-------------+----------------+
| Aruba               | Caribbean       | Nonmetropolitan Territory of The Netherlands |     103000 |        76.7 | Papiamento     |
| Antigua and Barbuda | Caribbean       | Constitutional Monarchy                      |      68000 |        95.7 | Creole English |
| Burkina Faso        | Western Africa  | Republic                                     |   11937000 |        50.2 | Mossi          |
| Bahamas             | Caribbean       | Constitutional Monarchy                      |     307000 |        89.7 | Creole English |
| Barbados            | Caribbean       | Constitutional Monarchy                      |     270000 |        95.1 | Bajan          |
| Botswana            | Southern Africa | Republic                                     |    1622000 |        75.5 | Tswana         |
| Congo               | Central Africa  | Republic                                     |    2943000 |        51.5 | Kongo          |
| Cape Verde          | Western Africa  | Republic                                     |     428000 |       100.0 | Crioulo        |
| Dominica            | Caribbean       | Republic                                     |      71000 |       100.0 | Creole English |
| Ghana               | Western Africa  | Republic                                     |   20212000 |        52.4 | Akan           |
+---------------------+-----------------+----------------------------------------------+------------+-------------+----------------+


-- Provide the population of all coutries where there is a (user input) amount of life expectancy
SELECT country.Name, country.Region ,country.GovernmentForm, country.LifeExpectancy, countrylanguage.Language as Language
FROM countrylanguage 
JOIN country ON countrylanguage.CountryCode = country.Code
WHERE country.LifeExpectancy < 50
ORDER BY country.LifeExpectancy asc
LIMIT 10;
+------------+----------------+----------------+----------------+----------+
| Name       | Region         | GovernmentForm | LifeExpectancy | Language |
+------------+----------------+----------------+----------------+----------+
| Zambia     | Eastern Africa | Republic       |           37.2 | Bemba    |
| Zambia     | Eastern Africa | Republic       |           37.2 | Chewa    |
| Zambia     | Eastern Africa | Republic       |           37.2 | Lozi     |
| Zambia     | Eastern Africa | Republic       |           37.2 | Nsenga   |
| Zambia     | Eastern Africa | Republic       |           37.2 | Nyanja   |
| Zambia     | Eastern Africa | Republic       |           37.2 | Tonga    |
| Mozambique | Eastern Africa | Republic       |           37.5 | Chuabo   |
| Mozambique | Eastern Africa | Republic       |           37.5 | Lomwe    |
| Mozambique | Eastern Africa | Republic       |           37.5 | Makua    |
| Mozambique | Eastern Africa | Republic       |           37.5 | Marendje |
+------------+----------------+----------------+----------------+----------+



