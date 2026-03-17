# =============================================================================
# unzip_display.R
# Task 6 – Unzip the "Employee Profile" folder and display the employee data
#
# USAGE:
#   1. Make sure you have run Task 5 in SF_Salaries_Assignment.ipynb first,
#      so that the "Employee Profile/" folder and ZIP file exist.
#   2. Set your working directory to the sf_salaries_project/ folder:
#         setwd("/path/to/sf_salaries_project")
#   3. Run this script:
#         source("unzip_display.R")
#      OR from the terminal:
#         Rscript unzip_display.R
#
# REQUIRED PACKAGES:
#   install.packages("readr")
# =============================================================================

library(utils)   # unzip() — built-in, no install needed
library(readr)   # read_csv()

cat("=============================================================\n")
cat(" Task 6 – Unzip Employee Profile & Display Data\n")
cat("=============================================================\n\n")

# -----------------------------------------------------------------------------
# Step 1: Locate the ZIP file inside "Employee Profile/"
# -----------------------------------------------------------------------------
profile_dir <- "Employee Profile"

if (!dir.exists(profile_dir)) {
  stop(paste(
    "The folder '", profile_dir, "' does not exist.\n",
    "Please run Task 5 in the Jupyter Notebook first to generate it.", sep = ""
  ))
}

zip_files <- list.files(profile_dir, pattern = "\\.zip$", full.names = TRUE)

if (length(zip_files) == 0) {
  stop("No ZIP file found in 'Employee Profile/'. Run Task 5 in the notebook first.")
}

target_zip <- zip_files[1]
cat("Found ZIP file:", target_zip, "\n\n")

# -----------------------------------------------------------------------------
# Step 2: Unzip into "Employee Profile/extracted/"
# -----------------------------------------------------------------------------
extract_dir <- file.path(profile_dir, "extracted")
dir.create(extract_dir, showWarnings = FALSE, recursive = TRUE)

cat("Extracting to:", extract_dir, "\n")
unzip(target_zip, exdir = extract_dir)
cat("Extraction complete.\n\n")

# -----------------------------------------------------------------------------
# Step 3: Read the extracted CSV
# -----------------------------------------------------------------------------
csv_files <- list.files(extract_dir, pattern = "\\.csv$", full.names = TRUE)

if (length(csv_files) == 0) {
  stop("No CSV file found after unzipping. The ZIP may be empty or corrupted.")
}

cat("Reading CSV:", csv_files[1], "\n\n")
emp_data <- read_csv(csv_files[1], show_col_types = FALSE)

# -----------------------------------------------------------------------------
# Step 4: Display the data
# -----------------------------------------------------------------------------
cat("=============================================================\n")
cat(" Employee Profile Data\n")
cat("=============================================================\n")
cat("Rows    :", nrow(emp_data), "\n")
cat("Columns :", ncol(emp_data), "\n\n")

print(as.data.frame(emp_data))

# -----------------------------------------------------------------------------
# Step 5: Summary statistics (numeric columns only)
# -----------------------------------------------------------------------------
numeric_cols <- emp_data[, sapply(emp_data, is.numeric)]

if (ncol(numeric_cols) > 0) {
  cat("\n=============================================================\n")
  cat(" Summary Statistics (Numeric Columns)\n")
  cat("=============================================================\n")
  print(summary(numeric_cols))
} else {
  cat("\nNo numeric columns found for summary statistics.\n")
}

cat("\nDone.\n")
