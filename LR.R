# Clear environment
rm(list = ls())

library(readxl)

LR <- read_excel(choose.files(), sheet = 1)

LR$Total_spend <- LR$cardspent+LR$card2spent
View(LR)
str(LR)


#Transforming some variables to remove missing values

LR$lntollmon <- ifelse(is.na(LR$lntollmon), log(LR$tollmon + 1), LR$lntollmon)
LR$lntollten <- ifelse(is.na(LR$lntollten), log(LR$tollten + 1), LR$lntollten)
LR$lnequipmon <- ifelse(is.na(LR$lnequipmon), log(LR$equipmon + 1), LR$lnequipmon)
LR$lnequipten <- ifelse(is.na(LR$lnequipten), log(LR$equipten + 1), LR$lnequipten)
LR$lncardmon <- ifelse(is.na(LR$lncardmon), log(LR$cardmon + 1), LR$lncardmon)
LR$lncardten <- ifelse(is.na(LR$lncardten), log(LR$cardten + 1), LR$lncardten)
LR$lnwiremon <- ifelse(is.na(LR$lnwiremon), log(LR$wiremon + 1), LR$lnwiremon)
LR$lnwireten <- ifelse(is.na(LR$lnwireten), log(LR$wireten + 1), LR$lnwireten)


# user written function for creating descriptive statistics
mystats <- function(x) {
  nmiss<-sum(is.na(x))
  a <- x[!is.na(x)]
  m <- mean(a)
  md <- median(a)
  n <- length(a)
  s <- sd(a)
  min <- min(a)
  p1<-quantile(a,0.01)
  p5<-quantile(a,0.05)
  p10<-quantile(a,0.10)
  q1<-quantile(a,0.25)
  q2<-quantile(a,0.5)
  q3<-quantile(a,0.75)
  p90<-quantile(a,0.90)
  p95<-quantile(a,0.95)
  p99<-quantile(a,0.99)
  max <- max(a)
  UC <- m+3*s
  LC <- m-3*s
  outlier_flag<- max>UC | min<LC
  return(c(n=n, nmiss=nmiss, outlier_flag=outlier_flag,mean=m,median=md,stdev=s,min = min, p1=p1,p5=p5,p10=p10,q1=q1,q2=q2,q3=q3,p90=p90,p95=p95,p99=p99,max=max, UC=UC, LC=LC ))
}

vars <- c("region",	"townsize",	"gender",	"age",	"agecat",	"ed",	"edcat",	"jobcat",	"union",	"employ",	
          "empcat",	"retire",	"income",	"lninc",	"inccat",	"debtinc",	"creddebt",	"lncreddebt",	"othdebt",
          "lnothdebt",	"default",	"jobsat",	"marital",	"spoused",	"spousedcat",	"reside",	"pets",	
          "pets_cats",	"pets_dogs",	"pets_birds",	"pets_reptiles",	"pets_small",	"pets_saltfish",	
          "pets_freshfish",	"homeown",	"hometype",	"address",	"addresscat",	"cars",	"carown",	"cartype",	
          "carvalue",	"carcatvalue",	"carbought",	"carbuy",	"commute",	"commutecat",	"commutetime",	
          "commutecar",	"commutemotorcycle",	"commutecarpool",	"commutebus",	"commuterail",	
          "commutepublic",	"commutebike",	"commutewalk",	"commutenonmotor",	"telecommute",	"reason",	
          "polview",	"polparty",	"polcontrib",	"vote",	"card",	"cardtype",	"cardbenefit",	"cardfee",	
          "cardtenure",	"cardtenurecat",	"card2",	"card2type",	"card2benefit",	"card2fee",	"card2tenure",	
          "card2tenurecat",	"carditems",	"cardspent",	"card2items",	"card2spent",	"active",	"bfast",	
          "tenure",	"churn",	"longmon",	"lnlongmon",	"longten",	"lnlongten",	"tollfree",	"tollmon",	
          "lntollmon",	"tollten",	"lntollten",	"equip",	"equipmon",	"lnequipmon",	"equipten",	
          "lnequipten",	"callcard",	"cardmon",	"lncardmon",	"cardten",	"lncardten",	"wireless",	
          "wiremon",	"lnwiremon",	"wireten",	"lnwireten",	"multline",	"voice",	"pager",	"internet",	
          "callid",	"callwait",	"forward",	"confer",	"ebill",	"owntv",	"hourstv",	"ownvcr",	"owndvd",	
          "owncd",	"ownpda",	"ownpc",	"ownipod",	"owngame",	"ownfax",	"news",	"response_01",	
          "response_02",	"response_03",	"Total_spend")

