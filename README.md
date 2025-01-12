### README: Formant Normalization Using Nearey-E Method

---

#### **Overview**
This script performs formant normalization using the Nearey-E method, a widely used approach in phonetic research to standardize formant frequency values across speakers. The script cleans, normalizes, and restructures a dataset of formant frequency data, preparing it for further analysis.

---

#### **Features**
- **Data Cleaning**: Removes unnecessary columns to focus on relevant data.
- **Normalization**: Uses the `normalize()` function from the `phonTools` package to apply the Nearey-E method.
- **Column Manipulation**: Renames and reorganizes columns for clarity and usability.
- **Scaling**: Employs the `scalevowels()` function from the `phonTools` package to scale normalized formant data.
- **Dataset Inspection**: Includes steps to examine the structure and contents of the final dataset.

---

#### **Requirements**
To run this script, ensure the following:
- **Programming Language**: R
- **Libraries/Packages**:
  - `dplyr`: For data manipulation.
  - `phonTools`: For normalization (`normalize()`) and scaling (`scalevowels()`) of vowel formant data.

Install necessary packages using the following commands if they are not already installed:
```r
install.packages("dplyr")
install.packages("phonTools")
```

---

#### **How It Works**
1. **Input**: The script starts with a dataset named `formant` containing speaker, vowel, and formant frequency data.
2. **Data Cleaning**: Unnecessary columns such as `VC`, `Preceding.V`, and `Rounding` are removed.
3. **Normalization**: The `normalize()` function from the `phonTools` package applies the Nearey-E method to standardize formant frequency values (F1, F2, F3), grouped by `speaker_id` and `vowel_id`.
4. **Scaling**: The `scalevowels()` function further scales the normalized data for cross-speaker comparability.
5. **Output**: The cleaned, normalized, and scaled dataset, `formant_new`, is ready for analysis.

---

#### **Key Steps in the Code**
- **Data Cleaning**:
  ```r
  formant_new <- formant %>% mutate(
    VC = NULL,
    Preceding.V = NULL,
    Rounding = NULL
  )
  ```
- **Normalization**:
  ```r
  formant_new <- normalize(
    formant_new[, 4:6], 
    formant_new$speaker_id, 
    formant_new$vowel_id, 
    method = 'neareyE', 
    corners = NULL
  )
  ```
- **Scaling**:
  ```r
  formant_new <- scalevowels(formant_new)
  ```
- **Final Adjustments**:
  ```r
  formant_new <- formant_new %>% mutate(
    VH = formant$VC,
    Preceding.V = formant$Preceding.V,
    Rounding = formant$Rounding
  )
  ```

---

#### **Output**
The resulting dataset (`formant_new`) contains:
- Normalized and scaled formant frequencies for F1, F2, and F3.
- Organized columns for speaker IDs, vowels, and contextual data.
- A ready-to-use dataset for further phonetic analysis or visualization.

---

#### **Running the Script**
1. Load the required libraries in R:
   ```r
   library(dplyr)
   library(phonTools)
   ```
2. Ensure the input dataset (`formant`) is properly formatted.
3. Execute the script step-by-step or as a complete script.
4. Inspect the output dataset using:
   ```r
   str(formant_new)
   levels(formant_new$vowel)
   ```

---

#### **Notes**
- The `phonTools` package must be installed and loaded for this script to work.
- Modify column names in the script to match the structure of your dataset if needed.
- This script is specifically tailored for formant frequency normalization in phonetic studies.

---

#### **Contact**
For questions or contributions, please reach out to Matthew Fan at fann97@outlook.com .
