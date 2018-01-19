Calculate diffusion coefficients of sea water solutes
================
Marko Lipka
1/18/2018

The diffusivity *D* of solutes in sea water depends on temperature and salnity. It can be linearly interpolated from [temperature dependent theoretical values in de-ionized water](https://www.springer.com/de/book/9783540321439) and in [sea water](https://books.google.de/books/about/Diagenetic_models_and_their_implementati.html?id=kr0SAQAAIAAJ&redir_esc=y) for measured *in-situ* salinity and temperature.

Diffusivity calculation
-----------------------

*calculate.Dsal(el, temperature, salinity)* calculates for given *temperature* (in °C) and *salinity* the diffusion coefficient of a dissolved species *el*, which can be one of the following:

| Solute                        | *el*  |     | Solute                         | *el*   |
|:------------------------------|:------|-----|:-------------------------------|:-------|
| *Ca<sup>2+</sup>*             | "Ca"  |     | *PO<sub>4</sub><sup>3-</sup>*  | "PO4"  |
| *Mg<sup>+</sup>*              | "Mg"  |     | *HPO<sub>4</sub><sup>2-</sup>* | "HPO4" |
| *Na<sup>+</sup>*              | "Na"  |     | *Sr<sup>2+</sup>*              | "Sr"   |
| *K<sup>+</sup>*               | "K"   |     | *H<sub>2</sub>S*               | "H2S"  |
| *SO<sub>4</sub><sup>2-</sup>* | "SO4" |     | *HS<sup>-</sup>*               | "HS"   |
| *Ba<sup>2+</sup>*             | "Ba"  |     | *HCO<sub>3</sub><sup>-</sup>*  | "HCO3" |
| *Fe<sup>2+</sup>*             | "Fe"  |     | *NH<sub>4</sub>*               | "NH4"  |
| *Li<sup>+</sup>*              | "Li"  |     | *NO<sub>3</sub><sup>-</sup>*   | "NO3"  |
| *Mn<sup>2+</sup>*             | "Mn"  |     | *CH<sub>4</sub>*               | "CH4"  |

The function returns a list of parameters

    ##  [1] "Dsal"      "t"         "sal"       "m0"        "m1"       
    ##  [6] "D0"        "D35"       "plot.D0"   "plot.D35"  "plot.Dsal"

-   The input salinity (*sal*) and temperature (*t*) values.
-   Linear model coefficients *m0* and *m1* and calculated diffusivity *D<sub>0</sub>* at 0 salinity:
    *D<sub>0</sub>(T) = (m0 + m1 \* T) \* 10<sup>-6</sup> cm<sup>2</sup> s^-1* (Boudreau 1997).
-   Interpolated diffusivity *D<sub>35</sub>* at a salinity of 35 from a temperature-diffusivity relation in the literature (Schulz 2006).
-   Calculated diffusivity *D<sub>sal</sub>* at the given salinity, linearly interpolated from *D<sub>0</sub>* and *D<sub>35</sub>*.

and three plots showing the calculation of the three diffusivities (*D<sub>0</sub>*, *D<sub>35</sub>* and *D<sub>sal</sub>*) via linear interpolation.

### Example

![](README_files/figure-markdown_github-ascii_identifiers/example-1.png)![](README_files/figure-markdown_github-ascii_identifiers/example-2.png)![](README_files/figure-markdown_github-ascii_identifiers/example-3.png)

Salinity and temperature dependency of molecular diffusivity
------------------------------------------------------------

![](README_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-1.png)![](README_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-2.png)![](README_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-3.png)![](README_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-4.png)![](README_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-5.png)![](README_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-6.png)![](README_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-7.png)![](README_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-8.png)![](README_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-9.png)![](README_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-10.png)![](README_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-11.png)![](README_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-12.png)![](README_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-13.png)![](README_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-14.png)![](README_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-15.png)![](README_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-16.png)![](README_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-17.png)![](README_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-18.png)![](README_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-19.png)![](README_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-20.png)

Correction factors for stoichometric ratio calculations
-------------------------------------------------------

For example diffusivity ratio of *H<sub>2</sub>S* / *SO<sub>4</sub><sup>2-</sup>*:

![](README_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-4-1.png)

References
==========

Boudreau, Bernard P. 1997. *Diagenetic models and their implementation: modelling transport and reactions in aquatic sediments*. Berlin: Springer.

Schulz, Horst D. 2006. “Quantification of Early Diagenesis: Dissolved Constituents in Pore Water and Signals in the Solid Phase.” In *Marine Geochemistry*, edited by Horst D. Schulz and Matthias Zabel, 2nd ed., 1–574. Berlin, Heidelberg: Springer-Verlag.