diag_stats<-t(data.frame(apply(LR[vars], 2, mystats)))


# Writing Summary stats to external file

write.csv(diag_stats, "C:/Users/shashank/Documents/diag_stats.csv")


# Missing Value Imputation

LR$townsize[is.na(LR$townsize)]<- 1
LR$lncreddebt[is.na(LR$lncreddebt)]<- -0.1304535
LR$lnothdebt[is.na(LR$lnothdebt)]<- 0.6969153
LR$commutetime[is.na(LR$commutetime)]<- 25.3455382
LR$longten[is.na(LR$longten)]<- 708.8717531
LR$lnlongten[is.na(LR$lnlongten)]<- 5.6112979
LR$cardten[is.na(LR$cardten)]<- 720.4783914
LR$lncardten[is.na(LR$lncardten)]<- 4.6005067

#Outliers Treatment

LR$region[LR$region>5]<-5
LR$townsize[LR$townsize>5]<-5
LR$gender[LR$gender>1]<-1
LR$age[LR$age>76]<-76
LR$agecat[LR$agecat>6]<-6
LR$ed[LR$ed>20]<-20
LR$edcat[LR$edcat>5]<-5
LR$jobcat[LR$jobcat>6]<-6
LR$union[LR$union>1]<-1
LR$employ[LR$employ>31]<-31
LR$empcat[LR$empcat>5]<-5
LR$retire[LR$retire>1]<-1
LR$income[LR$income>147]<-147
LR$lninc[LR$lninc>4.99043258677874]<-4.99043258677874
LR$inccat[LR$inccat>5]<-5
LR$debtinc[LR$debtinc>22.2]<-22.2
LR$creddebt[LR$creddebt>6.3730104]<-6.3730104
LR$lncreddebt[LR$lncreddebt>1.85229733265072]<-1.85229733265072
LR$othdebt[LR$othdebt>11.8159808]<-11.8159808
LR$lnothdebt[LR$lnothdebt>2.46958637465373]<-2.46958637465373
LR$default[LR$default>1]<-1
LR$jobsat[LR$jobsat>5]<-5
LR$marital[LR$marital>1]<-1
LR$spoused[LR$spoused>18]<-18
LR$spousedcat[LR$spousedcat>4]<-4
LR$reside[LR$reside>5]<-5
LR$pets[LR$pets>10]<-10
LR$pets_cats[LR$pets_cats>2]<-2
LR$pets_dogs[LR$pets_dogs>2]<-2
LR$pets_birds[LR$pets_birds>1]<-1
LR$pets_reptiles[LR$pets_reptiles>0]<-0
LR$pets_small[LR$pets_small>1]<-1
LR$pets_saltfish[LR$pets_saltfish>0]<-0
LR$pets_freshfish[LR$pets_freshfish>8]<-8
LR$homeown[LR$homeown>1]<-1
LR$hometype[LR$hometype>4]<-4
LR$address[LR$address>40]<-40
LR$addresscat[LR$addresscat>5]<-5
LR$cars[LR$cars>4]<-4
LR$carown[LR$carown>1]<-1
LR$cartype[LR$cartype>1]<-1
LR$carvalue[LR$carvalue>72]<-72
LR$carcatvalue[LR$carcatvalue>3]<-3
LR$carbought[LR$carbought>1]<-1
LR$carbuy[LR$carbuy>1]<-1
LR$commute[LR$commute>8]<-8
LR$commutecat[LR$commutecat>4]<-4
LR$commutetime[LR$commutetime>35]<-35
LR$commutecar[LR$commutecar>1]<-1
LR$commutemotorcycle[LR$commutemotorcycle>1]<-1
LR$commutecarpool[LR$commutecarpool>1]<-1
LR$commutebus[LR$commutebus>1]<-1
LR$commuterail[LR$commuterail>1]<-1
LR$commutepublic[LR$commutepublic>1]<-1
LR$commutebike[LR$commutebike>1]<-1
LR$commutewalk[LR$commutewalk>1]<-1
LR$commutenonmotor[LR$commutenonmotor>1]<-1
LR$telecommute[LR$telecommute>1]<-1
LR$reason[LR$reason>9]<-9
LR$polview[LR$polview>6]<-6
LR$polparty[LR$polparty>1]<-1
LR$polcontrib[LR$polcontrib>1]<-1
LR$vote[LR$vote>1]<-1
LR$card[LR$card>4]<-4
LR$cardtype[LR$cardtype>4]<-4
LR$cardbenefit[LR$cardbenefit>4]<-4
LR$cardfee[LR$cardfee>1]<-1
LR$cardtenure[LR$cardtenure>38]<-38
LR$cardtenurecat[LR$cardtenurecat>5]<-5
LR$card2[LR$card2>5]<-5
LR$card2type[LR$card2type>4]<-4
LR$card2benefit[LR$card2benefit>4]<-4
LR$card2fee[LR$card2fee>1]<-1
LR$card2tenure[LR$card2tenure>29]<-29
LR$card2tenurecat[LR$card2tenurecat>5]<-5
LR$carditems[LR$carditems>16]<-16
LR$cardspent[LR$cardspent>782.3155]<-782.3155
LR$card2items[LR$card2items>9]<-9
LR$card2spent[LR$card2spent>419.447]<-419.447
LR$active[LR$active>1]<-1
LR$bfast[LR$bfast>3]<-3
LR$tenure[LR$tenure>72]<-72
LR$churn[LR$churn>1]<-1
LR$longmon[LR$longmon>36.7575]<-36.7575
LR$lnlongmon[LR$lnlongmon>3.60434189192823]<-3.60434189192823
LR$longten[LR$longten>2567.65]<-2567.65
LR$lnlongten[LR$lnlongten>7.85074476077837]<-7.85074476077837
LR$tollfree[LR$tollfree>1]<-1
LR$tollmon[LR$tollmon>43.5]<-43.5
LR$lntollmon[LR$lntollmon>3.77276093809464]<-3.77276093809464
LR$tollten[LR$tollten>2620.2125]<-2620.2125
LR$lntollten[LR$lntollten>7.87101070012019]<-7.87101070012019
LR$equip[LR$equip>1]<-1
LR$equipmon[LR$equipmon>49.0525]<-49.0525
LR$lnequipmon[LR$lnequipmon>3.89289112845083]<-3.89289112845083
LR$equipten[LR$equipten>2600.99]<-2600.99
LR$lnequipten[LR$lnequipten>7.86364741851974]<-7.86364741851974
LR$callcard[LR$callcard>1]<-1
LR$cardmon[LR$cardmon>42]<-42
LR$lncardmon[LR$lncardmon>3.73766961828337]<-3.73766961828337
LR$cardten[LR$cardten>2455.75]<-2455.75
LR$lncardten[LR$lncardten>7.80598376966351]<-7.80598376966351
LR$wireless[LR$wireless>1]<-1
LR$wiremon[LR$wiremon>51.305]<-51.305
LR$lnwiremon[LR$lnwiremon>3.93778812319094]<-3.93778812319094
LR$wireten[LR$wireten>2687.9225]<-2687.9225
LR$lnwireten[LR$lnwireten>7.89652368723547]<-7.89652368723547
LR$multline[LR$multline>1]<-1
LR$voice[LR$voice>1]<-1
LR$pager[LR$pager>1]<-1
LR$internet[LR$internet>4]<-4
LR$callid[LR$callid>1]<-1
LR$callwait[LR$callwait>1]<-1
LR$forward[LR$forward>1]<-1
LR$confer[LR$confer>1]<-1
LR$ebill[LR$ebill>1]<-1
LR$owntv[LR$owntv>1]<-1
LR$hourstv[LR$hourstv>28]<-28
LR$ownvcr[LR$ownvcr>1]<-1
LR$owndvd[LR$owndvd>1]<-1
LR$owncd[LR$owncd>1]<-1
LR$ownpda[LR$ownpda>1]<-1
LR$ownpc[LR$ownpc>1]<-1
LR$ownipod[LR$ownipod>1]<-1
LR$owngame[LR$owngame>1]<-1
LR$ownfax[LR$ownfax>1]<-1
LR$news[LR$news>1]<-1
LR$response_01[LR$response_01>1]<-1
LR$response_02[LR$response_02>1]<-1
LR$response_03[LR$response_03>1]<-1
LR$Total_spend[LR$Total_spend>1145.1465]<-1145.1465
LR$region[LR$region<1]<-1
LR$townsize[LR$townsize<1]<-1
LR$gender[LR$gender<0]<-0
LR$age[LR$age<20]<-20
LR$agecat[LR$agecat<2]<-2
LR$ed[LR$ed<9]<-9
LR$edcat[LR$edcat<1]<-1
LR$jobcat[LR$jobcat<1]<-1
LR$union[LR$union<0]<-0
LR$employ[LR$employ<0]<-0
LR$empcat[LR$empcat<1]<-1
LR$retire[LR$retire<0]<-0
LR$income[LR$income<13]<-13
LR$lninc[LR$lninc<2.56494935746154]<-2.56494935746154
LR$inccat[LR$inccat<1]<-1
LR$debtinc[LR$debtinc<1.9]<-1.9
LR$creddebt[LR$creddebt<0.101088]<-0.101088
LR$lncreddebt[LR$lncreddebt< -2.29160361221836]<- -2.29160361221836
LR$othdebt[LR$othdebt<0.2876923]<-0.2876923
LR$lnothdebt[LR$lnothdebt<1.24348344030873]<- -1.24348344030873
LR$default[LR$default<0]<-0
LR$jobsat[LR$jobsat<1]<-1
LR$marital[LR$marital<0]<-0
LR$spoused[LR$spoused<1]<- -1
LR$spousedcat[LR$spousedcat<1]<- -1
LR$reside[LR$reside<1]<-1
LR$pets[LR$pets<0]<-0
LR$pets_cats[LR$pets_cats<0]<-0
LR$pets_dogs[LR$pets_dogs<0]<-0
LR$pets_birds[LR$pets_birds<0]<-0
LR$pets_reptiles[LR$pets_reptiles<0]<-0
LR$pets_small[LR$pets_small<0]<-0
LR$pets_saltfish[LR$pets_saltfish<0]<-0
LR$pets_freshfish[LR$pets_freshfish<0]<-0
LR$homeown[LR$homeown<0]<-0
LR$hometype[LR$hometype<1]<-1
LR$address[LR$address<1]<-1
LR$addresscat[LR$addresscat<1]<-1
LR$cars[LR$cars<0]<-0
LR$carown[LR$carown<1]<- -1
LR$cartype[LR$cartype<1]<- -1
LR$carvalue[LR$carvalue<1]<- -1
LR$carcatvalue[LR$carcatvalue<1]<- -1
LR$carbought[LR$carbought<1]<- -1
LR$carbuy[LR$carbuy<0]<-0
LR$commute[LR$commute<1]<-1
LR$commutecat[LR$commutecat<1]<-1
LR$commutetime[LR$commutetime<16]<-16
LR$commutecar[LR$commutecar<0]<-0
LR$commutemotorcycle[LR$commutemotorcycle<0]<-0
LR$commutecarpool[LR$commutecarpool<0]<-0
LR$commutebus[LR$commutebus<0]<-0
LR$commuterail[LR$commuterail<0]<-0
LR$commutepublic[LR$commutepublic<0]<-0
LR$commutebike[LR$commutebike<0]<-0
LR$commutewalk[LR$commutewalk<0]<-0
LR$commutenonmotor[LR$commutenonmotor<0]<-0
LR$telecommute[LR$telecommute<0]<-0
LR$reason[LR$reason<1]<-1
LR$polview[LR$polview<2]<-2
LR$polparty[LR$polparty<0]<-0
LR$polcontrib[LR$polcontrib<0]<-0
LR$vote[LR$vote<0]<-0
LR$card[LR$card<1]<-1
LR$cardtype[LR$cardtype<1]<-1
LR$cardbenefit[LR$cardbenefit<1]<-1
LR$cardfee[LR$cardfee<0]<-0
LR$cardtenure[LR$cardtenure<1]<-1
LR$cardtenurecat[LR$cardtenurecat<1]<-1
LR$card2[LR$card2<1]<-1
LR$card2type[LR$card2type<1]<-1
LR$card2benefit[LR$card2benefit<1]<-1
LR$card2fee[LR$card2fee<0]<-0
LR$card2tenure[LR$card2tenure<1]<-1
LR$card2tenurecat[LR$card2tenurecat<1]<-1
LR$carditems[LR$carditems<5]<-5
LR$cardspent[LR$cardspent<91.3045]<-91.3045
LR$card2items[LR$card2items<1]<-1
LR$card2spent[LR$card2spent<14.8195]<-14.8195
LR$active[LR$active<0]<-0
LR$bfast[LR$bfast<1]<-1
LR$tenure[LR$tenure<4]<-4
LR$churn[LR$churn<0]<-0
LR$longmon[LR$longmon<2.9]<-2.9
LR$lnlongmon[LR$lnlongmon<1.06471073699243]<-1.06471073699243
LR$longten[LR$longten<12.62]<-12.62
LR$lnlongten[LR$lnlongten<2.53527150100047]<-2.53527150100047
LR$tollfree[LR$tollfree<0]<-0
LR$tollmon[LR$tollmon<0]<-0
LR$lntollmon[LR$lntollmon<0]<-0
LR$tollten[LR$tollten<0]<-0
LR$lntollten[LR$lntollten<0]<-0
LR$equip[LR$equip<0]<-0
LR$equipmon[LR$equipmon<0]<-0
LR$lnequipmon[LR$lnequipmon<0]<-0
LR$equipten[LR$equipten<0]<-0
LR$lnequipten[LR$lnequipten<0]<-0
LR$callcard[LR$callcard<0]<-0
LR$cardmon[LR$cardmon<0]<-0
LR$lncardmon[LR$lncardmon<0]<-0
LR$cardten[LR$cardten<0]<-0
LR$lncardten[LR$lncardten<0]<-0
LR$wireless[LR$wireless<0]<-0
LR$wiremon[LR$wiremon<0]<-0
LR$lnwiremon[LR$lnwiremon<0]<-0
LR$wireten[LR$wireten<0]<-0
LR$lnwireten[LR$lnwireten<0]<-0
LR$multline[LR$multline<0]<-0
LR$voice[LR$voice<0]<-0
LR$pager[LR$pager<0]<-0
LR$internet[LR$internet<0]<-0
LR$callid[LR$callid<0]<-0
LR$callwait[LR$callwait<0]<-0
LR$forward[LR$forward<0]<-0
LR$confer[LR$confer<0]<-0
LR$ebill[LR$ebill<0]<-0
LR$owntv[LR$owntv<1]<-1
LR$hourstv[LR$hourstv<12]<-12
LR$ownvcr[LR$ownvcr<0]<-0
LR$owndvd[LR$owndvd<0]<-0
LR$owncd[LR$owncd<0]<-0
LR$ownpda[LR$ownpda<0]<-0
LR$ownpc[LR$ownpc<0]<-0
LR$ownipod[LR$ownipod<0]<-0
LR$owngame[LR$owngame<0]<-0
LR$ownfax[LR$ownfax<0]<-0
LR$news[LR$news<0]<-0
LR$response_01[LR$response_01<0]<-0
LR$response_02[LR$response_02<0]<-0
LR$response_03[LR$response_03<0]<-0
LR$Total_spend[LR$Total_spend<133.106]<-133.106


