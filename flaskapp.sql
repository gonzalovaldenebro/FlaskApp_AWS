-- Flask app queries

-- Provide all the countries where 50% of their populations speaks an non-official language
SELECT CountryCode, Language ,Percentage
FROM countrylanguage JOIN 
WHERE IsOfficial = 'F' and Percentage > 50;

-- Provide the population of all coutries where 50% of their population speaks an non-official language

SELECT country.Name, country.Region ,country.GovernmentForm , country.Population, countrylanguage.Percentage as NonOfficial, countrylanguage.Language as Language
FROM countrylanguage 
JOIN country ON countrylanguage.CountryCode = country.Code
WHERE countrylanguage.IsOfficial = 'F' and countrylanguage.Percentage > 50;

-- Provide the population of all coutries where 50% of their population speaks an non-official language

SELECT country.Name, country.Region ,country.GovernmentForm , country.Population, countrylanguage.Percentage as NonOfficial, countrylanguage.Language as Language
FROM countrylanguage 
JOIN country ON countrylanguage.CountryCode = country.Code
WHERE countrylanguage.IsOfficial = 'F' and countrylanguage.Percentage > 50;

-- Provide the population of all coutries where there is a (user input) amount of life expectancy


SELECT country.Name, country.Region ,country.GovernmentForm, country.LifeExpectancy, countrylanguage.Language as Language
FROM countrylanguage 
JOIN country ON countrylanguage.CountryCode = country.Code
WHERE country.LifeExpectancy < 50
ORDER BY country.LifeExpectancy asc
LIMIT 10;




