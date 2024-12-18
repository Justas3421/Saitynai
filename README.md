

# Projekto pavadinimas: #
„Nuomojamų objektų valdymo sistema“ 

# Sprendžiamo uždavinio aprašymas: #
Sistemos tikslas – sukurti efektyvią ir patogią platformą, skirtą nuomojamų objektų (namų, butų, kambarių) valdymui. 
Sistema leis nuomotojams lengvai administruoti savo objektus, valdyti susijusią informaciją.
Administratoriai turės pilną prieigą prie visų sistemos objektų, galės prižiūrėti ir valdyti sistemos veiklą.
Svečiai galės peržiūrėti viešai prieinamus nuomos objektus, o autentifikuoti vartotojai (nariai) – atlikti platesnius veiksmus, priklausomai nuo jų rolės.
Sistema užtikrins saugią autentifikaciją ir autorizaciją, naudojant JWT, užtikrinant vartotojų duomenų saugumą ir jų prieigą prie tinkamų sistemos funkcijų pagal jų rolę (svečias, narys, administratorius).

# Funkciniai reikalavimai #

### Funkciniai reikalavimai:

#### 1. **Autentifikacija ir autorizacija**  
1.1. Sistema turi užtikrinti saugią vartotojų autentifikaciją naudojant JWT (JSON Web Tokens).  
1.2. Kiekvienas vartotojas turi turėti prieigą tik prie savo rolės numatytų funkcijų.  
1.3. Sistema turi palaikyti trijų tipų roles:  
- **Svečias**: vartotojai be autentifikacijos.  
- **Narys**: autentifikuoti vartotojai.  
- **Administratorius**: vartotojai su pilna prieiga prie sistemos funkcijų.  


#### 2. **Nuomos objektų valdymas**  
2.1. Nuomotojai turi turėti galimybę:  
- Sukurti naujus nuomos objektus.  
- Redaguoti esamus nuomos objektus.  
- Trinti savo nuomos objektus.  
- Matyti savo objektų sąrašą ir detalią informaciją apie juos.
  
2.2. Administratoriai turi turėti pilną prieigą prie visų nuomos objektų, galėdami juos:  
- Peržiūrėti.  
- Redaguoti.  
- Trinti, jei reikia.  

#### 3. **Informacijos valdymas ir peržiūra**  
3.1. Vartotojai be autentifikacijos (svečiai) gali:  
- Peržiūrėti viešai prieinamus nuomos objektus.  

#### 4. **Sistemos administravimas**  
4.1. Administratoriai gali valdyti vartotojus    

#### 5. **Saugumas**  
5.1. Prieiga prie API turi būti apsaugota nuo neautorizuotų užklausų.  
5.3. Autorizacija turi būti vykdoma pagal vartotojo rolę, užtikrinant, kad kiekvienas vartotojas turi prieigą tik prie savo rolės funkcionalumo.  

#### 6. **Naudotojų profiliai**  
6.1. Nariai turi turėti galimybę peržiūrėti ir redaguoti savo profilio informaciją (pvz., vardą).  

#### 7. **Sąsajos ir vartotojo patirtis**  
7.1. Sistema turi būti pritaikyta tiek mobiliems telefonams, tiek planšetėms.  
7.2. Sąsaja turi būti intuityvi ir naudotojams lengvai suprantama.  

# Architektūros diagrama #

Diegimo diagrama
![DeployementDiagram](https://github.com/Justas3421/Saitynai/blob/main/deployement_diagram.png)

Paketų diagrama
![PackageDiagram](https://github.com/Justas3421/Saitynai/blob/main/package_diagram.png)

# Sąsajų specifikacija #
[OpenAPI Documentation](Landlords/Rest_API/OpenAPI.yml)

# Darbo išvados #
Projekto „Nuomojamų objektų valdymo sistema“ realizacija buvo sėkmingai įgyvendinta, užtikrinant užsibrėžtų tikslų pasiekimą. Sistema suteikia intuityvią ir efektyvią platformą, skirtą valdyti nuomojamus objektus.