#Transforming dependent variable to make it normal

hist(LR$Total_spend)
hist(log(LR$Total_spend))

LR$ln_Total_spend<- log(LR$Total_spend)

#ANOVA TEST TO FILTER UNWANTED CATEGORICAL VARIABLES (Significance level = 95%)

LR_1 <- aov(ln_Total_spend ~ region+townsize+gender+agecat+edcat+jobcat+union+empcat+retire+
              inccat+default+jobsat+marital+spousedcat+pets_cats+pets_dogs+
              pets_birds+pets_reptiles+pets_small+pets_saltfish+pets_freshfish+
              homeown+hometype+addresscat+cars+carown+cartype+carcatvalue+
              carbought+carbuy+commute+commutecat+commutecar+commutemotorcycle+
              commutecarpool+commutebus+commuterail+commutepublic+commutebike+
              commutewalk+commutenonmotor+telecommute+reason+polview+polparty+
              polcontrib+vote+card+cardtype+cardbenefit+cardfee+cardtenurecat+
              card2+card2type+card2benefit+card2fee+card2tenurecat+active+
              bfast+churn+callcard+wireless+multline+voice+pager+internet+
              callid+callwait+forward+confer+ebill+owntv+ownvcr+owndvd+
              owncd+ownpda+ownpc+ownipod+owngame+ownfax+news+response_01+
              response_02+response_03, data = LR )

