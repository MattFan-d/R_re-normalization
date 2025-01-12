# The code below performs normalization of formant frequency data using the Nearey-E normalization method. 
# It involves several steps, including data manipulation, normalization, and reorganization of columns. 
# Each step is explained in detail:

# Step 1: Initial Data Preparation
# - Create a new dataset `formant_new` by modifying the `formant` dataset.
# - Remove unnecessary columns: `VC`, `Preceding.V`, and `Rounding`. These columns are set to NULL.

formant_new <- formant %>% mutate(
  VC = NULL,
  Preceding.V = NULL,
  Rounding = NULL
)

# Step 2: Normalization of Formant Frequencies
# - Normalize the specified formant frequency columns (columns 4 to 6) using the Nearey-E normalization method.
# - The normalization is grouped by `speaker_id` and `vowel_id`.
# - The `corners` parameter is set to NULL, implying no corner vowel specification is used.

formant_new <- normalize(formant_new[,4:6], formant_new$speaker_id, formant_new$vowel_id, method = 'neareyE', 
          corners = NULL)

# Step 3: Renaming Columns
# - Renames the `speaker` and `vowel` columns back to their original names (`speaker_id` and `vowel_id` respectively).
# - This ensures consistent naming conventions throughout the dataset.

formant_new <- rename(formant_new, speaker_id = speaker)
formant_new <- rename(formant_new, vowel_id = vowel)

# Step 4: Adding Placeholder Columns
# - Adds new columns (`F1_glide`, `F2_glide`, `F3_glide`, `context`) and initializes them with NA values.
# - These placeholders may be used for further data processing or analysis.

formant_new <- mutate(formant_new, F1_glide = NA, F2_glide = NA, F3_glide = NA, context = NA)

# Step 5: Reorganizing Column Order
# - Relocates `context`, `vowel_id`, and `speaker_id` columns to specific positions within the dataset for better clarity.

formant_new <- formant_new %>% relocate(context)
formant_new <- formant_new %>% relocate(vowel_id)
formant_new <- formant_new %>% relocate(speaker_id)

# Step 6: Scaling the Vowel Data
# - Uses the `scalevowels` function to scale the normalized formant data. 
# - Scaling ensures comparability of formant frequencies across speakers and vowels.

formant_new <- scalevowels(formant_new)

# Step 7: Adding and Removing Columns
# - Restores columns `VH`, `Preceding.V`, and `Rounding` from the original `formant` dataset.
# - Removes unnecessary columns (`F1_glide`, `F2_glide`, `F3_glide`, and `context`) that were added earlier as placeholders.

formant_new <- formant_new %>% mutate(
  VH = formant$VC,
  Preceding.V = formant$Preceding.V,
  Rounding = formant$Rounding,
  "F1_glide" = NULL,
  "F2_glide" = NULL,
  "F3_glide" = NULL,
  context = NULL
)

# Step 8: Final Column Renaming
# - Renames `speaker_id` and `vowel_id` columns back to `speaker` and `vowel` for compatibility with further analysis.

formant_new <- rename(formant_new, speaker = speaker_id)
formant_new <- rename(formant_new, vowel = vowel_id)

# Step 9: Dataset Inspection
# - Uses `str()` to display the structure of the final dataset.
# - Displays the levels of the `vowel` column to verify the categories present in the data.

str(formant_new)
levels(formant_new$vowel)
