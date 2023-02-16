library(palmerpenguins)
prop.table(table(penguins$island)) # not actually used here, but ...
species_p <- prop.table(xtabs(~island + species, data=penguins), margin=1)
species_p

# model four measurements, based on species (island is irrelevant here)
bl <- lm(bill_length_mm ~ species, data=penguins)
bd <- lm(bill_depth_mm ~  species, data=penguins)
fl <- lm(flipper_length_mm ~ species, data=penguins)
bm <- lm(body_mass_g ~    species, data=penguins)

for (i in 1:15) {
  newdata <- data.frame(
    island=sample.int(3, size=1)  # sample an island
  )
  # generate species based on island
  newdata$species <- factor(sample.int(3, size=1, prob=species_p[newdata$island, ]),
                            levels=c("1", "2", "3"), labels=levels(penguins$species))
  # generate measurements based on species
  newdata$bl <- predict(bl, newdata) + rnorm(1, sd=sigma(bl))
  newdata$bd <- predict(bd, newdata) + rnorm(1, sd=sigma(bd))
  newdata$fl <- predict(fl, newdata) + rnorm(1, sd=sigma(fl))
  newdata$bm <- predict(bm, newdata) + rnorm(1, sd=sigma(bm))
  print(newdata)  
  if (i == 1) {
    simdata <- newdata
  } else {
    simdata <- rbind(simdata, newdata)
  }
}