summary(LR_1)

#Performing Stepwise regression on full dataset including continuous & filtered cat. Vars, (95 % sig. level)

fit <- lm(ln_Total_spend ~ region+gender+agecat+edcat+empcat+retire+
            inccat+card+card2+internet+ownvcr+owndvd+response_03+
            age+ed+employ+lninc+debtinc+lnothdebt+spoused+reside+
            pets+address+carvalue+cardtenure+card2tenure+tenure+hourstv+
            commutetime+lnlongmon+lnlongten+tollmon+tollten+equipmon+
            equipten+cardmon+cardten+wiremon+wireten+income+creddebt+
            othdebt+longmon+longten+tollfree+lntollmon+lntollten+equip+
            lnequipmon+lnequipten+lncardmon+lncardten+lnwiremon+lnwireten, data = LR)

summary(fit) 
require(MASS)
step<- stepAIC(fit,direction="both")


#Declaring significant categorical variables (with more than 2 levels) as factors

factors <- c("region", "card", "card2", "internet")
LR[, factors] <- lapply(LR[, factors], factor)   

#Creating Dummies of the above transformed factor variables using caret package

library(caret)

dummies <- predict(dummyVars(~region, data=LR), newdata = LR)
dummies1 <- predict(dummyVars(~card, data = LR), newdata = LR)
dummies2 <- predict(dummyVars(~card2, data = LR), newdata = LR)
dummies3 <- predict(dummyVars(~internet, data = LR), newdata = LR)

