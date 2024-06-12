library(tidyverse)
dir(recursive = T, pattern = "Sport") -> filename
filename %>% readxl::excel_sheets() %>% sapply(\(x){readxl::read_excel(filename, sheet=x)}) -> L
L$Coaches$FirstName

# tutorial 9 - naloge A

# 1. Vrni stolpec z ekipami in stolpec s stevilom igralcev v vsaki ekipi
L$Players %>% 
  inner_join(L$Teams, by=c("TeamID"="TeamID")) %>%
  select(Nickname) %>%
  group_by(Nickname) %>%
  count() # ali summarise(st.igralcev = n())

# 2. Kateri igralci nosijo vsaj delno moder dres? Vrni ime in priimek.
L$Players %>% 
  inner_join(L$Teams, by=c("TeamID"="TeamID")) %>%
  select(contains("stName"), Colors) %>%
  filter(grepl("[Bb]lue", Colors))

# naloge B: 1. Katere ekipe so igrale na dan 2005-09-12?  
L$Teams %>% 
  inner_join(L$Games, by=c("TeamID"="HomeTeamID")) %>%
  inner_join(L$Teams, by=c("VisitTeamID"="TeamID")) %>%
  select(Domaci=Nickname.x, Gosti=Nickname.y, DatePlayed) %>%
  filter(as.character(DatePlayed)=="2005-09-12") -> B1

# 2. Uporabi pivot_longer ali gather in vrni 1. stolpec z vrednostmi “domača” ali “gostujoča” in 2. stolpec z imeni ekip. 
B1 %>% pivot_longer(1:2, names_to = "Ime", values_to = "Ekipa")
B1 %>% gather("Ime", "Ekipa", 1:2)

# naloge C: 1.  Naredi tabelo ekipe x ekipe z NA če niso igrale, in datumom tekme drugače. Uporabi pivot_wider ali spread.
L$Teams %>% 
  inner_join(L$Games, by=c("TeamID"="HomeTeamID")) %>%
  inner_join(L$Teams, by=c("VisitTeamID"="TeamID")) %>%
  select(Domaci=Nickname.x, Gosti=Nickname.y, DatePlayed) %>%
  pivot_wider(names_from = Gosti, values_from = DatePlayed) -> C1
# uredimo da so enako po vrsti:
C1 %>% arrange(Domaci) %>%
  rename(Adomaci=Domaci)  %>%
  .[, order(colnames(.))]
C1 %>% arrange(Domaci) %>%
  as.data.frame() %>%
  {rownames(.) <- .$Domaci;.[,-1]} %>%
  .[,order(colnames(.))] %>%
  rownames_to_column()
C1 %>% arrange(Domaci) %>%
  .[,c(1, order(colnames(.)[-1])+1)]
# lazje pa ce damo spread
L$Teams %>% 
  inner_join(L$Games, by=c("TeamID"="HomeTeamID")) %>%
  inner_join(L$Teams, by=c("VisitTeamID"="TeamID")) %>%
  select(Domaci=Nickname.x, Gosti=Nickname.y, DatePlayed) %>%
  spread(Gosti, DatePlayed)
# naredimo simetricno
L$Teams %>% 
  inner_join(L$Games, by=c("TeamID"="HomeTeamID")) %>%
  inner_join(L$Teams, by=c("VisitTeamID"="TeamID")) %>%
  select(Domaci=Nickname.x, Gosti=Nickname.y, DatePlayed) -> C1.1
C1.1 %>% 
  rename(Gosti = Domaci, Domaci = Gosti) %>%
  rbind(C1.1) %>%
  spread(Gosti, DatePlayed) %>%
  view()

# 2. Napiši funkcijo z uporabo case_when, ki za dve vhodne numerične vrednosti, vrne 3 če je prva>druga, 
# vrne 1 če prva=druga in vrne 0 drugače.
funk <- \(x,y){case_when(x>y~3, x==y~1, T~0)}
funk(1:5, 5:1)

# naloge D: 2. Za vsako ekipo vrni skupno število točk od vseh tekem, kjer je zmaga vredna 3, remi 1 in poraz 0. 
# Uporabi user defined function iz prejšnje naloge skupaj z rowwise().
L$Teams %>% 
  inner_join(L$Games, by=c("TeamID"="HomeTeamID")) %>%
  inner_join(L$Teams, by=c("VisitTeamID"="TeamID")) %>%
  select(Domaci=Nickname.x, Gosti=Nickname.y, contains("score")) %>%
  mutate(DomTocke = funk(HomeScore, VisitScore), 
         GostTocke = funk(VisitScore, HomeScore)) %>%
  .[,-3:-4] %>% 
  {data.frame(Ekipe=c(.$Domaci, .$Gosti), Tocke=c(.$DomTocke, .$GostTocke))} %>%
  summarise(Skupaj = sum(Tocke), .by = Ekipe) %>%
  arrange(desc(Skupaj))

# 1. Koliko tekem je vsak Coach odigral doma?
L$Coaches %>% 
  inner_join(L$Games, by = c("TeamID" = "HomeTeamID"), relationship = "many-to-many") %>% #da ni warninga
  group_by(CoachID, FirstName, LastName) %>%
  summarise(n())
# kaj pa ce hocemo za vse coache?
L$Coaches %>% 
  left_join(L$Games, by = c("TeamID" = "HomeTeamID"), relationship = "many-to-many") %>% #da ni warninga
  select(2,3,10,11) %>%
  group_by(FirstName, LastName) %>%
  summarise(St.tekem = sum(!is.na(TeamID)))


