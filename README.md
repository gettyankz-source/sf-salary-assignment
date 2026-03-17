# SF Employee Salaries – Assignment Submission

## Project Structure

```
sf_salaries_project/
├── SF_Salaries_Assignment.ipynb   ← Main Jupyter Notebook (all 6 tasks)
├── README.md                      ← This file
└── Total.csv                      ← Dataset (download separately from Kaggle)
```

After running the notebook, the following will also be created:

```
sf_salaries_project/
└── Employee Profile/
    ├── <EmployeeName>.csv          ← Exported employee data (Task 5)
    ├── <EmployeeName>.zip          ← Zipped CSV (Task 5)
    └── extracted/
        └── <EmployeeName>.csv      ← Unzipped by R (Task 6)
```

---

## Dataset

Download **Total.csv** from Kaggle and place it in the project folder:
https://www.kaggle.com/datasets/mojtaba142/20112018-salaries-for-san-francisco?select=Total.csv

Columns: `Id`, `EmployeeName`, `JobTitle`, `BasePay`, `OvertimePay`, `OtherPay`,
`Benefits`, `TotalPay`, `TotalPayBenefits`, `Year`, `Notes`, `Agency`, `Status`

---

## Prerequisites

### Python (>= 3.8)

```bash
pip install pandas numpy matplotlib rpy2
```

### R (>= 4.0)

```R
install.packages("readr")   # utils is built-in
```

Download R from: https://cran.r-project.org/

---

## Running the Notebook

```bash
cd sf_salaries_project
jupyter notebook SF_Salaries_Assignment.ipynb
```

Run all cells: **Kernel → Restart & Run All**

---

## Assignment Tasks

| # | Task | What it does |
|---|------|-------------|
| 1 | Import Data | Reads Total.csv, coerces pay columns to numeric, strips whitespace |
| 2 | Employee Function | `get_employee_details(name)` – partial/case-insensitive search, returns DataFrame |
| 3 | Dictionary Processing | `build_salary_dict()` builds nested dict; `summarise_employee()` computes stats |
| 4 | Error Handling | Tests TypeError, ValueError, KeyError across all helper functions |
| 5 | Export CSV + ZIP | `export_employee_profile(name)` → `Employee Profile/<name>.csv` + `.zip` |
| 6 | R Unzip & Display | `%%R` cell unzips the ZIP and displays data with summary stats |

---

## Using the R Code

### Option A – Inside the Notebook (recommended)

Run the `%%R` magic cell in Task 6. It will:
- Locate the ZIP in `Employee Profile/`
- Unzip it to `Employee Profile/extracted/`
- Load and print the CSV with `readr::read_csv()`
- Show summary statistics

### Option B – Standalone R Script

Run the following from RStudio or the R console, with your working directory set to the project folder (`setwd("/path/to/sf_salaries_project")`):

```r
library(utils)
library(readr)

zip_files <- list.files("Employee Profile", pattern = "\\.zip$", full.names = TRUE)
if (length(zip_files) == 0) stop("No ZIP found. Run Task 5 in the notebook first.")

extract_dir <- file.path("Employee Profile", "extracted")
dir.create(extract_dir, showWarnings = FALSE, recursive = TRUE)
unzip(zip_files[1], exdir = extract_dir)

csv_files <- list.files(extract_dir, pattern = "\\.csv$", full.names = TRUE)
emp_data  <- read_csv(csv_files[1], show_col_types = FALSE)

cat("===== Employee Profile Data =====\n")
cat("Rows:", nrow(emp_data), "| Columns:", ncol(emp_data), "\n\n")
print(as.data.frame(emp_data))

cat("\n===== Summary Statistics =====\n")
print(summary(emp_data[, sapply(emp_data, is.numeric)]))
```

---

## Troubleshooting

| Problem | Fix |
|---------|-----|
| `FileNotFoundError: 'Total.csv'` | Download from Kaggle and place next to the notebook |
| `ModuleNotFoundError: rpy2` | `pip install rpy2`, then restart the kernel |
| rpy2 can't find R | Install R first from https://cran.r-project.org |
| "No ZIP file found" in R cell | Run Task 5 first |
| `R_HOME not set` | Run `export R_HOME=$(R RHOME)` in terminal before launching Jupyter |

---

## GitHub Submission

```bash
git init
git add sf_salaries_project/
git commit -m "SF Salaries Assignment – all 6 tasks"
git remote add origin https://github.com/<your-username>/<repo>.git
git push -u origin main
```

Do NOT commit `Total.csv` — instruct your marker to download it from Kaggle.