LR <- cbind(LR, dummies, dummies1, dummies2, dummies3)


#Splitting data into Training and Testing Dataset

set.seed(123)
train <- sample(1:nrow(LR), size = floor(0.70 * nrow(LR)))

Dev<-LR[train,]
Val<-LR[-train,]

#Defining cook's distance for all significant variable

fit2 <- lm(ln_Total_spend ~ region.1 + region.2 + region.3 + region.4 + gender + 
             card.1 + card.2 + card.3 + card2.1 + card2.2 + card2.3 + card2.4 + 
             internet.0 + internet.1 + internet.2 + internet.3 + response_03 + lninc, data = Dev)

summary(fit2)

#ITERATION - 1

d <- cooks.distance(fit2)
r <- stdres(fit2)
Dev1 <- cbind(Dev, d, r)


Dev1 <- subset(Dev1, d < 4/3500) 


fit3 <- lm(ln_Total_spend ~ region.1 + region.2 + region.3 + region.4 + gender + 
             card.1 + card.2 + card.3 + card2.1 + card2.2 + card2.3 + card2.4 + 
             internet.0 + internet.1 + internet.2 + internet.3 + response_03 + lninc, data = Dev1)

summary(fit3)

stepAIC(fit3, direction = "both")

#Multicollinierity Check using VIF
library(car)
vif(fit3)


