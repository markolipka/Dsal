context("Solute diffusivity calculation")
source("~/Dropbox/IOW/R-functions/Dsal/calculateDsal.R")
#auto_test(code_path = "~/Dropbox/IOW/R-functions/Dsal/", test_path = "~/Dropbox/IOW/R-functions/Dsal/tests/")

test_that("calculate.Dsal() throws warning when allowed salinity and temperature range is exceeded", {
    expect_warning(calculate.Dsal(temperature = 30))
    expect_warning(calculate.Dsal(salinity = 40))
})

test_that("calculate.Dsal() throws error when salinity or temperature are negative", {
    expect_error(calculate.Dsal(temperature = -1))
    expect_error(calculate.Dsal(salinity = -1))
})

tol = 5.5e-8

test_that(paste("calculate.Dsal() returns D35 values from the literature within a tolerance of", tol), {
    expect_equal(calculate.Dsal(el = "NH4",
                                temperature = 0,
                                salinity = 35)$D35,
                 9.03e-10 * 10000, # Schulz & Zabel 2006 Tab. 3.1
                 tolerance = tol)
    expect_equal(calculate.Dsal(el = "NH4",
                                temperature = 10,
                                salinity = 35)$D35,
                 1.29e-9 * 10000, # Schulz & Zabel 2006 Tab. 3.1
                 tolerance = tol)
    expect_equal(calculate.Dsal(el = "NH4",
                                temperature = 25,
                                salinity = 35)$D35,
                 1.85e-9 * 10000, # Schulz & Zabel 2006 Tab. 3.1
                 tolerance = tol)
    
    expect_equal(calculate.Dsal(el = "Mn",
                                temperature = 0,
                                salinity = 35)$D35,
                 3.02e-10 * 10000, # Schulz & Zabel 2006 Tab. 3.1
                 tolerance = tol)
    expect_equal(calculate.Dsal(el = "Mn",
                                temperature = 10,
                                salinity = 35)$D35,
                 4.46e-10 * 10000, # Schulz & Zabel 2006 Tab. 3.1
                 tolerance = tol)
    expect_equal(calculate.Dsal(el = "Mn",
                                temperature = 25,
                                salinity = 35)$D35,
                 6.57e-10 * 10000, # Schulz & Zabel 2006 Tab. 3.1
                 tolerance = tol)
    
    expect_equal(calculate.Dsal(el = "DIC",
                                temperature = 0,
                                salinity = 35)$D35,
                 4.81e-10 * 10000, # Schulz & Zabel 2006 Tab. 3.1
                 tolerance = tol)
    expect_equal(calculate.Dsal(el = "DIC",
                                temperature = 10,
                                salinity = 35)$D35,
                 7.37e-10 * 10000, # Schulz & Zabel 2006 Tab. 3.1
                 tolerance = tol)
    expect_equal(calculate.Dsal(el = "DIC",
                                temperature = 25,
                                salinity = 35)$D35,
                 1.11e-9 * 10000, # Schulz & Zabel 2006 Tab. 3.1
                 tolerance = tol)
    
    expect_equal(calculate.Dsal(el = "HS",
                                temperature = 0,
                                salinity = 35)$D35,
                 9.89e-10 * 10000, # Schulz & Zabel 2006 Tab. 3.1
                 tolerance = tol)
    expect_equal(calculate.Dsal(el = "HS",
                                temperature = 10,
                                salinity = 35)$D35,
                 1.24e-9 * 10000, # Schulz & Zabel 2006 Tab. 3.1
                 tolerance = tol)
    expect_equal(calculate.Dsal(el = "HS",
                                temperature = 25,
                                salinity = 35)$D35,
                 1.61e-9 * 10000, # Schulz & Zabel 2006 Tab. 3.1
                 tolerance = tol)
})

test_that(paste("calculate.Dsal() returns Dsal values close to D35 values reported in the literature within a tolerance of", tol), {
    expect_equal(calculate.Dsal(el = "NH4",
                                temperature = 0,
                                salinity = 35)$Dsal,
                 9.03e-10 * 10000, # Schulz & Zabel 2006 Tab. 3.1
                 tolerance = tol)
    expect_equal(calculate.Dsal(el = "NH4",
                                temperature = 10,
                                salinity = 35)$Dsal,
                 1.29e-9 * 10000, # Schulz & Zabel 2006 Tab. 3.1
                 tolerance = tol)
    expect_equal(calculate.Dsal(el = "NH4",
                                temperature = 25,
                                salinity = 35)$Dsal,
                 1.85e-9 * 10000, # Schulz & Zabel 2006 Tab. 3.1
                 tolerance = tol)
    
    expect_equal(calculate.Dsal(el = "Mn",
                                temperature = 0,
                                salinity = 35)$Dsal,
                 3.02e-10 * 10000, # Schulz & Zabel 2006 Tab. 3.1
                 tolerance = tol)
    expect_equal(calculate.Dsal(el = "Mn",
                                temperature = 10,
                                salinity = 35)$Dsal,
                 4.46e-10 * 10000, # Schulz & Zabel 2006 Tab. 3.1
                 tolerance = tol)
    expect_equal(calculate.Dsal(el = "Mn",
                                temperature = 25,
                                salinity = 35)$Dsal,
                 6.57e-10 * 10000, # Schulz & Zabel 2006 Tab. 3.1
                 tolerance = tol)
    
    expect_equal(calculate.Dsal(el = "DIC",
                                temperature = 0,
                                salinity = 35)$Dsal,
                 4.81e-10 * 10000, # Schulz & Zabel 2006 Tab. 3.1
                 tolerance = tol)
    expect_equal(calculate.Dsal(el = "DIC",
                                temperature = 10,
                                salinity = 35)$Dsal,
                 7.37e-10 * 10000, # Schulz & Zabel 2006 Tab. 3.1
                 tolerance = tol)
    expect_equal(calculate.Dsal(el = "DIC",
                                temperature = 25,
                                salinity = 35)$Dsal,
                 1.11e-9 * 10000, # Schulz & Zabel 2006 Tab. 3.1
                 tolerance = tol)
    
    expect_equal(calculate.Dsal(el = "HS",
                                temperature = 0,
                                salinity = 35)$Dsal,
                 9.89e-10 * 10000, # Schulz & Zabel 2006 Tab. 3.1
                 tolerance = tol)
    expect_equal(calculate.Dsal(el = "HS",
                                temperature = 10,
                                salinity = 35)$Dsal,
                 1.24e-9 * 10000, # Schulz & Zabel 2006 Tab. 3.1
                 tolerance = tol)
    expect_equal(calculate.Dsal(el = "HS",
                                temperature = 25,
                                salinity = 35)$Dsal,
                 1.61e-9 * 10000, # Schulz & Zabel 2006 Tab. 3.1
                 tolerance = tol)
})