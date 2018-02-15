### D_Sal calculation from T, Sal, D0 and D35 using Literature Data from Boudreau and Schulz & Zabel
#setwd("~/Dropbox/IOW/R-functions/Dsal")
require("ggplot2")

# reading list of constants for later calculations of diffusion coefficients
Boudreau.m   <- read.csv(file = "Boudreau97_linregcoef_D0.csv", sep = ",", dec = ".", header = TRUE, stringsAsFactors = FALSE, comment.char = "#")  # D0 per T and element Table
Schulz.Zabel <- read.csv(file = "SchulzZabel_D35.csv",          sep = ",", dec = ".", header = TRUE, stringsAsFactors = FALSE)  # D35 per T and element Table

calculate.Dsal <- function(el = "Mn", temperature = 5, salinity = 35){
    if(salinity > 35){
        #salinity <- 35.0 ## clipping of Sal > 35 to prevent extrapolation Dsal calculation (3rd step)
        warning("Salinity out of valid range (0 - 35)!")}
    if(salinity < 0){
        stop("Salinity out of valid range (0 - 35)!")}
    if(temperature > 25){
        warning("Temperature out of valid range (0 - 25)!")}
    if(temperature < 0){
        stop("Temperature out of valid range (0 - 25)!")}
    
    # 1. Diffusion-Coef at 0psu:  D_0psu(t) = (m0+m1 * t)*10^-6 cm^2 s^-1 (Boudreau 1997)
    m0 <- Boudreau.m[Boudreau.m$X=="m0", el]
    m1 <- Boudreau.m[Boudreau.m$X=="m1", el]
    D0 <- (m0 + m1 * temperature) * 1e-6 # in cm^2 / s
    x  <- c(0,25)
    fun<- function(x){(m0 + m1 * x) * 1e-6}
    y <- fun(x)
    plot.D0 <- qplot(x=x, y=y,
                     geom   = "line",
                     xlab   ="T [°C]",
                     ylab   = bquote("D0("*.(el)*") ="~.(m1)%.%"T"+.(m0)~"["*cm^2/s*"]")) +
        theme_bw() +
        geom_hline(yintercept=D0, linetype="dashed")+
        geom_vline(xintercept=temperature, linetype="dashed") +
        annotate(geom = "point", x = temperature, y = D0, color = "red") +
        ggtitle("D0 calculation (Boudreau et al, 1997)") +
        annotate(geom="text", x=temperature, y=D0,
                 label=paste("D0 =", format(D0, digits= 4)),
                 vjust=1.2, size=3.5, hjust = "inward")
    
    # 2. Diffusion-Coef at 35psu:  D_35psu(t) from literature data (Schulz und Zabel 2006)
    formula <- Schulz.Zabel[, el]~Schulz.Zabel$T
    n       <- lm(formula=formula)
    D35     <- n$coefficients[1] + n$coefficients[2] * temperature # in cm^2 / s (Werte in Literatur in m²/s angegeben, in Schulz.Zabel-Tabelle liegen die Werte in cm²/s vor)
    
    plot.D35 <- qplot(data = Schulz.Zabel, x=T, y=Schulz.Zabel[,el],
                      xlab = "T [°C]",
                      ylab = bquote("D35("~.(el)~") ["~cm^2/s~"]"),
                      geom = "point") +
        geom_smooth(method = "lm", color = "black") +
        theme_bw() +
        ggtitle("D35 calculation (Schulz and Zabel, 2006)") +
        geom_hline(yintercept=D35, linetype="dashed") +
        geom_vline(xintercept=temperature, linetype="dashed") +
        geom_point(x = temperature, y = D35, color = "red") +
        annotate(geom="text", x=temperature, y=D35,
                 label=paste("D35 =", format(D35, digits=4)),
                 vjust=1.2, size=3.5, hjust = "inward")
    
    
    # 3. Dif-Coef at insitu salinity: linear regression of (1) and (2): D(sal) = m * sal + D0
    z <- lm(c(D0, D35)~c(0, 35))
    Dsal <- z$coefficients[1] + z$coefficients[2] * salinity # in cm^2 / s
    
    plot.Dsal <- qplot(x    = c(0,35), y=c(D0,D35),
                       xlab = "Sal [psu]",
                       ylab = bquote("Dsal("~.(el)~") ["~cm^2/s~"]"),
                       geom = "line") +
        geom_point(col="red") +
        theme_bw() +
        ggtitle("Dsal calculation (lin. regr.: D0, D35)") +
        geom_hline(yintercept=Dsal, linetype="dashed") +
        geom_vline(xintercept=salinity, linetype="dashed") +
        annotate(geom="text", x=15, y=Dsal, label=paste("Dsal =", format(Dsal, digits=4)),
                 vjust=1.2, hjust = "inward", size=3.5)
    
    return( list( Dsal = as.numeric(Dsal),
                  t  = temperature,
                  sal= salinity,
                  m0 = m0,
                  m1 = m1,
                  D0 = D0,
                  D35= as.numeric(D35),
                  plot.D0  = plot.D0,
                  plot.D35 = plot.D35,
                  plot.Dsal= plot.Dsal )
    )
}

