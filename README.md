Calculate diffusion coefficients of sea water solutes
================
Marko Lipka
1/18/2018

The diffusivity *D*<sub>*w*</sub> of solutes in free water can be linearly interpolated from [temperature dependent theoretical values in de-ionized water](https://www.springer.com/de/book/9783540321439) and in [sea water](https://books.google.de/books/about/Diagenetic_models_and_their_implementati.html?id=kr0SAQAAIAAJ&redir_esc=y) for measured *in-situ* salinity and temperature.

*calculate.Dsal(el, temperature, salinity)* returns the diffusion coefficient of dissolved species *el*
+ Ca<sup>2+</sup> ("Ca"),
+ Mg<sup>+</sup> ("Mg"),
+ Na<sup>+</sup> ("Na"),
+ K<sup>+</sup> ("K"),
+ SO<sub>4</sub><sup>2-</sup> ("SO4"),
+ Ba<sup>2+</sup> ("Ba"),
+ Fe<sup>2+</sup> ("Fe"),
+ Li<sup>+</sup> ("Li"),
+ Mn<sup>2+</sup> ("Mn"),
+ PO<sub>4</sub><sup>3-</sup> ("PO4"),
+ HPO<sub>4</sub><sup>2-</sup> ("HPO4"),
+ Sr<sup>2+</sup> ("Sr"),
+ H<sub>2</sub>S ("H2S"),
+ HS<sup>-</sup> ("HS"),
+ HCO<sub>3</sub>^- ("HCO3"),
+ H<sub>4</sub>SiO<sub>4</sub> ("H4SiO4"),
+ NH<sub>4</sub> ("NH4"),
+ NO<sub>3</sub><sup>-</sup> ("NO3"),
+ CH<sub>4</sub> ("CH4")
at a given *temperature* (in °C) and *salinity*.

    ## $Dsal
    ## [1] 3.743333e-06
    ## 
    ## $t
    ## [1] 5
    ## 
    ## $sal
    ## [1] 35
    ## 
    ## $m0
    ## [1] 3.18
    ## 
    ## $m1
    ## [1] 0.155
    ## 
    ## $D0
    ## [1] 3.955e-06
    ## 
    ## $D35
    ## [1] 3.743333e-06
    ## 
    ## $plot.D0

![](README_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-1-1.png)

    ## 
    ## $plot.D35

![](README_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-1-2.png)

    ## 
    ## $plot.Dsal

    ## Warning in qt((1 - level)/2, df): NaNs produced

![](README_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-1-3.png)

Boudreau, Bernard P. 1997. *Diagenetic models and their implementation: modelling transport and reactions in aquatic sediments*. Berlin: Springer.

Schulz, Horst D. 2006. “Quantification of Early Diagenesis: Dissolved Constituents in Pore Water and Signals in the Solid Phase.” In *Marine Geochemistry*, edited by Horst D. Schulz and Matthias Zabel, 2nd ed., 1–574. Berlin, Heidelberg: Springer-Verlag.
