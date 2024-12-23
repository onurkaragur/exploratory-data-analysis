-- Exploratory Data Analysis -- 

SELECT * FROM layoffs_2;

-- Mean of certain columns -- 


-- Companies that went out of business -- 
SELECT * FROM layoffs_2
WHERE percentage_laid_off = 1;

-- Companies with highest funds raised / revenue generated --
SELECT * FROM layoffs_2
ORDER BY funds_raised_millions DESC;

-- Companies with highest layoff count --
SELECT company, SUM(total_laid_off)
FROM layoffs_2
GROUP BY company
ORDER BY 2 DESC;

-- Dataset interval --
SELECT MIN(`date`) AS Begin_Date, MAX(`date`) AS End_Date
FROM layoffs_2;

-- Industries with highest layoff count --
SELECT industry, SUM(total_laid_off)
FROM layoffs_2
GROUP BY industry
ORDER BY 2 DESC;

-- Countries with highest layoff count -- 
SELECT country, SUM(total_laid_off)
FROM layoffs_2
GROUP BY country
ORDER BY 2 DESC;

-- Layoffs by quarters -- 
SELECT CONCAT(YEAR(`date`),' Q', CEIL(MONTH(`date`) / 3)) AS year_quarter, SUM(total_laid_off)
FROM layoffs_2
GROUP BY year_quarter
ORDER BY 2 DESC;

-- Rolling total by quarters -- 
WITH rolling_cte AS (
	SELECT CONCAT(YEAR(`date`),' Q', CEIL(MONTH(`date`) / 3)) AS year_quarter, SUM(total_laid_off) AS total_layoffs
	FROM layoffs_2
	GROUP BY year_quarter
	ORDER BY 2 DESC -- Unnecessary but good for reusability --
)
SELECT year_quarter, total_layoffs, SUM(total_layoffs) OVER(ORDER BY year_quarter) AS rolling_total
FROM rolling_cte
;

-- Layoff sums by stages --
SELECT stage, SUM(total_laid_off)
FROM layoffs_2
GROUP BY stage
ORDER BY 2 DESC;