library(scales)
### sal and temp dependency of molecular diffusivity
Dsal.TSdep <- function(element = "DIC"){
    Temp <- 0:25
    Sal  <- 0:35
    Dsal.matrix <- data.frame(Temp = NULL, Sal = NULL, Dsal = NULL)
    for(t in Temp){
        for(s in Sal){
            Dsal.matrix <- rbind(Dsal.matrix, data.frame(Temp = t,
                                                         Sal = s,
                                                         Dsal = calculate.Dsal(el = element, temperature = t, salinity = s)$Dsal * 86400))
        }
    }
    
    library(viridis)
    ggplot(Dsal.matrix,
           aes(x = Temp,
               y = Sal,
               fill = Dsal,
               z = Dsal,
               label = format(Dsal,  scientific = TRUE, digits = 2))) +
        geom_tile() +
        geom_text(size = 2, colour = "darkgrey") +
        scale_fill_viridis(name = bquote(D[sal] ~ bgroup("[",frac(cm^2,d),"]"))) +
        scale_x_continuous(breaks =  Temp) +
        scale_y_continuous(breaks = Sal) +
        xlab("Temperature [°C]") +
        ylab("Salinity [PSU]") +
        ggtitle(paste(element, "diffusion coefficients in sea water")) +
        theme_classic() +
        theme(legend.position = "right", legend.key.width = unit(3, "line")) 
    #ggsave(filename = paste0(element, "TempSaldependency.pdf"))
}
#Dsal.TSdep()

### get correction factor for stoichometric ratio calculations
Dsal.element.ratios <- function(ely = "DIC", elx = "SO4"){
    Dsal.ratio <- function(el1 = ely, el2 = elx, Temp = 20, Sal = 35){
        Dsal1 <- calculate.Dsal(el1, temperature = Temp, salinity = Sal)$Dsal
        Dsal2 <- calculate.Dsal(el2, temperature = Temp, salinity = Sal)$Dsal
        return(Dsal1/Dsal2)
    }
    
    Temp <- 0:25
    Sal  <- 0:35
    
    ratios <- data.frame(Temp = NULL, Sal = NULL, ratio = NULL)
    for(t in Temp){
        for(s in Sal){
            ratios <- rbind(ratios, data.frame(Temp = t,
                                               Sal = s,
                                               ratio = Dsal.ratio(el1 = ely, el2 = elx, Temp = t, Sal = s)))
        }
    }
    
    library(viridis)
    ggplot(ratios, aes(x = Temp, y = Sal, fill = ratio, z = ratio, label = format(ratio, digits = 4))) +
        geom_tile() +
        geom_text(size = 2, colour = "darkgrey") +
        scale_fill_viridis(name = bquote(frac(D[sal] ~ (.(ely)), D[sal] ~ (.(elx))))) +
        ggtitle(paste0("Dsal ratio ", ely, " / ", elx)) +
        scale_x_continuous(breaks =  Temp) +
        scale_y_continuous(breaks = Sal) +
        xlab("Temperature [°C]") +
        ylab("Salinity [PSU]") +
        theme_classic() +
        theme(legend.position = "right", legend.key.width = unit(3, "line"))
    #ggsave(filename = paste0("Dsal ratio", ely, "_", elx, ".pdf"))
}
#Dsal.element.ratios(ely = "CO2", elx = "SO4")