#ITERATION - 2

fit3_1 <- lm(ln_Total_spend ~ region.1 + region.2 + region.3 + 
               region.4 + gender + card.1 + card.2 + card.3 + card2.1 + 
               card2.2 + card2.3 + card2.4 + internet.0 + internet.1 + internet.2 + 
               lninc, data = Dev1)

d1 <- cooks.distance(fit3_1)
r1 <- stdres(fit3_1)
Dev2 <- cbind(Dev1, d1, r1)

Dev2 <- subset(Dev2, d1 < 4/3361) 


fit4 <- lm(ln_Total_spend ~ region.1 + region.2 + region.3 + 
             region.4 + gender + card.1 + card.2 + card.3 + card2.1 + 
             card2.2 + card2.3 + card2.4 + internet.0 + internet.1 + internet.2 + 
             lninc, data = Dev2)

summary(fit4)

stepAIC(fit4, direction = "both")

vif(fit4)

#ITERATION - 3

fit4_1 <- lm(ln_Total_spend ~ region.3 + gender + card.1 + card.2 + 
               card.3 + card2.1 + card2.2 + card2.3 + card2.4 + internet.0 + 
               internet.1 + internet.2 + lninc, data = Dev2)

d2 <- cooks.distance(fit4_1)
r2 <- stdres(fit4_1)
Dev3 <- cbind(Dev2, d2, r2)

