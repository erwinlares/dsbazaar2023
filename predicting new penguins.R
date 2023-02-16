library(palmerpenguins)
library(tidyLPA)

# pmodel <- subset(penguins, select=c("bill_length_mm",
#                                     "bill_depth_mm",
#                                     "flipper_length_mm",
#                                     "body_mass_g")) |>
#           single_imputation() |>
#           estimate_profiles(3, models=6)
# penguinsplus <- merge(penguins, get_data(pmodel)[, -(1:2)], all=TRUE)
# xtabs( ~ species + Class, data=penguinsplus)
# 
# xtabs( ~ species + Class, data=subset(penguinsplus, subset=island=="Torgersen"))
# xtabs( ~ species + Class, data=subset(penguinsplus, subset=island=="Dream"))
# xtabs( ~ species + Class, data=subset(penguinsplus, subset=island=="Biscoe"))

library(mclust)
mmodel <- subset(penguins, select=c("bill_length_mm",
                                    "bill_depth_mm",
                                    "flipper_length_mm",
                                    "body_mass_g")) |>
  imputeData() |>
  Mclust(3)
predict(mmodel)
table(penguins$species, predict(mmodel)$classification)

# a set of new observations
table(simdata$species, predict(mmodel, simdata[, -(1:2)])$classification)
# a single new observation
table(newdata$species, predict(mmodel, newdata[, -(1:2)])$classification)