Dev3 <- subset(Dev3, d2 < 4/3272)


fit5 <- lm(ln_Total_spend ~ region.3 + gender + card.1 + card.2 + 
             card.3 + card2.1 + card2.2 + card2.3 + card2.4 + internet.0 + 
             internet.1 + internet.2 + lninc, data = Dev3)

summary(fit5)

stepAIC(fit5, direction = "both")

vif(fit5)

#Analysis

t1<-cbind(Dev, pred_spend = exp(predict(fit5, Dev)))
names(t1)
t1<- transform(t1, APE = abs(pred_spend - Total_spend)/Total_spend)
mean(t1$APE)
View(t1)

t2<-cbind(Val, pred_spend=exp(predict(fit5,Val)))
t2<- transform(t2, APE = abs(pred_spend - Total_spend)/Total_spend)
mean(t2$APE)
View(t2)

#Decile Analysis - t1(Development)

# find the decile locations 
decLocations <- quantile(t1$pred_spend, probs = seq(0.1,0.9,by=0.1))

# use findInterval with -Inf and Inf as upper and lower bounds
t1$decile <- findInterval(t1$pred_spend,c(-Inf,decLocations, Inf))

require(sqldf)
t1_DA <- sqldf("select decile, count(decile) as count, avg(pred_spend) as avg_pre_spend,   
               avg(Total_spend) as avg_Actual_spend
               from t1
               group by decile
               order by decile desc")

View(t1_DA)
write.csv(t1_DA,"C:/Users/shashank/Documents/Development_Decliles.csv")


#Decile Analysis - t2(Validation)

# find the decile locations 
decLocations <- quantile(t2$pred_spend, probs = seq(0.1,0.9,by=0.1))

# use findInterval with -Inf and Inf as upper and lower bounds
t2$decile <- findInterval(t2$pred_spend,c(-Inf,decLocations, Inf))

require(sqldf)
t2_DA <- sqldf("select decile, count(decile) as count, avg(pred_spend) as avg_pre_spend,   
               avg(Total_spend) as avg_Actual_spend
               from t2
               group by decile
               order by decile desc")

View(t2_DA)
write.csv(t2_DA,"C:/Users/Shashank/Documents/Validation_Deciles.csv")


# Other useful functions 

coefficients(fit5) # model coefficients
confint(fit5, level=0.95) # CIs for model parameters 
fitted(fit5) # predicted values
residuals(fit5) # residuals
anova(fit5) # anova table 
influence(fit5) # regression diagnostics

# diagnostic plots 
layout(matrix(c(1,2,3,4),2,2)) # optional 4 graphs/page 
plot(fit5)

### END ###








